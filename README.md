# cuda_video_inverter
A simple program using NVIDIA'S CUDA to invert a video's colors

Dependencies:

- qmake : To build qt
- CUDA toolkit : To build cuda program
- make : To build the binary
- OpenCV : To read and write video file

Build:

Generate Makefile:

```
qmake cuda_video_inverter
```

Build program:

```
make
```

The output binary is stored in `build/bin`.
