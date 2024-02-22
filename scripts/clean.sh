#!/usr/bin/bash
# Firmware Parser | cleaner script | erases everything except rom content
# By YZBruh | Licensed by Eclipse Public License 2.0

# Variables
TARGET_DIR=$1
DIR=$(pwd)

# Check
if [ "$TARGET_DIR" = "" ]; then
    echo "Missing arguement!"
    echo "1" > $DIR/exit_code.cfg
    exit 1
fi

# access the directory and start processes 
cd $TARGET_DIR || echo "1" > $DIR/exit_code.cfg && exit 1
find $(pwd) -type f -name "*.url" -exec sudo rm -rf {} && echo "Deleted: {}" \;
find $(pwd) -type f -name "*.exe" -exec sudo rm -rf {} && echo "Deleted: {}" \;
find $(pwd) -type d -name "META-INF" -exec sudo rm -rf {} && echo "Deleted: {}" \;

if [ -f system* ]; then
    echo "$(pwd)" > $DIR/rom_path.cfg
elif [ -f super* ]; then
    echo "$(pwd)" > $DIR/rom_path.cfg
else
    if [ -d * ]; then
        cd *
        if [ -f system* ]; then
            echo "$(pwd)" > $DIR/rom_path.cfg
        elif [ -f super* ]; then
            echo "$(pwd)" > $DIR/rom_path.cfg
        else
            if [[ $(find $(pwd) -name "*.img" -type f -exec tp=$(dirname "{}") && echo "$tp" > rom_path.cfg \;) ]]; then
                echo
            elif [[ $(find $(pwd) -name "*.img" -type f -exec tp=$(dirname "{}") && echo "$tp" > rom_path.cfg \;) ]]; then
                echo
            else
                echo "There is no sign of ROM among the extracted ones!"
                echo "1" > $DIR/exit_code.cfg
                exit 1
            fi
        fi
    else
        echo "There is no sign of ROM among the extracted ones!"
        echo "1" > $DIR/exit_code.cfg
        exit 1
    fi
fi

cd $DIR
