#!/usr/bin/bash
# Firmware Parser | cleaner script | erases everything except rom content
# By YZBruh | Licensed by Eclipse Public License 2.0

## Functions
abort() {
    echo "$1"
    echo "1" > $DIR/exit_code.cfg
    exit 1
}

# Variables
TARGET_DIR="$1"
DIR=$(pwd)

# Check
if [ "$TARGET_DIR" = "" ]; then
    abort "Missing arguement!"
else
    cd $TARGET_DIR || abort "Cannot access: $TARGET_DIR"
fi

# access the directory and start processes 
find $(pwd) -type f -name "*.url" -exec sudo rm -rf {} \; -exec echo "Deleted: {}" \;
find $(pwd) -type f -name "*.exe" -exec sudo rm -rf {} \; -exec echo "Deleted: {}" \;
find $(pwd) -type d -name "META-INF" -exec sudo rm -rf {} \;

find $(pwd) -name "*.img" -type f -exec sh -c 'echo "$(dirname "{}")" > rom_path.cfg' \; || find $(pwd) -name "*.bin" -type f -exec sh -c 'echo "$(dirname "{}")" > rom_path.cfg' \;

cd $DIR
