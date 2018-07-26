#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [[ $# -lt 3 ]]; then
	echo "At Least Need 3 args: CodePath, CommitHash1, CommitHash2"
	echo "You Can Add the fourth arg: AuthorName"
	exit 0
fi

CodePath=$1
CommitHash1=$2
CommitHash2=$3

shellPath=$(cd `dirname $0`; pwd)

pushd $1
#git show ac6f74f7dca852294e71e061c9aea157f981a6a0..54d1fb29b975f5be76afec2695d263a8ef0a0b5e --author='huangxiaojian' --pretty= --name-only | sort -u
if [[ $# -eq 3 ]]; then
	changedFileList=$(git show "${CommitHash1}".."${CommitHash2}" --pretty= --name-only | sort -u )
else
	AuthorName=$4
	changedFileList=$(git show "${CommitHash1}".."${CommitHash2}" --author="${AuthorName}" --pretty= --name-only | sort -u )
fi

if [[ -z $changedFileList ]]; then
	echo "There is no commit history"
	exit 0
fi

tempPath="/tmp"
if [[ ! -e ${tempPath} ]]; then
	tempPath="${shellPath}${tempPath}"
	mkdir -p ${tempPath}
fi

git checkout "$CommitHash1"
zip -q -o "${tempPath}/${CommitHash1}".zip $changedFileList
git checkout "$CommitHash2"
zip -q -o "${tempPath}/${CommitHash2}".zip $changedFileList
popd

diffPath="./GitDiff"

if [[  -e ${diffPath} ]]; then
	rm -fr ${diffPath}
fi

mkdir -p ${diffPath}
unzip -q -o "${tempPath}/${CommitHash1}.zip" -d "${diffPath}/${CommitHash1}-Cache"
unzip -q -o "${tempPath}/${CommitHash2}.zip" -d "${diffPath}/${CommitHash2}-Cache"

rm -f "${tempPath}/${CommitHash1}.zip"
rm -f "${tempPath}/${CommitHash2}.zip"

sh CopyToOneFolder.sh "${diffPath}/${CommitHash1}-Cache" "${diffPath}/${CommitHash1}"
sh CopyToOneFolder.sh "${diffPath}/${CommitHash2}-Cache" "${diffPath}/${CommitHash2}"

rm -rf "${diffPath}/${CommitHash1}-Cache"
rm -rf "${diffPath}/${CommitHash2}-Cache"

/usr/local/bin/bcomp "${diffPath}/${CommitHash1}" "${diffPath}/${CommitHash2}"
