#ifndef LISTMODELLIB_H
#define LISTMODELLIB_H


/*
 * https://stackoverflow.com/questions/44777999/manipulate-data-in-a-qabstractlistmodel-from-a-qml-listview
 * https://stackoverflow.com/questions/55695104/how-can-i-show-a-single-item-of-a-qabstractlistmodel-and-update-the-gui-when-dat
 * https://github.com/dientului/QMLIntegratingCpp-MVC
 * https://gist.github.com/lomedil/9e0d9262fdb3765128db
*/

#include <QDebug>
#include <QList>
#include <QQmlEngine>
#include <QObject>
#include <QAbstractListModel>

struct MyListItem {
    int bType;
    QString bColor;
    int bValue;
};

class MyListModel: public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)

private:
    QList<MyListItem> m_list;

    int m_count;

public:
    enum MyRoles {
        TypeRole = Qt::UserRole + 1,
        ColorRole,
        ValueRole
    };

    MyListModel(QObject *parent = nullptr): QAbstractListModel(parent){}

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;

    int count() const;
    void setCount(int newCount);

public slots:
    /**
     * @brief addItem: add new item
     * @param name
     * @param role
     * @param age
     */
    void addItem(const int bType, const QString bColor, const int bValue);

    /**
     * @brief clearList: clear list
     */
    void clearList();

signals:
    void countChanged();

protected:
    QHash<int, QByteArray> roleNames() const override;

};


#endif // LISTMODELLIB_H
