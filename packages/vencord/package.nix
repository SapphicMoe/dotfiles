{
  lib,
  stdenv,
  stdenvNoCC,
  fetchgit,
  fetchurl,
  jq,
  moreutils,
  nodePackages,
  nodejs,
  cacert,
}: let
  gitHash = "1807d6073136f63d3c19342682c193ae82d9b8ae";
in
  stdenv.mkDerivation rec {
    pname = "owo-vencord";
    version = builtins.substring 0 8 gitHash;

    src = fetchgit {
      url = "https://git.skye.vg/me/owo-vencord.git";
      rev = gitHash;
      sha256 = "sha256-yeZX8bv1+1H2w9G4R9UUlhOvardGNPUwVkD1t+a3yWo=";
    };

    pnpmDeps =
      assert lib.versionAtLeast nodePackages.pnpm.version "8.10.0";
      stdenvNoCC.mkDerivation {
      pname = "${pname}-pnpm-deps";
      inherit src version;

      nativeBuildInputs = [
        jq
        moreutils
        nodePackages.pnpm
        cacert
      ];

      installPhase = ''
        runHook preInstall
        export HOME=$(mktemp -d)
        pnpm config set store-dir $out
        # pnpm is going to warn us about using --force
        # --force allows us to fetch all dependencies including ones that aren't meant for our host platform
        pnpm install --frozen-lockfile --ignore-script --force
        runHook postInstall
      '';

      fixupPhase = ''
        runHook preFixup
        rm -rf $out/v3/tmp
        for f in $(find $out -name "*.json"); do
          sed -i -E -e 's/"checkedAt":[0-9]+,//g' $f
          jq --sort-keys . $f | sponge $f
        done
        runHook postFixup
      '';

      dontConfigure = true;
      dontBuild = true;
      outputHashMode = "recursive";
      outputHash = "sha256-w6IfL3vHWzWp1lKX7g49u5LHO3Kf2BbjtGuLXmhD724=";
    };

    VENCORD_HASH = gitHash;
    VENCORD_REMOTE = "vgskye/owo-vencord";

    nativeBuildInputs = [
      jq
      nodePackages.pnpm
      nodejs
    ];

    richerCider = fetchurl {
      url = "https://raw.githubusercontent.com/ciderapp/RicherCider-Vencord/main/richerCider.desktop.tsx";
      hash = "sha256-qHhe9+ANuFJC78x09R1jLuKDjH+uvhsn2YUk93NyV8o=";
    };

    preBuild = ''
      export HOME=$(mktemp -d)
      export STORE_PATH=$(mktemp -d)

      cp -Tr "$pnpmDeps" "$STORE_PATH"
      chmod -R +w "$STORE_PATH"

      cp $richerCider src/plugins/richerCider.desktop.tsx

      pnpm config set store-dir "$STORE_PATH"
      pnpm install --offline --frozen-lockfile --ignore-script
    '';

    postBuild = ''
      pnpm build
    '';

    installPhase = ''
      runHook preInstall

      cp -r dist/ $out

      runHook postInstall
    '';

    passthru = {
      inherit pnpmDeps;
    };

    meta = with lib; {
      description = "Vencord but patch";
      homepage = "https://git.skye.vg/me/owo-vencord";
      license = licenses.gpl3Only;
      maintainers = with maintainers; [vgskye];
    };
  }