#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QObject>
#include <QDebug>
#include <QImage>
#include <QQuickImageProvider>


class ImageProvider : public QObject, public QQuickImageProvider
{
    Q_OBJECT

public:
    QImage image;

    ImageProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;
};

extern ImageProvider *imgProvider;

#endif // IMAGEPROVIDER_H
