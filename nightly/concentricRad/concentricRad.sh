#!/bin/bash
CWD=$(pwd)
tolerance=0.0000000000000001
if [ -f $CWD/PASS ]; then
    PASS_STATUS=1
else
    mpiexec --np 4 ../../naluX -i concentricRad.i -o concentricRad.log
    grep "Mean System Norm:" concentricRad.log  | awk '{print $4}' > concentricRad.norm

    read localNorm < "concentricRad.norm"
    read goldNorm < "concentricRad.norm.gold"

    modLocalNorm=$(printf "%1.32f" $localNorm)
    modGoldNorm=$(printf "%1.32f" $goldNorm)

# compute the difference
    diff=$(echo $modLocalNorm - $modGoldNorm | bc)

# make sure diff is positive.. abs anyone?
    zero=0.0
    minusOne=-1.0
    if [ $(echo " $diff < $zero" | bc) -eq 1 ]; then
	absDiff=$(echo $diff*$minusOne | bc)
    else
	absDiff=$diff
    fi

# test the difference
    if [ $(echo " $absDiff < $tolerance" | bc) -eq 1 ]; then
	PASS_STATUS=1
	echo $diff > PASS
    else
	PASS_STATUS=0
    fi
fi
exit $PASS_STATUS
