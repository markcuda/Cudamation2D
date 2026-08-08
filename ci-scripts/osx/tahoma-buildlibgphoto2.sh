#!/bin/bash
set -euo pipefail

cd thirdparty

echo ">>> Cloning libgphoto2"
git clone https://github.com/tahoma2d/libgphoto2.git libgphoto2_src

cd libgphoto2_src

git checkout tahoma2d-version-2.5.34

echo ">>> Configuring libgphoto2"
autoreconf --install --symlink

GETTEXT_PREFIX="$(brew --prefix gettext)"
# Camera modules do not inherit libgphoto2's gettext link flags on macOS.
export CPPFLAGS="-I${GETTEXT_PREFIX}/include ${CPPFLAGS:-}"
export LDFLAGS="-L${GETTEXT_PREFIX}/lib ${LDFLAGS:-}"
export LIBS="-lintl ${LIBS:-}"
export PKG_CONFIG_PATH="${GETTEXT_PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH:-}"

./configure --prefix=/usr/local

echo ">>> Making libgphoto2"
make

echo ">>> Installing libgphoto2"
sudo make install

test -f /usr/local/include/gphoto2/gphoto2.h

cd ..
