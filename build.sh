cd device && tar cJvf ../device.tar.xz *
cd -

cd extracted && snappy build -o ../
cd -

sudo ubuntu-device-flash core 15.04 \
    --size 4 \
    --channel edge \
    --enable-ssh \
    --oem bpi-m2_0.01_all.snap \
    --developer-mode \
    --device-part=device.tar.xz \
    -o my_bananpi_m2.img
