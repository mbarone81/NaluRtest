#!/bin/bash
. ../../pass_fail.sh

CWD=$(pwd)
didSimulationDiffAnywhere=0

# determine tolerance
testTol=0.0000001
platform=`uname`
if [ "$platform" == 'Linux' ]; then
    testTol=0.0000000000000001
fi

# set the global diff
GlobalMaxSolutionDiff=-1000000000.0

if [ -f $CWD/PASS ]; then
    # already ran this test
    didSimulationDiffAnywhere=0
else
    mpiexec --np 4 ../../naluX -i inputFireEdgeUpwind.i -o inputFireEdgeUpwind.log
    determine_pass_fail $testTol "inputFireEdgeUpwind.log" "inputFireEdgeUpwind.norm" "inputFireEdgeUpwind.norm.gold"
    didSimulationDiffAnywhere="$?"
fi

# write the file based on final status
if [ "$didSimulationDiffAnywhere" -gt 0 ]; then
    PASS_STATUS=0
else
    PASS_STATUS=1
    echo $PASS_STATUS > PASS
fi

# report it; 30 spaces
GlobalPerformanceTime=`grep "STKPERF: Total Time" inputFireEdgeUpwind.log  | awk '{print $4}'`
if [ $PASS_STATUS -ne 1 ]; then
    echo -e "..inputFireEdgeUpwind......... FAILED":" " $GlobalPerformanceTime " s" " max diff: " $GlobalMaxSolutionDiff
else
    echo -e "..inputFireEdgeUpwind......... PASSED":" " $GlobalPerformanceTime " s"
fi

exit $PASS
