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
# 间隔时间，若电脑卡顿，可将时间调长
intervalSeconds=0.5

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

# 切换成英文输入法
osascript <<EOF
	tell application "System Events" to tell process "SystemUIServer"
		click (1st menu bar item of first menu bar whose description is "text input")
		click (menu item "ABC" of result's menu 1)
	end tell
EOF

for changedFilePath in ${changedFileList[@]}; do
	suffixStr="${changedFilePath##*.}"
	if [ $suffixStr != "java" ]; then
		continue
	fi
	if [[ -e "${changedFilePath}" ]]; then
osascript <<EOF
	set pathForLinux to "${changedFilePath}"
	tell application "System Events"
		tell application "Finder"
			open application file "Android Studio.app" of folder "Applications" of startup disk
		end tell

		delay ${intervalSeconds}
		key code 31 using {command down, shift down} -- Command + Shift + O
		delay ${intervalSeconds}
		keystroke pathForLinux -- 输入文件路径
		delay ${intervalSeconds}
		key code 36 -- 回车
		delay ${intervalSeconds}
		key code 37 using {command down, option down} -- Command + Option + L
		delay ${intervalSeconds}
	end tell
EOF
	fi
done
popd


