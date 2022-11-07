#include"mainwindow.h"

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent)
{
    browse_file = new QPushButton("Browse Files");
    connect(browse_file, SIGNAL(clicked()), this, SLOT(browse_files()));
    buttons->addWidget(browse_file);

    invert_video_button = new QPushButton("Invert video");
    connect(invert_video_button, SIGNAL(clicked()), this, SLOT(invert_video()));
    buttons->addWidget(invert_video_button);
    
    this->setCentralWidget(window);
}

void MainWindow::browse_files()
{
    input_video_file = QDir::toNativeSeparators(QFileDialog::getOpenFileName(this, tr("Find Files"), QDir::currentPath()));
    input_video_label->setText("Input File: " + input_video_file);
    input_video_label->adjustSize();
}

void MainWindow::invert_video()
{
    cuda_run(input_video_file.toStdString());
}

MainWindow::~MainWindow()
{
    delete invert_video_button;
    delete browse_file;
    delete buttons;
    delete input_video_label;
    delete window;
}