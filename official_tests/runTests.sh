#!/bin/bash

for i in tests/*.imp; do
    echo "Building " $bin
    name=`basename $i .imp`
    bin=bin/${name}.mr
    ../compiler/kompilator $i $bin
done

TESTS=(
    slowik0
    program0
    program1
    program2
    program2
    0-div-mod
    1-numbers
    2-fib
    3-fib-factorial
    4-factorial
    5-tab
    6-mod-mult
    7-loopiii
    7-loopiii
    8-for
    9-sort
)

for f in ${TESTS[@]}; do
    bin=bin/$f.mr 
    echo
    echo "Running " $bin
    echo "============"
    if [ -e ${bin} ]; then 
        ../machine/maszyna-rejestrowa $bin
    else
        echo "Missing binary: " $bin
    fi
    read -rsp $'Press enter to continue...\n'
done
