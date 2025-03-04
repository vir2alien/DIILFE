#include "filehandler.h"
#include <QUrl>
#include <QFile>
#include <QTextStream>

FileHandler::FileHandler(QObject *parent)
    : QObject{parent}
{}

bool FileHandler::fileExists(const QUrl &file_path) const
{
    QString path = file_path.toLocalFile();
    QFile file(path);
    return file.exists();
}

QString FileHandler::readFile(const QUrl &file_path) const
{
    QString path = file_path.toLocalFile();
    QFile file(path);

    QString txt;
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return txt;
    }

    QTextStream in(&file);
    QString content = in.readAll();
    file.close();
    return content;
}

void FileHandler::writeFile(const QUrl &file_path, const QString &data) const
{
    QString path = file_path.toLocalFile();
    QFile file(path);

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        return;
    }

    QTextStream out(&file);
    out << data;
    file.close();
}
