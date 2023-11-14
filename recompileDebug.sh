#!/bin/bash

if [ -d "debug" ]
then
	echo "Directory 'debug' already exists, moving to it"
	cd debug
	echo "Clean debug directory"
	rm -rf *
	echo "Configuring"
	cmake -D CMAKE_BUILD_TYPE=RelWithDebInfo ..
else
	mkdir "debug" && cd debug
	cmake -D CMAKE_BUILD_TYPE=RelWithDebInfo ..
fi

make -j$(nproc) || exit 1
if [ $? -eq 1 ]
then
	echo "Compilation failed!"
else
	echo "Compilation successful!"
	cd ..
	if [ -f "tfs" ]; then
		echo "Now remember to change TFSNew to Old and delete old one (TFSD)"
		#mv ./tfs ./tfs.old
	fi
	cp ./debug/tfs ./tfsdNew
fi