#!/usr/bin/env bash
set -euo pipefail

FLUTTER_DIR="$HOME/flutter"
BRANCH="stable"

if [ -d "$FLUTTER_DIR" ]; then
  echo "Flutter directory already exists at $FLUTTER_DIR"
else
  echo "Cloning Flutter SDK (branch: $BRANCH) to $FLUTTER_DIR..."
  git clone https://github.com/flutter/flutter.git -b "$BRANCH" "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

echo
echo "Important: add this line to your shell profile (~/.profile, ~/.bashrc or ~/.zshrc):"
echo "  export PATH=\"$FLUTTER_DIR/bin:\$PATH\""
echo

echo "Running 'flutter doctor' (this will download additional SDK artifacts)..."
"$FLUTTER_DIR/bin/flutter" doctor

echo
echo "Done. If flutter doctor completed successfully, restart your shell or source your profile, then open Neovim and run:" 
cat <<'EOF'
:Lazy sync
:TSUpdate dart
:Mason    "open the Mason UI and ensure any helpers are installed"
EOF

echo
echo "To verify in headless Neovim (example):"
echo "  nvim --headless -u $HOME/.config/nvim/init.lua some_flutter_project/lib/main.dart -c 'lua print(vim.inspect(vim.lsp.get_active_clients()))' -c qa"

exit 0
