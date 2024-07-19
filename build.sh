#!/bin/bash

cd build
cmake -DCMAKE_TOOLCHAIN_FILE=/home/vcpkg/scripts/buildsystems/vcpkg.cmake .. --preset linux-release

cmake --build linux-release || exit 1
if [ $? -eq 1 ]
then
	echo "Compilation failed!"
else
	echo "Compilation successful!"
	cd ..
	if [ -f "canary" ]; then
		echo "Saving old build"
		mv ./canary ./canary.old
	fi
	cp ./build/linux-release/bin/canary ./canary
fi
