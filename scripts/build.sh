echo "Build .net core runtime (coreclr) v3.1.x for Linux ARM vfpv3-d16"

workDir="."
if [ "$1" != "" ]
    workDir=$1
fi
echo "workDir: '${workDir}'"
cd ${workDir}

#echo "Official GIT:"
#git clone --branch release/3.1 --depth 1 git@github.com:dotnet/coreclr.git coreclr31

echo "Forked GIT:"
git clone --branch 3.1-linux-arm-vfpv3-d16 --depth 1 git@github.com:hopix/coreclr.git coreclr31.fork


docker run --rm -v ${PWD}/coreclr31.fork:/coreclr -w /coreclr -e ROOTFS_DIR=/crossrootfs/arm mcr.microsoft.com/dotnet-buildtools/prereqs:ubuntu-16.04-cross-14.04-23cacb0-20190528233931 ./build.sh -arm -Release -cross -stripsymbols -skiptests -skipnuget -cmakeargs -DCLR_ARM_FPU_CAPABILITY=0x3 -cmakeargs -DCLR_ARM_FPU_TYPE=vfpv3-d16

