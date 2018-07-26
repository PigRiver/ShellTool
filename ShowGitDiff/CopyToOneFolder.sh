#!/usr/bin/env bash
#将多级路径的文件复制到同一个文件夹下
#对同名文件进行处理（加后缀）

set -o errexit
set -o pipefail
set -o nounset

sourcePath=$1
targetPath=$2

files=$(find "${sourcePath}" -type f)

cp_with_backup() {
    source="$1"
    target="$2"

    if [[ "$target" == */ ]]; then
        filename="${source##*/}" #$(basename "$source")
        target_dir="$target"
    else 
        filename="${target##*/}" #$(basename "$target")
        target_dir="${target%/*}" #$(dirname "$target")
    fi

    if [[ ! -e "${target_dir}" ]]; then
        mkdir -p "${target_dir}"
    fi

    basename="${filename%.*}"
    ext="${filename##*.}"

    if [[ ! -e "$target_dir/$basename.$ext" ]]; then
        # file does not exist in the destination directory
        cp "$source" "$target_dir/$basename.$ext" 

    else
        num=2
        while [[ -e "$target_dir/$basename($num).$ext" ]]; do
            (( num++ ))
        done
        cp "$source" "$target_dir/$basename($num).$ext"
    fi
}

while read -r line;do
	cp_with_backup "${line}" "${targetPath}/"
done <<< "$files"