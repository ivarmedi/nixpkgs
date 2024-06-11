{ lib
, SDL2
, alsa-lib
, cmake
, fetchFromGitLab
, ffmpeg
, freeimage
, freetype
, libgit2
, pkg-config
, poppler
, pugixml
, stdenv
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "es-de";
  version = "3.0.2";

  src = fetchFromGitLab {
    owner = "es-de";
    repo = "emulationstation-de";
    rev = "v${finalAttrs.version}";
    hash = "sha256-RGlXFybbXYx66Hpjp2N3ovK4T5VyS4w0DWRGNvbwugs=";
  };

  outputs = [ "out" "man" ];

  patches = [ ./001-add-nixpkgs-retroarch-cores.patch ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    alsa-lib
    ffmpeg
    freeimage
    freetype
    libgit2
    poppler
    pugixml
    SDL2
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    
    # By default the application updater will be built
    # which checks for new releases on startup, this disables it.
    "-DAPPLICATION_UPDATER=off"
    
    # Sets the installation directory, also modifies code inside ES-DE
    # used to locate the required program resources. Though I builds
    # correctly without it.
    # "-DCMAKE_INSTALL_PREFIX=$out"
  ];

  meta = {
    description = "Frontend for browsing and launching games from your multi-platform collection.";
    homepage = "https://es-de.org";
    downloadPage = "https://es-de.org/#Download";
    changelog = "https://gitlab.com/es-de/emulationstation-de/-/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ashgoldofficial ivarmedi ];
    mainProgram = "es-de";
    platforms = lib.platforms.linux;
  };
})
