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
#include <QFile>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>

#define FILENAME "saveFile.json"

struct MyListItem {
    int idx;
    QString name;
    int role;
    int age;
};

class MyListModel: public QAbstractListModel
{
    Q_OBJECT

private:
    QList<MyListItem> m_list;

    /**
     * @brief sortItem: sort by Role: Team Leader > Developer > BA > Tester
     */
    void sortItem();

public:
    enum MyRoles {
        IdxRole = Qt::UserRole + 1,
        NameRole,
        PositionRole,
        AgeRole
    };

    MyListModel(QObject *parent = nullptr): QAbstractListModel(parent){}

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;

public slots:
    /**
     * @brief addItem: add new item
     * @param name
     * @param role
     * @param age
     */
    void addItem(QString const name, const int role, const int age);

    /**
     * @brief removeItem: remove item by index
     * @param index
     */
    void removeItem(const int &index);

    /**
     * @brief get: get data in list
     * @param index
     * @return
     */
    QVariant getItem(const int index);

    /**
     * @brief updateItem: update new item data
     * @param name
     * @param role
     * @param age
     * @param index
     * @return
     */
    void updateItem(const int index, const QString name, const int role, const int age);


    /**
     * @brief saveListModelToFile: save list to json file
     */
    void saveListToFile();

    /**
     * @brief loadListModelFromFile: load list from json file
     */
    void loadListFromFile();

protected:
    QHash<int, QByteArray> roleNames() const override;

};


#endif // LISTMODELLIB_H
