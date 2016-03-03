# Run in msys2 in order to pick up mingw-w64 gcc
build_dir=$1
out_dir=$2
if [ -z "$build_dir" ]; then
    echo "Specify build directory to process"
    exit 1
fi
if [ -z "$out_dir" ]; then
    echo "Specify output directory"
    exit 1
fi
if [ $build_dir == $out_dir ]; then
    echo "Out directory should differ from build directory"
fi
mkdir -p $out_dir
cp -r ${build_dir}/lib ${build_dir}/include $out_dir
cd ${out_dir}/lib
GCC=gcc
$GCC -m64 -shared \
   -static \
   -o numpy-atlas.dll -Wl,--output-def=numpy-atlas.def \
   -Wl,--whole-archive liblapack.a libf77blas.a libcblas.a libatlas.a \
	-Wl,--no-whole-archive \
	 -lgfortran -lgcc -lkernel32 -lm -lgcc -lpthread -lquadmath
rm lib*.a Make*
echo "Processed files in $out_dir"
