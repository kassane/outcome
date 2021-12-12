#!/bin/sh -e
mkdir -p build-gcc7-cxx14
cd build-gcc7-cxx14
CXX=g++-7 cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_STANDARD=14 -DLABEL=gcc7-cxx14
cmake --build .
cd ..
mkdir -p build-gcc9-cxx17
cd build-gcc9-cxx17
CXX=g++-9 cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_STANDARD=17 -DLABEL=gcc9-cxx17
cmake --build .
cd ..

if [ $# -eq 0 ]; then
  DUMPFILE=2.2
else
  DUMPFILE=$1
fi
RETCODE=0
abi-dumper -o abi_dumps/Outcome/$DUMPFILE-gcc7-cxx14/binary_only.dump -vnum $DUMPFILE-gcc7-cxx14 build-gcc7-cxx14/liboutcome-abi-lib-gcc7-cxx14.so || RETCODE=1
abi-dumper -o abi_dumps/Outcome/$DUMPFILE-gcc9-cxx17/binary_only.dump -vnum $DUMPFILE-gcc9-cxx17 build-gcc9-cxx17/liboutcome-abi-lib-gcc9-cxx17.so || RETCODE=1
exit $RETCODE
