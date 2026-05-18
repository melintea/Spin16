#~/bin/bash

function runit()
{
    testf=$2
    spinf=$1
    printf "\n\n===\n"
    echo "=== $spinf: $testf ==="
    echo "==="
    $spinf -V
    
    rm ./pan* ./*.trail ./_spin*
    
    $spinf -a $testf
    gcc -E pan.c -o pan.i
    
    #                       -DCOLLAPSE 
    gcc -ggdb -DMEMLIM=4096 -DBITSTATE -O2 -DXUSAFE -DSAFETY -DNOCLAIM -w -o pan pan.c || exit 1
    ./pan -m1000001
    
    gcc -ggdb -DMEMLIM=8192 -DBITSTATE -O2 -DNP -DNOCLAIM -w -o pan pan.c || exit 1
    ./pan -m1000001 -l
    
    gcc -ggdb -DMEMLIM=8192 -DBITSTATE -O2 -DNFAIR=100 -w -o pan pan.c || exit 1
    ./pan -m1000001 -a -N p0
    ./pan -m1000001 -a -f -N p0
    ./pan -m1000001 -a -N p1
    ./pan -m1000001 -a -f -N p1
    #./pan -a -N p2
    #./pan -a -N p3

    #rm ./pan* ./*.trail ./_spin*
}


make
spinf16=`realpath ./spin`

testf8=`realpath ../Examples/LTL/spin16-8.pml`
testf16=`realpath ../Examples/LTL/spin16-16.pml`

clear
pushd /tmp

#runit ~/work/Spin/Src/spin $testf8
runit /usr/bin/spin $testf8
runit $spinf16 $testf8
runit $spinf16 $testf16

popd
