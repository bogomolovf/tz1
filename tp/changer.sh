#!/bin/bash

display_usage() {
    echo "Usage: $0 <input_directory> <output_directory>"
}

copy_files() {

    local source_dir="$1"
    local target_dir="$2"
    local file_suffix=0


    find "$source_dir" -type f | while read -r file; do

        filename=$(basename "$file")

        while [ -e "$target_dir/$filename" ]; do
            file_suffix=$((file_suffix + 1))
            filename="${filename%.*}_${file_suffix}.${filename##*.}"
        done

        cp "$file" "$target_dir/$filename"
    done
}

if [ "$#" -ne 2 ]; then
    display_usage
    exit 1
fi

input_dir="$1"
output_dir="$2"

mkdir -p "$output_dir"

copy_files "$input_dir" "$output_dir"

echo "done"
