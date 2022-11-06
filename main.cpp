#include"cuda.h"
// #include"mainwindow.h"
#include"mainwindow.cpp"

int main(int argc, char *argv[])
{
	QApplication app(argc, argv);
    MainWindow test;
    test.show();
	return app.exec();
}
