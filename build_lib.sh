GCC=i686-pc-mingw32-gcc
$GCC -fomit-frame-pointer -mfpmath=sse -O2 -msse2 -m32  -shared \
   -static \
   -o test.dll -Wl,--output-def=test.def \
   -Wl,--whole-archive test.o \
	-Wl,--no-whole-archive \
	 -lgfortran -lgcc -lkernel32 -lm -lgcc
