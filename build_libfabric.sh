#! /bin/bash

set -x

export REQUIRED_VERSION=1.20.0
wget  https://github.com/ofiwg/libfabric/releases/download/v$REQUIRED_VERSION/libfabric-$REQUIRED_VERSION.tar.bz2 -P /tmp/libfabric
pushd /tmp/libfabric
tar -xf libfabric-$REQUIRED_VERSION.tar.bz2
export LIBFABRIC_ROOT="/usr"
mkdir -p ${LIBFABRIC_ROOT}
chmod 777 ${LIBFABRIC_ROOT}
cd libfabric-$REQUIRED_VERSION/
./configure --prefix=$LIBFABRIC_ROOT --with-synapseai=/usr
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