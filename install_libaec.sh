# libaec implements szip compression, so the optional szip filter can be built
# in HDF5.
set -euo pipefail

pushd /tmp

aec_version="1.1.4"

echo "Downloading libaec"
curl -fsSLO https://gitlab.dkrz.de/k202009/libaec/-/archive/v${aec_version}/libaec-v${aec_version}.tar.gz
tar zxf libaec-v$aec_version.tar.gz

echo "Building & installing libaec"
pushd libaec-v$aec_version
mkdir build
cmake -S . -B build \
    -D CMAKE_BUILD_TYPE=Release \
    -D BUILD_STATIC_LIBS=OFF \
    -D BUILD_TESTING=OFF
make -C build -j "$(nproc)"
make -C build install

# Clean up the files from the build
popd
rm -r libaec-v$aec_version libaec-v$aec_version.tar.gz
