#!/bin/bash

readonly CMSIS_VERSION="$1"
readonly CMSIS_ARCHIVE="CMSIS-${CMSIS_VERSION}.tar.bz2"

# Install the development version of ststm32 platform
platformio platform install "https://github.com/OS-Q/P21.git" || {
  exit 1
}
# Prepare framework for CI
python3 -c "import json; import os; fp=open(os.path.expanduser('~/.platformio/platforms/P21/platform.json'), 'r+'); data=json.load(fp); del data['packages']['framework-arduinoststm32']['owner']; fp.seek(0); fp.truncate(); json.dump(data, fp); fp.close()" || {
  exit 1
}
ln --symbolic "$GITHUB_WORKSPACE" "$HOME/.platformio/packages/framework-arduinoststm32" || {
  exit 1
}
# Download and unpack CMSIS package
wget --no-verbose "https://github.com/stm32duino/ArduinoModule-CMSIS/releases/download/$CMSIS_VERSION/$CMSIS_ARCHIVE" || {
  exit 1
}
tar --extract --bzip2 --file="$CMSIS_ARCHIVE" || {
  exit 1
}
cd "$GITHUB_WORKSPACE/CI/build/" || {
  exit 1
}
python3 platformio-builder.py --board=blackpill_f103c8 --board=remram_v1

exit $?
