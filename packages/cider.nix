{
  lib,
  appimageTools,
  fetchurl,
  makeWrapper,
  requireFile,
}:
let
  version = "2.5.0";
  pname = "cider";
  src = requireFile rec {
    name = "Cider-linux-appimage-x64.AppImage";
    url= "https://cidercollective.itch.io/cider";
    # sha256sum /nix/store/deadb33f-Cider-linux-appimage-x64.AppImage
    sha256 = "1f07c1c98f1abf502f23eb7bc2768d6e10cb5c1c60cd129888b1b584f52da3da";
  };
  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
  extraInstallCommands = ''
    source "${makeWrapper}/nix-support/setup-hook"

    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    description = "Cider is a new cross-platform Apple Music experience";
    downloadPage = "https://cidercollective.itch.io/cider";
    homepage = "https://cider.sh/";
    license = lib.licenses.unfree;
    mainProgram = "cider";
    maintainers = with lib.maintainers; [ flexiondotorg ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}