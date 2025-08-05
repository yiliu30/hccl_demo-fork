source 
export IBFABRIC_ROOT=/opt/libfabric
echo $LIBFABRIC_ROOT
export LD_LIBRARY_PATH=$LIBFABRIC_ROOT/lib:$LD_LIBRARY_PATH
fi_info --version
echo $LD_LIBRARY_PATH
# cd /opt/libfabric/lib
# 202  ls
#   203  cd -
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/habanalabs/