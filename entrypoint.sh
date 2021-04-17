#!/bin/bash

readonly BOARD="$1"

python3 -c "import json; import os; fp=open(os.path.expanduser('~/.qio/platforms/P21/link.json'), 'r+'); data=json.load(fp); data['packages']['A21A']['optional'] = 'false'; fp.seek(0); fp.truncate(); json.dump(data, fp); fp.close()" || {
  exit 1
}

pio update

cd "$HOME/.qio/packages/A21A" || {
  exit 1
}

git fetch

# git clone --depth=3 https://github.com/OS-Q/A21A.git A21A

cd "$GITHUB_WORKSPACE" || {
  exit 1
}

python3 builder.py --board="$BOARD"

exit $?
