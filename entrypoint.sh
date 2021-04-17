#!/bin/bash

readonly BOARD="$1"

# Prepare framework for CI
# python3 -c "import json; import os; fp=open(os.path.expanduser('~/.qio/platforms/P21/link.json'), 'r+'); data=json.load(fp); fp.seek(0); fp.truncate(); json.dump(data, fp); fp.close()" || {
#   exit 1
# }
# ln --symbolic "$GITHUB_WORKSPACE" "$HOME/.qio/packages/A21A" || {
#   exit 1
# }

cd "$HOME/.qio/packages/A21A" || {
  exit 1
}

git fetch

cd "$GITHUB_WORKSPACE" || {
  exit 1
}

python3 builder.py --board="$BOARD"

exit $?
