#!/bin/sh

CC_LIST="gcc clang"

echo "===== INFO ====="

for CC in $CC_LIST; do
    $CC --version
done

echo "================"
echo ""

echo '$ cat src/tiny.c'
cat src/tiny.c

mkdir -p build

echo ""

# compile

echo "===== compile ====="

for CC in $CC_LIST; do
    echo "$ $CC src/tiny.c -o build/tiny-c-$CC"
    $CC src/tiny.c -o build/tiny-c-$CC

    echo "$ build/tiny-c-$CC ; echo \$?"
    build/tiny-c-$CC ; echo $?

    echo "$ ls -l build/tiny-c-$CC"
    ls -l build/tiny-c-$CC

    echo ""
done

echo "==================="

# compile with strip

echo "===== compile with strip ====="

for CC in $CC_LIST; do
    echo "$ $CC -s src/tiny.c -o build/tiny-c-s-$CC"
    $CC -s src/tiny.c -o build/tiny-c-s-$CC

    echo "$ build/tiny-c-s-$CC ; echo \$?"
    build/tiny-c-s-$CC ; echo $?

    echo "$ ls -l build/tiny-c-s-$CC"
    ls -l build/tiny-c-s-$CC

    echo ""
done

echo "=============================="

# compile with strip and optimize

echo "===== compile with strip and optimize ====="

for CC in $CC_LIST; do
    echo "$ $CC -O3 -s src/tiny.c -o build/tiny-c-s-opt-$CC"
    $CC -O3 -s src/tiny.c -o build/tiny-c-s-opt-$CC

    echo "$ build/tiny-c-s-opt-$CC ; echo \$?"
    build/tiny-c-s-opt-$CC ; echo $?

    echo "$ ls -l build/tiny-c-s-opt-$CC"
    ls -l build/tiny-c-s-opt-$CC

    echo ""
done

echo "==========================================="
