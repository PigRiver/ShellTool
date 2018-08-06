#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

codeFilePath=$1
UNUSED_IMAGE_FILE="FindUnusedImage.txt"
USED_IMAGE_FILE="FindUsedImage.txt"

# 传入内容名
searchContentInFile() {
	imageFile=$1
	imageName=${imageFile##*/}
	content=${imageName%.*}
	files=$2
	# grep -m1 -E "(?<!//.*)splash_launch_first"
	# allSearchResult=$(echo "$files" | xargs grep -H "splash_launch_first")
	finalResult=$(echo "$files" | xargs -I {} grep -H "${content}" {} | grep -v -E "\//.*${content}" ||:)
	# echo "$files" | xargs pcregrep "\//.*splash_launch_first"
	
	if [[ -z "$finalResult" ]]; then
		echo "${imageFile}\n" >> ${UNUSED_IMAGE_FILE}
	else
		echo "${finalResult}\n" >> ${USED_IMAGE_FILE}
	fi

}

if [[ -e ${UNUSED_IMAGE_FILE} ]]; then
	rm -fr ${UNUSED_IMAGE_FILE}
fi

if [[ -e USED_IMAGE_FILE ]]; then
	rm -fr ${USED_IMAGE_FILE}
fi

codeFiles=$(find ${codeFilePath} -name "*.java" -o -name "*.xml" \
	-not -path "**/R.java" \
	-not -path "**/mergeDebugAndroidTestResources/**" \
	-not -path "**/androidTest/**" \
	-not -path "**/merged/**" \
	-not -path "**/merged.dir/**" \
	| grep -v -E ".*\/R\.java" \
	| grep -v -E ".*\/merger\.xml" \
	| grep -v -E ".*\/workspace\.xml" ) 

imageFiles=$(find ${codeFilePath} -name "*.jpg" -o -name "*.png" \
	-not -path "**/appcompat-v7/**" \
	-not -path "**/androidTest/**" \
	-not -path "**/res/merged/**" \
	-not -path "**/com.android.support/**")
 

for imageFile in $imageFiles; do
	searchContentInFile "$imageFile" "$codeFiles"
done