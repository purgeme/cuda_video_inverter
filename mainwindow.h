#include<QMainWindow>
#include<QPushButton>
#include<QtWidgets>
#include<QString>

class MainWindow : public QMainWindow
{
    Q_OBJECT

    public:
        explicit MainWindow(QWidget *parent = 0);
        ~MainWindow(); 

    private slots:
        void browse_files();
        void invert_video();

    private:
        QPushButton *browse_file;
        QPushButton *invert_video_button;
        QString input_video_file;
};