#include<QMainWindow>
#include<QPushButton>
#include<QtWidgets>
#include<QString>
#include<QBoxLayout>

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
        QWidget *window = new QWidget;
        QString input_video_file = "";
        QLabel *input_video_label = new QLabel(input_video_file, window);
        QHBoxLayout *buttons = new QHBoxLayout(window);
        QPushButton *browse_file;
        QPushButton *invert_video_button;
};