#!/bin/bash
. ../../pass_fail.sh

CWD=$(pwd)
didSimulationDiffAnywhere=0

# determine tolerance
testTol=0.000000000001
platform=`uname`
if [ "$platform" == 'Linux' ]; then
    testTol=0.0000000000000001
fi

# set the global diff
GlobalMaxSolutionDiff=-1000000000.0

if [ -f $CWD/PASS_NP1 ]; then
    # already ran this test
    didSimulationDiffAnywhere=0
else
    mpiexec -np 8 ../../naluX -i cvfemHC.i -o cvfemHC.log
    determine_pass_fail $testTol "cvfemHC.log" "cvfemHC.norm" "cvfemHC.norm.gold"
    didSimulationDiffAnywhere="$?"
fi

# write the file based on final status
if [ "$didSimulationDiffAnywhere" -gt 0 ]; then
    PASS_STATUS=0
else
    PASS_STATUS=1
    echo $PASS_STATUS > PASS_NP1
fi

# report it; 30 spaces
GlobalPerformanceTime=`grep "STKPERF: Total Time" cvfemHC.log  | awk '{print $4}'`
if [ $PASS_STATUS -ne 1 ]; then
    echo -e "..cvfemHC..................... FAILED":" " $GlobalPerformanceTime " s" " max diff: " $GlobalMaxSolutionDiff
else
    echo -e "..cvfemHC..................... PASSED":" " $GlobalPerformanceTime " s"
fi

exit