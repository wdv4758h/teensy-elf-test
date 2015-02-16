#!/bin/sh

CC_LIST="gcc clang"
ASM="nasm"

BUILD="build"

echo "===== INFO ====="

for CC in $CC_LIST; do
    $CC --version
done

$ASM -v

echo "================"
echo ""

echo '$ cat src/tiny.c'
cat src/tiny.c

mkdir -p $BUILD

echo ""

# compile

echo "===== compile ====="

for CC in $CC_LIST; do
    echo "$ $CC src/tiny.c -o $BUILD/tiny-c-$CC"
    $CC src/tiny.c -o $BUILD/tiny-c-$CC

    echo "$ $BUILD/tiny-c-$CC ; echo \$?"
    $BUILD/tiny-c-$CC ; echo $?

    echo "$ ls -l $BUILD/tiny-c-$CC"
    ls -l $BUILD/tiny-c-$CC

    echo ""
done

echo "==================="

# compile with strip

echo "===== compile with strip ====="

for CC in $CC_LIST; do
    echo "$ $CC -s src/tiny.c -o $BUILD/tiny-c-s-$CC"
    $CC -s src/tiny.c -o $BUILD/tiny-c-s-$CC

    echo "$ $BUILD/tiny-c-s-$CC ; echo \$?"
    $BUILD/tiny-c-s-$CC ; echo $?

    echo "$ ls -l $BUILD/tiny-c-s-$CC"
    ls -l $BUILD/tiny-c-s-$CC

    echo ""
done

echo "=============================="

# compile with strip and optimize

echo "===== compile with strip and optimize ====="

for CC in $CC_LIST; do
    echo "$ $CC -O3 -s src/tiny.c -o $BUILD/tiny-c-s-opt-$CC"
    $CC -O3 -s src/tiny.c -o $BUILD/tiny-c-s-opt-$CC

    echo "$ $BUILD/tiny-c-s-opt-$CC ; echo \$?"
    $BUILD/tiny-c-s-opt-$CC ; echo $?

    echo "$ ls -l $BUILD/tiny-c-s-opt-$CC"
    ls -l $BUILD/tiny-c-s-opt-$CC

    echo ""
done

echo "==========================================="

# assembly

# assembly without standard system startup files

# assembly without standard system startup files or libraries

echo "===== asm with -nostdlib  ====="

echo "$ $ASM -f elf64 src/tiny-nostdlib.asm -o $BUILD/tiny-asm-nostdlib-$ASM.o"
$ASM -f elf64 src/tiny-nostdlib.asm -o $BUILD/tiny-asm-nostdlib-$ASM.o

for CC in $CC_LIST; do
    echo "$ $CC -s -nostdlib $BUILD/tiny-asm-nostdlib-$ASM.o -o tiny-asm-nostdlib-$ASM-$CC"
    $CC -s -nostdlib $BUILD/tiny-asm-nostdlib-$ASM.o -o $BUILD/tiny-asm-nostdlib-$ASM-$CC

    echo "$ $BUILD/tiny-asm-nostdlib-$ASM-$CC ; echo \$?"
    $BUILD/tiny-asm-nostdlib-$ASM-$CC ; echo $?

    echo "$ ls -l $BUILD/tiny-asm-nostdlib-$ASM-$CC"
    ls -l $BUILD/tiny-asm-nostdlib-$ASM-$CC

    echo ""
done
