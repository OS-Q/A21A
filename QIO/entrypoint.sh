#!/bin/bash

readonly CMSIS_VERSION="$1"
readonly CMSIS_ARCHIVE="CMSIS-${CMSIS_VERSION}.tar.bz2"
readonly BOARD="$2"

# Install the development version of ststm32 platform
qio platform install "https://github.com/OS-Q/P21.git" || {
  exit 1
}
# Prepare framework for CI
# python3 -c "import json; import os; fp=open(os.path.expanduser('~/.qio/platforms/P21/link.json'), 'r+'); data=json.load(fp); fp.seek(0); fp.truncate(); json.dump(data, fp); fp.close()" || {
#   exit 1
# }
# ln --symbolic "$GITHUB_WORKSPACE" "$HOME/.qio/packages/A21A" || {
#   exit 1
# }
# Download and unpack CMSIS package
# wget --no-verbose "https://github.com/stm32duino/ArduinoModule-CMSIS/releases/download/$CMSIS_VERSION/$CMSIS_ARCHIVE" || {
#   exit 1
# }
# tar --extract --bzip2 --file="$CMSIS_ARCHIVE" || {
#   exit 1
# }
cd "$GITHUB_WORKSPACE/QIO/" || {
  exit 1
}

python3 builder.py --board="$BOARD"

exit $?
