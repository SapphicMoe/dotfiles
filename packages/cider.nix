{ 
  appimageTools,
  lib,
  ...
}:

appimageTools.wrapType2 rec {
  pname = "cider";
  version = "2.5.9";

  src = /home/chloe/Downloads/Cider-linux-appimage-x64.AppImage;

  extraInstallCommands = let
    contents = appimageTools.extract { inherit pname version src; };
  in ''
    install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${contents}/usr/share/icons $out/share
  '';

  meta = {
    description = "A new look into listening and enjoying Apple Music in style and performance.";
    homepage = "https://cidercollective.itch.io/cider";
    platforms = [ "x86_64-linux" ];
  };
}
