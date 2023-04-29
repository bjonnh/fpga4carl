```
docker build -t fpga4a . ; docker run -it --rm -v $PWD:/out fpga4a bash
TARGET=arty_100 make -C counter_test
cp counter_test/build/arty_100/top.bit /out
```
