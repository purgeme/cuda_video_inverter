#include"cuda.h"
#include <stdio.h>
#include <iostream>
#include <string>

#include <cuda_runtime.h>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

#define T 32

using namespace cv;
using namespace std;

__global__ void Inversion(unsigned char* image, unsigned char* image_inv, int size) {

	int pixel = blockIdx.x*blockDim.x+threadIdx.x;

	unsigned char mcolor = '255';
	if ( pixel < size)
	{
		image_inv[pixel] = mcolor-image[pixel];
	}  
}

int cuda_run(string input_video)
{
	VideoCapture inp_vcap(input_video);
	if(!inp_vcap.isOpened()) return -1;

	Mat img;
	inp_vcap >> img;
	bool isColor = (img.type() == CV_8UC3);
	Size imgsize = img.size();
	int width = imgsize.width;
	int height = imgsize.height;
	Mat img_invert(height,width,CV_8UC3,Scalar(0,0,0));

	unsigned char* charImg = img.data;
	unsigned char* newImg = img_invert.data;

	int uCharSize = height*width*3*sizeof(unsigned char);

	unsigned char *devImg,*devInv;

	int vecSize = height*width*3;
	int blocks = (vecSize+T-1)/T;

	VideoWriter writer;
    int codec = VideoWriter::fourcc('a', 'v', 'c', '1');  // select desired codec (must be available at runtime)
    double fps = 25.0;                          // framerate of the created video stream
    string filename = "output_video.mp4";             // name of the output video file
    writer.open(filename, codec, fps, img.size(), isColor);
    // check if we succeeded
    if (!writer.isOpened()) {
        cerr << "Could not open the output video file for write\n";
        return -1;
    }

	// Mat img = imread(imgfile,IMREAD_COLOR);

	while(inp_vcap.isOpened()){
		if (img.empty()){
  	      break;
		}

		cudaMalloc((void**) &devImg, uCharSize);
		cudaMalloc((void**) &devInv, uCharSize);

		cudaMemcpy(devImg,charImg,uCharSize,cudaMemcpyHostToDevice);
		cudaMemcpy(devInv,newImg,uCharSize,cudaMemcpyHostToDevice);

		Inversion<<<blocks,T>>>  (devImg,devInv,vecSize);

		cudaMemcpy(charImg,devImg,uCharSize,cudaMemcpyDeviceToHost);
		cudaMemcpy(newImg,devInv,uCharSize,cudaMemcpyDeviceToHost);

		cudaFree(devImg);
		cudaFree(devInv);
		
		Mat output = Mat(height,width,CV_8UC3, newImg);

		writer.write(output);
		// imshow("Inverted Image",output);

		if (waitKey(5) >= 0) break;
		
		inp_vcap >> img;
	}
	destroyAllWindows();
	return 0;
}

