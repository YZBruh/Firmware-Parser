#!/usr/bin/bash
# Firmware Parser | rom extractor script
# By YZBruh | Licensed by Eclipse Public License 2.0

## Functions
abort() {
    echo "$1"
    echo "1" > $DIR/exit_code.cfg
    exit 1
}

# Variables
DIR=$(pwd)
TARGET_DIR=$1

# Check
if [ "$TARGET_DIR" = "" ]; then
    abort "Missing arguement!"
else
    cd "$TARGET_DIR"
fi

if [ -f *.zip ]; then
    COMP_TYPE="zip"
elif [ -f *.7z ]; then
    COMP_TYPE="7z"
elif [ -f *.7zip]; then
    COMP_TYPE="7z"
    WARN="1"
elif [ -f *.tgz ]; then
    COMP_TYPE="tgz"
elif [ -f *.tar.gz ]; then
    COMP_TYPE="tar.gz"
elif [ -f *.tar ]; then
    COMP_TYPE="tar"
elif [ -f *.tar.xz ]; then
    COMP_TYPE="tar.xz"
elif [ -f *.rar ]; then
    COMP_TYPE="rar"
else
    abort "Not found!"
fi

echo "Found stock ROM compressed with $COMP_TYPE"
echo "Extracting archive..."
if [ "$COMP_TYPE" == "zip" ]; then
    unzip *.zip
elif [ "$COMP_TYPE" == "7z" ]; then
    if [ "$WARN" == "1" ]; then
        mv * rom.7z
        7z x rom.7z
    else
        7z x *.7z
    fi
elif [ "$COMP_TYPE" == "tar.gz" ]; then
    tar -xf *.tar.gz
elif [ "$COMP_TYPE" == "tgz" ]; then
    tar -xf *.tgz
elif [ "$COMP_TYPE" == "tar" ]; then
    tar -xf *.tar
elif [ "$COMP_TYPE" == "tar.xz" ]; then
    tar -xf *.tar.xz
elif [ "$COMP_TYPE" == "rar" ]; then
    unrar *.rar
else
    abort "Unsupported file format!"
fi

rm -f *."$COMP_TYPE"
cd "$DIR"

# end of script
