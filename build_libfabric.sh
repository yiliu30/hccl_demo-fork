# source 
# export IBFABRIC_ROOT=/opt/libfabric
# echo $LIBFABRIC_ROOT
# export LD_LIBRARY_PATH=$LIBFABRIC_ROOT/lib:$LD_LIBRARY_PATH
# fi_info --version
# echo $LD_LIBRARY_PATH
# cd /opt/libfabric/lib
# 202  ls
#   203  cd -
#   204  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/habanalabs/

#! /bin/bash

set -x

export REQUIRED_VERSION=1.20.0
wget  https://github.com/ofiwg/libfabric/releases/download/v$REQUIRED_VERSION/libfabric-$REQUIRED_VERSION.tar.bz2 -P /tmp/libfabric
pushd /tmp/libfabric
tar -xf libfabric-$REQUIRED_VERSION.tar.bz2
# export LIBFABRIC_ROOT="/usr"
export LIBFABRIC_ROOT=/opt/libfabric
mkdir -p ${LIBFABRIC_ROOT}
chmod 777 ${LIBFABRIC_ROOT}
cd libfabric-$REQUIRED_VERSION/
./configure --prefix=$LIBFABRIC_ROOT --with-synapseai=/usr --enable-verbs=yes
make -j 32 && make install
popd
rm -rf /tmp/libfabric
export LD_LIBRARY_PATH=$LIBFABRIC_ROOT/lib:$LD_LIBRARY_PATH
fi_info --version

git clone https://github.com/HabanaAI/hccl_ofi_wrapper.git
# export LIBFABRIC_ROOT=/tmp/libfabric-1.20.0
cd hccl_ofi_wrapper
make
cp libhccl_ofi_wrapper.so /usr/lib/habanalabs/libhccl_ofi_wrapper.so
ldconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/habanalabs/