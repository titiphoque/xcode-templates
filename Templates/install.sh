#!/bin/bash

set -e

IOS_FILE_TEMPLATES_SOURCES_DIR=(
    "[Setup] Openium"
    "Openium"
)
IOS_FILE_TEMPLATE_OUTPUT_DIR="~/Library/Developer/Xcode/Templates/File Templates"

echo ""
echo "Installing iOS File Templates:"
echo ""

for template_folder in "${IOS_FILE_TEMPLATES_SOURCES_DIR[@]}"
do
    echo ""
    echo " - Installing templates from $template_folder"
    declare -a templates=( "$template_folder"/* )


    for file_template in "${templates[@]}"
    do
        #If folder exists, try to remove current template if exists, else create folder
        if [ -d "$IOS_FILE_TEMPLATE_OUTPUT_DIR/$template_folder" ]
        then
            rm -f -r "$IOS_FILE_TEMPLATE_OUTPUT_DIR/$template_folder/$file_template"
        else
            mkdir "$IOS_FILE_TEMPLATE_OUTPUT_DIR/$template_folder"
        fi

        if cp -R "./$file_template" "$IOS_FILE_TEMPLATE_OUTPUT_DIR/$file_template"
        then
            echo "    - ✅ $file_template "
        else 
            echo "    - 🔴 $file_template "
        fi

    done
done