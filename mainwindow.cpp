#include"mainwindow.h"

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent)
{
    browse_file = new QPushButton("Browse Files");
    this->setCentralWidget(browse_file);
    connect(browse_file, SIGNAL(clicked()), this, SLOT(browse_files()));
    invert_video_button = new QPushButton("Invert video");
    connect(invert_video_button, SIGNAL(clicked()), this, SLOT(invert_video()));
}

void MainWindow::browse_files()
{
    input_video_file = QDir::toNativeSeparators(QFileDialog::getOpenFileName(this, tr("Find Files"), QDir::currentPath()));
    this->setCentralWidget(invert_video_button);
}

void MainWindow::invert_video()
{
    cuda_run(input_video_file.toStdString());
}

MainWindow::~MainWindow()
{
    delete browse_file;
    delete invert_video_button;
}