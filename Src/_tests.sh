#~/bin/bash

function runit()
{
    testf=$2
    spinf=$1
    echo "=== $spinf: $testf ==="
    $spinf -V
    
    rm ./pan*
    
    spin -a $testf
    gcc -E pan.c -o pan.i
    gcc -o pan pan.c || exit 1
    ./pan -a -N p0
    ./pan -a -N p1
    ./pan -a -N p2
    ./pan -a -N p3
}

spinf16=`realpath ./spin`

#testf=`realpath ../Examples/LTL/leader.pml`
#testf=`realpath ../Examples/LTL/_manyprocs.pml`
testf8=`realpath ../Examples/LTL/spin8.pml`
testf16=`realpath ../Examples/LTL/spin16.pml`

clear
pushd /tmp

runit /usr/bin/spin $testf8
runit $spinf16 $testf16

popd
