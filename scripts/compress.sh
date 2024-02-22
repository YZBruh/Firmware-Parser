#!/usr/bin/bash
# Firmware Parser | image compressor script
# By YZBruh | Licensed by Eclipse Public License 2.0

## Functions
abort() {
    echo "$1"
    echo "1" > $DIR/exit_code.cfg
    exit 1
}

# Variables
DIR=$(pwd)
TARGET_FPATH="$1"
TARGET_CT="$2"

# Check
if [ "$TARGET_CT" = "" ]; then
    abort "Missing arguement!"
fi
if [ "$TARGET_FPATH" = "" ]; then
    abort "Missing arguement!"
else
    cd $TARGET_FPATH || abort "Cannot access: $TARGET_FPATH"
fi

mkdir $DIR/out
mv "$TARGET_FPATH"/*.img "$DIR"/out || mv "$TARGET_FPATH"/*.bin "$DIR"/out
mv "$TARGET_FPATH"/*.bin "$DIR"/out
mv "$TARGET_FPATH"/*.elf "$DIR"/out
mv "$TARGET_FPATH"/*.sin "$DIR"/out
rm -rf "$TARGET_FPATH"

cd $DIR/out
if [ "$TARGET_CT" = "xz" ]; then
    for pimage in $(pwd)/*; do
        xz -zvf $pimage
        rm -f $pimage
    done
elif [ "$TARGET_CT" = "gzip" ]; then
    for pimage in $(pwd)/*; do
        gzip -vf $pimage
        rm -f $pimage
    done
elif [ "$TARGET_CT" = "tar" ]; then
    for pimage in $(pwd)/*; do
        tar -cvf "$pimage".tar $pimage
        rm -f $pimage
    done
elif [ "$TARGET_CT" = "7z" ]; then
    for pimage in $(pwd)/*; do
        7z a -t7z "$pimage".7z $pimage
        rm -f 
    done
elif [ "$TARGET_CT" = "zip" ]; then
    for pimage in $(pwd)/*; do
        zip "$pimage".zip $pimage
        rm -f $pimage
    done
elif [ "$TARGET_CT" = "lz4" ]; then
    for pimage in $(pwd)/*; do
        lz4 -zv --rm $pimage
    done
else
    abort "İnvalid compression type!"
fi

# end od script
