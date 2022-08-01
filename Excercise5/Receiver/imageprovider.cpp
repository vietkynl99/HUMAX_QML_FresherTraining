#include "imageprovider.h"

ImageProvider::ImageProvider(): QQuickImageProvider(QQuickImageProvider::Image)
{
    image = QImage(1, 1, QImage::Format_RGB32);
}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(id);
    qDebug() << "request image";
    //        QString rsrcid = ":/" + id;
    //            QImage image(rsrcid);

    if (requestedSize.isValid())
    {
        image = image.scaled(requestedSize, Qt::KeepAspectRatio);
    }
    *size = image.size();
    return image;
}

