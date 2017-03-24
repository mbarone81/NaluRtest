#!/bin/bash

# possible flag passed in
typeOfTesting=$1

echo "Rtest Begin: " $typeOfTesting

NaluRtestCWD=$(pwd)

cd ..
baseGitHubCWD=$(pwd)

# create the directory in which the tests will be run (if it does not exist)
if [ ! -d "$baseGitHubCWD/runNaluRtest" ]; then
    mkdir $baseGitHubCWD/runNaluRtest
fi

# now check for nightly
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly
fi

# look for file that defines the path to naluX
if [ ! -f $NaluRtestCWD/NaluProjectPath.txt ]; then
    # copy executable for all tests to use
    if [ "$typeOfTesting" == "DEBUG" ]; then
        cp $baseGitHubCWD/Nalu/build_debug/naluXd $baseGitHubCWD/runNaluRtest/naluX
        cp $baseGitHubCWD/Nalu/build_debug/unittestXd $baseGitHubCWD/runNaluRtest/unittestX
    else
        cp $baseGitHubCWD/Nalu/build/naluX $baseGitHubCWD/runNaluRtest/naluX
        cp $baseGitHubCWD/Nalu/build/unittestX $baseGitHubCWD/runNaluRtest/unittestX
    fi
else
    NaluProjectPathFile="$NaluRtestCWD/NaluProjectPath.txt"
    projectPathName=$(cat $NaluProjectPathFile)
    if [ "$typeOfTesting" == "DEBUG" ]; then
        cp $projectPathName/build_debug/naluXd $baseGitHubCWD/runNaluRtest/naluX
        cp $projectPathName/build_debug/unittestXd $baseGitHubCWD/runNaluRtest/unittestX
    else
        cp $projectPathName/build/naluX $baseGitHubCWD/runNaluRtest/naluX
        cp $projectPathName/build/unittestX $baseGitHubCWD/runNaluRtest/unittestX
    fi
fi

# copy pass_fail script
cp $NaluRtestCWD/pass_fail.sh $baseGitHubCWD/runNaluRtest

#=============================================================================
# periodic3dElem test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/periodic3dElem" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
fi

cd $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
cp $NaluRtestCWD/nightly/periodic3dElem/periodic3dElem.i $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
cp $NaluRtestCWD/mesh/periodic3d.g $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
cp $NaluRtestCWD/nightly/periodic3dElem/periodic3dElemNp1.sh $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
cp $NaluRtestCWD/nightly/periodic3dElem/periodic3dElemNp1.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
cp $NaluRtestCWD/nightly/periodic3dElem/periodic3dElemNp4.sh $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
cp $NaluRtestCWD/nightly/periodic3dElem/periodic3dElemNp4.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
cp $NaluRtestCWD/nightly/periodic3dElem/periodic3dElemNp8.sh $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
cp $NaluRtestCWD/nightly/periodic3dElem/periodic3dElemNp8.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/periodic3dElem
# run it...  
./periodic3dElemNp1.sh
./periodic3dElemNp4.sh
./periodic3dElemNp8.sh

#=============================================================================
# periodic3dEdge test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
cp $NaluRtestCWD/nightly/periodic3dEdge/periodic3dEdge.i $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
cp $NaluRtestCWD/mesh/periodic3d.g $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
cp $NaluRtestCWD/nightly/periodic3dEdge/periodic3dEdgeNp1.sh $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
cp $NaluRtestCWD/nightly/periodic3dEdge/periodic3dEdgeNp1.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
cp $NaluRtestCWD/nightly/periodic3dEdge/periodic3dEdgeNp4.sh $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
cp $NaluRtestCWD/nightly/periodic3dEdge/periodic3dEdgeNp4.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
cp $NaluRtestCWD/nightly/periodic3dEdge/periodic3dEdgeNp8.sh $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
cp $NaluRtestCWD/nightly/periodic3dEdge/periodic3dEdgeNp8.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/periodic3dEdge
# run it...  
./periodic3dEdgeNp1.sh
./periodic3dEdgeNp4.sh
./periodic3dEdgeNp8.sh

#=============================================================================
# quad9HC test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/quad9HC" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/quad9HC
fi

cd $baseGitHubCWD/runNaluRtest/nightly/quad9HC
cp $NaluRtestCWD/nightly/quad9HC/quad9HC.i $baseGitHubCWD/runNaluRtest/nightly/quad9HC
cp $NaluRtestCWD/mesh/100x50_P2n.g.* $baseGitHubCWD/runNaluRtest/nightly/quad9HC
cp $NaluRtestCWD/nightly/quad9HC/quad9HC.sh $baseGitHubCWD/runNaluRtest/nightly/quad9HC
cp $NaluRtestCWD/nightly/quad9HC/quad9HC.norm.gold $baseGitHubCWD/runNaluRtest/nightly/quad9HC
# run it...  
./quad9HC.sh

#=============================================================================
# steadyTaylorVortex test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex
fi

