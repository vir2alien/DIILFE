#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>

class FileHandler : public QObject
{
    Q_OBJECT
public:
    explicit FileHandler(QObject *parent = nullptr);
    Q_INVOKABLE bool fileExists(const QUrl &file_path) const;
    Q_INVOKABLE QString readFile(const QUrl &file_path) const;
    Q_INVOKABLE void writeFile(const QUrl &file_path, const QString &data) const;
};

#endif // FILEHANDLER_H
