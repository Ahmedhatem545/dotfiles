Flutter install and test for this Neovim config

1) Run the installer script (it clones Flutter into $HOME/flutter and runs `flutter doctor`):

bash ~/ .config/nvim/scripts/install_flutter.sh

2) Add Flutter to your PATH permanently (example for bash):

echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.profile
source ~/.profile

3) Open Neovim and install/update plugins & parsers:

:Lazy sync
:TSUpdate dart

4) In Neovim, open a Flutter project and verify LSP:

- Open any `.dart` file
- Run `:LspInfo` to ensure `dartls` or flutter-tools LSP is attached
- Use `:FlutterRun`, `:FlutterReload` to test runtime commands (requires emulator/device)

Notes:
- The installer does not modify shell profiles automatically; follow step 2 to persist PATH.
- Installing Flutter downloads large artifacts; ensure you have bandwidth and disk space.