cd $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex
cp $NaluRtestCWD/nightly/steadyTaylorVortex/steadyTaylorVortex.i $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex
cp $NaluRtestCWD/nightly/steadyTaylorVortex/*.g.* $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex
cp $NaluRtestCWD/nightly/steadyTaylorVortex/steadyTaylorVortex.sh $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex
cp $NaluRtestCWD/nightly/steadyTaylorVortex/steadyTaylorVortex.norm.gold $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex
# run it...  
./steadyTaylorVortex.sh

#=============================================================================
# steadyTaylorVortex_P4 test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex_P4" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex_P4
fi

cd $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex_P4
cp $NaluRtestCWD/nightly/steadyTaylorVortex_P4/STV_P4_R*.i $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex_P4
cp $NaluRtestCWD/nightly/steadyTaylorVortex_P4/*.g $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex_P4
cp $NaluRtestCWD/nightly/steadyTaylorVortex_P4/muelu_STV_HO.xml $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex_P4
cp $NaluRtestCWD/nightly/steadyTaylorVortex_P4/steadyTaylorVortex_P4.sh $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex_P4
cp $NaluRtestCWD/nightly/steadyTaylorVortex_P4/norms.py $baseGitHubCWD/runNaluRtest/nightly/steadyTaylorVortex_P4

# run it...
./steadyTaylorVortex_P4.sh

#=============================================================================
# cvfemHexHC_P3 test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/cvfemHexHC_P3" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/cvfemHexHC_P3
fi

cd $baseGitHubCWD/runNaluRtest/nightly/cvfemHexHC_P3
cp $NaluRtestCWD/nightly/cvfemHexHC_P3/cvfemHexHC_P3_R*.i $baseGitHubCWD/runNaluRtest/nightly/cvfemHexHC_P3
cp $NaluRtestCWD/nightly/cvfemHexHC_P3/*.g $baseGitHubCWD/runNaluRtest/nightly/cvfemHexHC_P3
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/cvfemHexHC_P3
cp $NaluRtestCWD/nightly/cvfemHexHC_P3/cvfemHexHC_P3.sh $baseGitHubCWD/runNaluRtest/nightly/cvfemHexHC_P3
cp $NaluRtestCWD/nightly/cvfemHexHC_P3/norms.py $baseGitHubCWD/runNaluRtest/nightly/cvfemHexHC_P3

# run it...
./cvfemHexHC_P3.sh

#=============================================================================
# variableDensMMS_P5 test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/variableDensMMS_P5" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS_P5
fi

cd $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS_P5
cp $NaluRtestCWD/nightly/variableDensMMS_P5/variableDensNonUniform_P5.i $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS_P5
cp $NaluRtestCWD/nightly/variableDensMMS_P5/*.g $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS_P5
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS_P5
cp $NaluRtestCWD/nightly/variableDensMMS_P5/variableDensMMS_P5.sh $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS_P5
cp $NaluRtestCWD/nightly/variableDensMMS_P5/variableDensNonUniform_P5.norm.gold $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS_P5

# run it...
./variableDensMMS_P5.sh

#=============================================================================
# hoVortex test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/hoVortex" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/hoVortex
fi

cd $baseGitHubCWD/runNaluRtest/nightly/hoVortex
cp $NaluRtestCWD/nightly/hoVortex/hoVortex.i $baseGitHubCWD/runNaluRtest/nightly/hoVortex
cp $NaluRtestCWD/mesh/100x50_P2n.g.* $baseGitHubCWD/runNaluRtest/nightly/hoVortex
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/hoVortex
cp $NaluRtestCWD/nightly/hoVortex/hoVortex.sh $baseGitHubCWD/runNaluRtest/nightly/hoVortex
cp $NaluRtestCWD/nightly/hoVortex/hoVortex.norm.gold $baseGitHubCWD/runNaluRtest/nightly/hoVortex
# run it...  
./hoVortex.sh

#=============================================================================
# hoHelium test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/hoHelium" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/hoHelium
fi

cd $baseGitHubCWD/runNaluRtest/nightly/hoHelium
cp $NaluRtestCWD/nightly/hoHelium/hoHelium.i $baseGitHubCWD/runNaluRtest/nightly/hoHelium
cp $NaluRtestCWD/nightly/hoHelium/*.g.* $baseGitHubCWD/runNaluRtest/nightly/hoHelium
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/hoHelium
cp $NaluRtestCWD/nightly/hoHelium/hoHelium.sh $baseGitHubCWD/runNaluRtest/nightly/hoHelium
cp $NaluRtestCWD/nightly/hoHelium/hoHelium.norm.gold $baseGitHubCWD/runNaluRtest/nightly/hoHelium
# run it...  
./hoHelium.sh

#=============================================================================
# dgNonConformal test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformal" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/dgNonConformal.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/mesh/2DTwoBlock_R0_rev.g.* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/dgNonConformal.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/dgNonConformal.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
# run it...  
./dgNonConformal.sh

#=============================================================================
# dgNonConformalEdge test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdge
cp $NaluRtestCWD/nightly/dgNonConformalEdge/dgNonConformalEdge.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdge
cp $NaluRtestCWD/mesh/2DTwoBlock_R0_rev.g.* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdge
cp $NaluRtestCWD/nightly/dgNonConformalEdge/dgNonConformalEdge.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdge
cp $NaluRtestCWD/nightly/dgNonConformalEdge/dgNonConformalEdge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdge
# run it...  
./dgNonConformalEdge.sh

#=============================================================================
# dgNonConformalFluids test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluids" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluids
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluids
cp $NaluRtestCWD/nightly/dgNonConformalFluids/dgNonConformalFluids.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluids
cp $NaluRtestCWD/mesh/NACA.g.* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluids
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluids
cp $NaluRtestCWD/nightly/dgNonConformalFluids/dgNonConformalFluids.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluids
cp $NaluRtestCWD/nightly/dgNonConformalFluids/dgNonConformalFluids.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluids
# run it...  
./dgNonConformalFluids.sh

#=============================================================================
# dgNonConformalFluidsEdge test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluidsEdge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluidsEdge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluidsEdge
cp $NaluRtestCWD/nightly/dgNonConformalFluidsEdge/dgNonConformalFluidsEdge.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluidsEdge
cp $NaluRtestCWD/mesh/NACA.g.* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluidsEdge
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluidsEdge
cp $NaluRtestCWD/nightly/dgNonConformalFluidsEdge/dgNonConformalFluidsEdge.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluidsEdge
cp $NaluRtestCWD/nightly/dgNonConformalFluidsEdge/dgNonConformalFluidsEdge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalFluidsEdge
# run it...  
./dgNonConformalFluidsEdge.sh

#=============================================================================
# dgNonConformal3dFluids test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluids" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluids
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluids
cp $NaluRtestCWD/nightly/dgNonConformal3dFluids/dgNonConformal3dFluids.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluids
cp $NaluRtestCWD/mesh/twoBlockMesh_cgs.g.* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluids
cp $NaluRtestCWD/xml/milestone.xml  $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluids
cp $NaluRtestCWD/nightly/dgNonConformal3dFluids/dgNonConformal3dFluids.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluids
cp $NaluRtestCWD/nightly/dgNonConformal3dFluids/dgNonConformal3dFluids.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluids
# run it...  
./dgNonConformal3dFluids.sh

#=============================================================================
# dgNonConformal3dFluidsP1P2 test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsP1P2" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsP1P2
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsP1P2
cp $NaluRtestCWD/nightly/dgNonConformal3dFluidsP1P2/dgNonConformal3dFluidsP1P2.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsP1P2
cp $NaluRtestCWD/nightly/dgNonConformal3dFluidsP1P2/*.g.* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsP1P2
cp $NaluRtestCWD/xml/milestone.xml  $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsP1P2
cp $NaluRtestCWD/nightly/dgNonConformal3dFluidsP1P2/dgNonConformal3dFluidsP1P2.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsP1P2
cp $NaluRtestCWD/nightly/dgNonConformal3dFluidsP1P2/dgNonConformal3dFluidsP1P2.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsP1P2
# run it...  
./dgNonConformal3dFluidsP1P2.sh

#=============================================================================
# dgNonConformal3dFluidsHexTet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsHexTet" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsHexTet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsHexTet
cp $NaluRtestCWD/nightly/dgNonConformal3dFluidsHexTet/dgNonConformal3dFluidsHexTet.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsHexTet
cp $NaluRtestCWD/mesh/twoBlockMeshHexTet_cgs.g.* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsHexTet
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsHexTet
cp $NaluRtestCWD/nightly/dgNonConformal3dFluidsHexTet/dgNonConformal3dFluidsHexTet.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsHexTet
cp $NaluRtestCWD/nightly/dgNonConformal3dFluidsHexTet/dgNonConformal3dFluidsHexTet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal3dFluidsHexTet
# run it...  
./dgNonConformal3dFluidsHexTet.sh

#=============================================================================
# dgNonConformalThreeBlade test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade
cp $NaluRtestCWD/nightly/dgNonConformalThreeBlade/dgNonConformalThreeBlade.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade
cp $NaluRtestCWD/nightly/dgNonConformalThreeBlade/dgNonConformalThreeBlade_rst.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade
cp $NaluRtestCWD/mesh/threeBladeMesh.g $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade
cp $NaluRtestCWD/nightly/dgNonConformalThreeBlade/dgNonConformalThreeBlade.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade
cp $NaluRtestCWD/nightly/dgNonConformalThreeBlade/dgNonConformalThreeBlade.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade
cp $NaluRtestCWD/nightly/dgNonConformalThreeBlade/dgNonConformalThreeBlade_rst.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalThreeBlade
# run it...  
./dgNonConformalThreeBlade.sh

#=============================================================================
# overset test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/overset" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/overset
fi

cd $baseGitHubCWD/runNaluRtest/nightly/overset
cp $NaluRtestCWD/nightly/overset/overset.i $baseGitHubCWD/runNaluRtest/nightly/overset
cp $NaluRtestCWD/mesh/oversetMeshAligned.g* $baseGitHubCWD/runNaluRtest/nightly/overset
cp $NaluRtestCWD/nightly/overset/overset.sh $baseGitHubCWD/runNaluRtest/nightly/overset
cp $NaluRtestCWD/nightly/overset/overset.norm.gold $baseGitHubCWD/runNaluRtest/nightly/overset
# run it...  
./overset.sh

#=============================================================================
# oversetFluids test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/oversetFluids" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/oversetFluids
fi

cd $baseGitHubCWD/runNaluRtest/nightly/oversetFluids
cp $NaluRtestCWD/nightly/oversetFluids/oversetFluids.i $baseGitHubCWD/runNaluRtest/nightly/oversetFluids
cp $NaluRtestCWD/mesh/oversetMeshAligned.g* $baseGitHubCWD/runNaluRtest/nightly/oversetFluids
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/oversetFluids
cp $NaluRtestCWD/nightly/oversetFluids/oversetFluids.sh $baseGitHubCWD/runNaluRtest/nightly/oversetFluids
cp $NaluRtestCWD/nightly/oversetFluids/oversetFluids.norm.gold $baseGitHubCWD/runNaluRtest/nightly/oversetFluids
# run it...  
./oversetFluids.sh

#=============================================================================
# oversetFluidsEdge test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/oversetFluidsEdge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/oversetFluidsEdge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/oversetFluidsEdge
cp $NaluRtestCWD/nightly/oversetFluidsEdge/oversetFluidsEdge.i $baseGitHubCWD/runNaluRtest/nightly/oversetFluidsEdge
cp $NaluRtestCWD/mesh/oversetMeshAligned.g* $baseGitHubCWD/runNaluRtest/nightly/oversetFluidsEdge
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/oversetFluidsEdge
cp $NaluRtestCWD/nightly/oversetFluidsEdge/oversetFluidsEdge.sh $baseGitHubCWD/runNaluRtest/nightly/oversetFluidsEdge
cp $NaluRtestCWD/nightly/oversetFluidsEdge/oversetFluidsEdge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/oversetFluidsEdge
# run it...
./oversetFluidsEdge.sh

#=============================================================================
# concentricRad test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/concentricRad" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/concentricRad
fi

cd $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.i $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/*.g.* $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.sh $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.norm.gold $baseGitHubCWD/runNaluRtest/nightly/concentricRad
# run it...  
./concentricRad.sh

#=============================================================================
# movingCylinder test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/movingCylinder" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
fi

cd $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/movingCylinder.i $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/*.g.* $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/xml/milestone_aspect_ratio.xml $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/movingCylinder.sh $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/movingCylinder.norm.gold $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
# run it...  
./movingCylinder.sh

#=============================================================================
# elemBackStepLRSST test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST.i $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST_Input.i $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/*.g.* $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST.sh $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST_Input.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
# run it...  
./elemBackStepLRSST.sh

#=============================================================================
# ductWedge test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/ductWedge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/ductWedge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/ductWedge
cp $NaluRtestCWD/nightly/ductWedge/ductWedge.i $baseGitHubCWD/runNaluRtest/nightly/ductWedge
cp $NaluRtestCWD/nightly/ductWedge/ductWedge_Input.i $baseGitHubCWD/runNaluRtest/nightly/ductWedge
cp $NaluRtestCWD/mesh/ductwedge.g.* $baseGitHubCWD/runNaluRtest/nightly/ductWedge
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/ductWedge
cp $NaluRtestCWD/nightly/ductWedge/ductWedge.sh $baseGitHubCWD/runNaluRtest/nightly/ductWedge
cp $NaluRtestCWD/nightly/ductWedge/ductWedge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/ductWedge
cp $NaluRtestCWD/nightly/ductWedge/ductWedge_Input.norm.gold $baseGitHubCWD/runNaluRtest/nightly/ductWedge
# run it...  
./ductWedge.sh

#=============================================================================
# ductElemWedge test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/ductElemWedge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/ductElemWedge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/ductElemWedge
cp $NaluRtestCWD/nightly/ductElemWedge/ductElemWedge.i $baseGitHubCWD/runNaluRtest/nightly/ductElemWedge
cp $NaluRtestCWD/mesh/ductwedge.g.* $baseGitHubCWD/runNaluRtest/nightly/ductElemWedge
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/ductElemWedge
cp $NaluRtestCWD/nightly/ductElemWedge/ductElemWedge.sh $baseGitHubCWD/runNaluRtest/nightly/ductElemWedge
cp $NaluRtestCWD/nightly/ductElemWedge/ductElemWedge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/ductElemWedge
# run it...  
./ductElemWedge.sh

#=============================================================================
# heatedBackStep test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/heatedBackStep" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/heatedBackStep
fi

cd $baseGitHubCWD/runNaluRtest/nightly/heatedBackStep
cp $NaluRtestCWD/nightly/heatedBackStep/heatedBackStep.i $baseGitHubCWD/runNaluRtest/nightly/heatedBackStep
cp $NaluRtestCWD/nightly/heatedBackStep/*.g.* $baseGitHubCWD/runNaluRtest/nightly/heatedBackStep
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/heatedBackStep
cp $NaluRtestCWD/nightly/heatedBackStep/heatedBackStep.sh $baseGitHubCWD/runNaluRtest/nightly/heatedBackStep
cp $NaluRtestCWD/nightly/heatedBackStep/heatedBackStep.norm.gold $baseGitHubCWD/runNaluRtest/nightly/heatedBackStep
# run it...
./heatedBackStep.sh


#=============================================================================
# edgePipeCHT test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.i $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/mesh/elbow.g.* $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/mesh/horseshoe.g.* $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.sh $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
# run it...  
./edgePipeCHT.sh

#=============================================================================
# elemPipeCHT test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemPipeCHT" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemPipeCHT
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemPipeCHT
cp $NaluRtestCWD/nightly/elemPipeCHT/elemPipeCHT.i $baseGitHubCWD/runNaluRtest/nightly/elemPipeCHT
cp $NaluRtestCWD/mesh/elbow.g.* $baseGitHubCWD/runNaluRtest/nightly/elemPipeCHT
cp $NaluRtestCWD/mesh/horseshoe.g.* $baseGitHubCWD/runNaluRtest/nightly/elemPipeCHT
cp $NaluRtestCWD/nightly/elemPipeCHT/elemPipeCHT.sh $baseGitHubCWD/runNaluRtest/nightly/elemPipeCHT
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/elemPipeCHT
cp $NaluRtestCWD/nightly/elemPipeCHT/elemPipeCHT.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemPipeCHT
# run it...  
./elemPipeCHT.sh

#=============================================================================
# heliumPlume test (with restart; mixed edge/element)
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/heliumPlume" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/heliumPlume
fi

cd $baseGitHubCWD/runNaluRtest/nightly/heliumPlume
cp $NaluRtestCWD/nightly/heliumPlume/heliumPlumeEdge.i $baseGitHubCWD/runNaluRtest/nightly/heliumPlume
cp $NaluRtestCWD/nightly/heliumPlume/heliumPlumeElem_rst.i $baseGitHubCWD/runNaluRtest/nightly/heliumPlume
cp $NaluRtestCWD/nightly/heliumPlume/*.g.* $baseGitHubCWD/runNaluRtest/nightly/heliumPlume
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/heliumPlume
cp $NaluRtestCWD/nightly/heliumPlume/heliumPlume.sh $baseGitHubCWD/runNaluRtest/nightly/heliumPlume
cp $NaluRtestCWD/nightly/heliumPlume/heliumPlumeEdge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/heliumPlume
cp $NaluRtestCWD/nightly/heliumPlume/heliumPlumeElem_rst.norm.gold $baseGitHubCWD/runNaluRtest/nightly/heliumPlume

# run it...  
./heliumPlume.sh

#=============================================================================
# dgNonConformalEdgeCylinder test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdgeCylinder" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdgeCylinder
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdgeCylinder
cp $NaluRtestCWD/nightly/dgNonConformalEdgeCylinder/dgNonConformalEdgeCylinder.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdgeCylinder
cp $NaluRtestCWD/mesh/rot_cyl_14.exo* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdgeCylinder
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdgeCylinder
cp $NaluRtestCWD/nightly/dgNonConformalEdgeCylinder/dgNonConformalEdgeCylinder.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdgeCylinder
cp $NaluRtestCWD/nightly/dgNonConformalEdgeCylinder/dgNonConformalEdgeCylinder.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalEdgeCylinder
# run it...  
./dgNonConformalEdgeCylinder.sh

#=============================================================================
# dgNonConformalElemCylinder test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformalElemCylinder" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalElemCylinder
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalElemCylinder
cp $NaluRtestCWD/nightly/dgNonConformalElemCylinder/dgNonConformalElemCylinder.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalElemCylinder
cp $NaluRtestCWD/mesh/rot_cyl_14.exo* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalElemCylinder
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalElemCylinder
cp $NaluRtestCWD/nightly/dgNonConformalElemCylinder/dgNonConformalElemCylinder.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalElemCylinder
cp $NaluRtestCWD/nightly/dgNonConformalElemCylinder/dgNonConformalElemCylinder.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformalElemCylinder
# run it...  
./dgNonConformalElemCylinder.sh

#=============================================================================
# fluidsPmrChtPeriodic test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
fi

cd $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.i $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/*.g.* $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.sh $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.norm.gold $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
# run it...  
./fluidsPmrChtPeriodic.sh

#=============================================================================
# nonIsoElemOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
# run it...  
./nonIsoElemOpenJet.sh

#=============================================================================
# nonIsoEdgeOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
# run it...  
./nonIsoEdgeOpenJet.sh

#=============================================================================
# hdf5VarZChi test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/hdf5VarZChi" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/hdf5VarZChi
fi

cd $baseGitHubCWD/runNaluRtest/nightly/hdf5VarZChi
cp $NaluRtestCWD/nightly/hdf5VarZChi/hdf5VarZChi.i $baseGitHubCWD/runNaluRtest/nightly/hdf5VarZChi
cp $NaluRtestCWD/nightly/hdf5VarZChi/*.h5 $baseGitHubCWD/runNaluRtest/nightly/hdf5VarZChi
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/hdf5VarZChi
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/hdf5VarZChi
cp $NaluRtestCWD/nightly/hdf5VarZChi/hdf5VarZChi.sh $baseGitHubCWD/runNaluRtest/nightly/hdf5VarZChi
cp $NaluRtestCWD/nightly/hdf5VarZChi/hdf5VarZChi.norm.gold $baseGitHubCWD/runNaluRtest/nightly/hdf5VarZChi
# run it...  
#./hdf5VarZChi.sh

#=============================================================================
# elemHybridFluids test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/nightly/elemHybridFluids/elemHybridFluids.i $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/mesh/hybrid.g* $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/xml/milestone_aspect_ratio.xml $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/nightly/elemHybridFluids/elemHybridFluids.sh $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/nightly/elemHybridFluids/elemHybridFluids.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
# run it...  
./elemHybridFluids.sh

#=============================================================================
# elemHybridFluidsShift test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemHybridFluidsShift" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluidsShift
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluidsShift
cp $NaluRtestCWD/nightly/elemHybridFluidsShift/elemHybridFluidsShift.i $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluidsShift
cp $NaluRtestCWD/mesh/hybrid.g* $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluidsShift
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluidsShift
cp $NaluRtestCWD/nightly/elemHybridFluidsShift/elemHybridFluidsShift.sh $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluidsShift
cp $NaluRtestCWD/nightly/elemHybridFluidsShift/elemHybridFluidsShift.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluidsShift
# run it...  
./elemHybridFluidsShift.sh

#=============================================================================
# edgeHybridFluids test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/nightly/edgeHybridFluids/edgeHybridFluids.i $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/mesh/hybrid.g* $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/nightly/edgeHybridFluids/edgeHybridFluids.sh $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/nightly/edgeHybridFluids/edgeHybridFluids.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
# run it...  
./edgeHybridFluids.sh

#=============================================================================
# elemClosedDomain test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/elemClosedDomain.i $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/*.g.* $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/elemClosedDomain.sh $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/elemClosedDomain.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
# run it...  
./elemClosedDomain.sh

#=============================================================================
# mixedTetPipe test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
fi

cd $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/nightly/mixedTetPipe/mixedTetPipe.i $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/mesh/pipeTet.g* $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/nightly/mixedTetPipe/mixedTetPipe.sh $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/nightly/mixedTetPipe/mixedTetPipe.norm.gold $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
# run it...  
./mixedTetPipe.sh

#=============================================================================
# inputFireEdgeUpwind test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
fi

cd $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
cp $NaluRtestCWD/nightly/inputFireEdgeUpwind/inputFireEdgeUpwind.i $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
cp $NaluRtestCWD/mesh/13K_oneWay.e.* $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
cp $NaluRtestCWD/nightly/inputFireEdgeUpwind/inputFireEdgeUpwind.sh $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
cp $NaluRtestCWD/nightly/inputFireEdgeUpwind/inputFireEdgeUpwind.norm.gold $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
# run it...  
./inputFireEdgeUpwind.sh

#=============================================================================
# inputFireElem test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/inputFireElem" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/inputFireElem
fi

cd $baseGitHubCWD/runNaluRtest/nightly/inputFireElem
cp $NaluRtestCWD/nightly/inputFireElem/inputFireElem.i $baseGitHubCWD/runNaluRtest/nightly/inputFireElem
cp $NaluRtestCWD/mesh/13K_oneWay.e.* $baseGitHubCWD/runNaluRtest/nightly/inputFireElem
cp $NaluRtestCWD/nightly/inputFireElem/inputFireElem.sh $baseGitHubCWD/runNaluRtest/nightly/inputFireElem
cp $NaluRtestCWD/nightly/inputFireElem/inputFireElem.norm.gold $baseGitHubCWD/runNaluRtest/nightly/inputFireElem
# run it...  
./inputFireElem.sh

#=============================================================================
# nonIsoNonUniformEdgeOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet" ]; then
mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformElemOpenJet/nonIsoNonUniformElemOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformElemOpenJet/nonIsoNonUniformElemOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformElemOpenJet/nonIsoNonUniformElemOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
# run it...
./nonIsoNonUniformElemOpenJet.sh

#=============================================================================
# nonIsoNonUniformEdgeOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet" ]; then
mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformEdgeOpenJet/nonIsoNonUniformEdgeOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
cp $NaluRtestCWD/xml/matches_ml_default.xml $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformEdgeOpenJet/nonIsoNonUniformEdgeOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformEdgeOpenJet/nonIsoNonUniformEdgeOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
# run it...
./nonIsoNonUniformEdgeOpenJet.sh

#=============================================================================
# milestoneRun test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/milestoneRun" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
fi

cd $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/nightly/milestoneRun/milestoneRun.i $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/mesh/1cm_ped_35K.g $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/nightly/milestoneRun/milestoneRun.sh $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/nightly/milestoneRun/milestoneRun.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
# run it...  
./milestoneRun.sh

#=============================================================================
# heatedWaterChannel test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
fi

cd $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/nightly/heatedWaterChannel/heatedWaterChannelEdge.i $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/nightly/heatedWaterChannel/heatedWaterChannelElem.i $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/nightly/heatedWaterChannel/heatedWaterChannelEdgeRst.i $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/nightly/heatedWaterChannel/*.g.* $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/xml/milestone_aspect_ratio.xml $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/nightly/heatedWaterChannel/heatedWaterChannel.sh $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/nightly/heatedWaterChannel/heatedWaterChannelEdge.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/nightly/heatedWaterChannel/heatedWaterChannelElem.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
cp $NaluRtestCWD/nightly/heatedWaterChannel/heatedWaterChannelEdgeRst.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/heatedWaterChannel
# run it...  
./heatedWaterChannel.sh

#=============================================================================
# variableDensMMS test (edge and element)
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/variableDensMMS" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS
fi

cd $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS
cp $NaluRtestCWD/nightly/variableDensMMS/*.i $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS
cp $NaluRtestCWD/nightly/variableDensMMS/*.g $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS
cp $NaluRtestCWD/nightly/variableDensMMS/variableDensMMS.sh $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS
cp $NaluRtestCWD/nightly/variableDensMMS/*.norm.gold $baseGitHubCWD/runNaluRtest/nightly/variableDensMMS

# run it...  
./variableDensMMS.sh

#=============================================================================
# actuatorLine test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/actuatorLine" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/actuatorLine
fi

cd $baseGitHubCWD/runNaluRtest/nightly/actuatorLine
cp $NaluRtestCWD/nightly/actuatorLine/actuatorLine.i $baseGitHubCWD/runNaluRtest/nightly/actuatorLine
cp $NaluRtestCWD/nightly/actuatorLine/*.g $baseGitHubCWD/runNaluRtest/nightly/actuatorLine
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/actuatorLine
cp $NaluRtestCWD/nightly/actuatorLine/actuatorLine.sh $baseGitHubCWD/runNaluRtest/nightly/actuatorLine
cp $NaluRtestCWD/nightly/actuatorLine/actuatorLine.norm.gold $baseGitHubCWD/runNaluRtest/nightly/actuatorLine

# run it...  
./actuatorLine.sh

#=============================================================================
# femHC test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/femHC" ]; then
mkdir $baseGitHubCWD/runNaluRtest/nightly/femHC
fi

cd $baseGitHubCWD/runNaluRtest/nightly/femHC
cp $NaluRtestCWD/nightly/femHC/femHC.i $baseGitHubCWD/runNaluRtest/nightly/femHC
cp $NaluRtestCWD/mesh/periodic3d.g $baseGitHubCWD/runNaluRtest/nightly/femHC
cp $NaluRtestCWD/nightly/femHC/femHC.sh $baseGitHubCWD/runNaluRtest/nightly/femHC
cp $NaluRtestCWD/nightly/femHC/femHC.norm.gold $baseGitHubCWD/runNaluRtest/nightly/femHC
# run it...
./femHC.sh

#=============================================================================
# cvfemHC test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/cvfemHC" ]; then
mkdir $baseGitHubCWD/runNaluRtest/nightly/cvfemHC
fi

cd $baseGitHubCWD/runNaluRtest/nightly/cvfemHC
cp $NaluRtestCWD/nightly/cvfemHC/cvfemHC.i $baseGitHubCWD/runNaluRtest/nightly/cvfemHC
cp $NaluRtestCWD/nightly/cvfemHC/cvfemHC_nodebal.i $baseGitHubCWD/runNaluRtest/nightly/cvfemHC
cp $NaluRtestCWD/mesh/rot_cyl_14.exo* $baseGitHubCWD/runNaluRtest/nightly/cvfemHC
cp $NaluRtestCWD/nightly/cvfemHC/cvfemHC.sh $baseGitHubCWD/runNaluRtest/nightly/cvfemHC
cp $NaluRtestCWD/nightly/cvfemHC/cvfemHC.norm.gold $baseGitHubCWD/runNaluRtest/nightly/cvfemHC
cp $NaluRtestCWD/nightly/cvfemHC/cvfemHC_nodebal.norm.gold $baseGitHubCWD/runNaluRtest/nightly/cvfemHC
# run it...
./cvfemHC.sh

#=============================================================================
# ablUnstableEdge test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge
cp $NaluRtestCWD/nightly/ablUnstableEdge/ablUnstableEdge.i $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge
cp $NaluRtestCWD/nightly/ablUnstableEdge/ablUnstableEdge_using_external.i $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge
cp $NaluRtestCWD/mesh/abl_1km_cube_toy.g $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge
cp $NaluRtestCWD/mesh/abl_io.g $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge
cp $NaluRtestCWD/nightly/ablUnstableEdge/ablUnstableEdge.sh $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge
cp $NaluRtestCWD/nightly/ablUnstableEdge/ablUnstableEdge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge
cp $NaluRtestCWD/nightly/ablUnstableEdge/ablUnstableEdge_using_external.norm.gold $baseGitHubCWD/runNaluRtest/nightly/ablUnstableEdge

# run it...  
./ablUnstableEdge.sh

#=============================================================================
# ablStableElem test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/ablStableElem" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/ablStableElem
fi

cd $baseGitHubCWD/runNaluRtest/nightly/ablStableElem
cp $NaluRtestCWD/nightly/ablStableElem/ablStableElem.i $baseGitHubCWD/runNaluRtest/nightly/ablStableElem
cp $NaluRtestCWD/nightly/ablStableElem/ablStableElemMoeng.i $baseGitHubCWD/runNaluRtest/nightly/ablStableElem
cp $NaluRtestCWD/mesh/abl_1km_cube_toy.g $baseGitHubCWD/runNaluRtest/nightly/ablStableElem
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/ablStableElem
cp $NaluRtestCWD/nightly/ablStableElem/ablStableElem.sh $baseGitHubCWD/runNaluRtest/nightly/ablStableElem
cp $NaluRtestCWD/nightly/ablStableElem/ablStableElem.norm.gold $baseGitHubCWD/runNaluRtest/nightly/ablStableElem
cp $NaluRtestCWD/nightly/ablStableElem/ablStableElemMoeng.norm.gold $baseGitHubCWD/runNaluRtest/nightly/ablStableElem

# run it...  
./ablStableElem.sh

#=============================================================================
# ekmanSpiral test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/ekmanSpiral" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/ekmanSpiral
fi

cd $baseGitHubCWD/runNaluRtest/nightly/ekmanSpiral
cp $NaluRtestCWD/nightly/ekmanSpiral/ekmanSpiral.i $baseGitHubCWD/runNaluRtest/nightly/ekmanSpiral
cp $NaluRtestCWD/mesh/ekmanSpiral.g $baseGitHubCWD/runNaluRtest/nightly/ekmanSpiral
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/ekmanSpiral
cp $NaluRtestCWD/nightly/ekmanSpiral/ekmanSpiral.sh $baseGitHubCWD/runNaluRtest/nightly/ekmanSpiral
cp $NaluRtestCWD/nightly/ekmanSpiral/ekmanSpiral.norm.gold $baseGitHubCWD/runNaluRtest/nightly/ekmanSpiral

# run it...
./ekmanSpiral.sh

#=============================================================================
# ABL Forcing Test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/ablForcingEdge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/ablForcingEdge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/ablForcingEdge
cp $NaluRtestCWD/nightly/ablForcingEdge/ablForcingEdge.i $baseGitHubCWD/runNaluRtest/nightly/ablForcingEdge
cp $NaluRtestCWD/nightly/ablForcingEdge/abl_1km_cube_sample.g $baseGitHubCWD/runNaluRtest/nightly/ablForcingEdge
cp $NaluRtestCWD/xml/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/ablForcingEdge
cp $NaluRtestCWD/nightly/ablForcingEdge/ablForcingEdge.sh $baseGitHubCWD/runNaluRtest/nightly/ablForcingEdge
cp $NaluRtestCWD/nightly/ablForcingEdge/ablForcingEdge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/ablForcingEdge

# run it...
./ablForcingEdge.sh

#=============================================================================
# dg MMS test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgMMS" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgMMS
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgMMS
cp $NaluRtestCWD/nightly/dgMMS/dgMMS.i $baseGitHubCWD/runNaluRtest/nightly/dgMMS
cp $NaluRtestCWD/nightly/dgMMS/*.g $baseGitHubCWD/runNaluRtest/nightly/dgMMS
cp $NaluRtestCWD/nightly/dgMMS/dgMMS.sh $baseGitHubCWD/runNaluRtest/nightly/dgMMS
cp $NaluRtestCWD/nightly/dgMMS/dgMMS.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgMMS

# run it...  
./dgMMS.sh

#=============================================================================
# unit tests
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/unitTests" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/unitTests
fi

cd $baseGitHubCWD/runNaluRtest/nightly/unitTests
cp $NaluRtestCWD/nightly/unitTests/run_unit_tests.sh $baseGitHubCWD/runNaluRtest/nightly/unitTests

# run it...  
./run_unit_tests.sh

echo "Rtest End"
