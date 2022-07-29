#include "ListModelLib.h"


int MyListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_list.size();
}

QVariant MyListModel::data(const QModelIndex &index, int role) const
{
    if (!hasIndex(index.row(), index.column(), index.parent()))
    {
        return {};
    }
    const MyListItem &item = m_list.at(index.row());
    if (role == IdxRole)
    {
        return item.idx;
    }
    if (role == NameRole)
    {
        return item.name;
    }
    if (role == PositionRole)
    {
        return item.role;
    }
    if (role == AgeRole)
    {
        return item.age;
    }

    return {};
}

bool MyListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!hasIndex(index.row(), index.column(), index.parent()) || !value.isValid())
        return false;
    MyListItem &item = m_list[index.row()];
    if(role == IdxRole)
    {
        item.idx = value.toInt();
    }
    if (role == NameRole)
    {
        item.name = value.toString();
    }
    else if (role == PositionRole)
    {
        item.role = value.toInt();
    }
    else if (role == AgeRole)
    {
        item.age = value.toInt();
    }
    else
    {
        return false;
    }
    emit dataChanged(index, index, { role } );
    return true;
}

void MyListModel::addItem(QString const name, const int role, const int age)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_list.append(MyListItem{rowCount(), name, role, age});
    endInsertRows();
    sortItem();
}

void MyListModel::removeItem(const int &index)
{
    beginRemoveRows(QModelIndex(),index, index);
    m_list.remove(index);
    endRemoveRows();
}

QVariant MyListModel::getItem(const int index)
{
    if(index>=0 && index < m_list.size())
    {
        QVariantMap item;
        item.insert("idx", m_list.at(index).idx);
        item.insert("name", m_list.at(index).name);
        item.insert("role", m_list.at(index).role);
        item.insert("age", m_list.at(index).age);
        return item;
    }
    else
        return {};
}

void MyListModel::updateItem(const int index, QString const name, const int role, const int age)
{
    m_list.replace(index, MyListItem{index, name, role, age});
    //notify a signal when data changed
    emit dataChanged(this->index(index),this->index(index));
    //sort
    sortItem();
}

bool comparator(MyListItem &a, MyListItem &b)
{
    return a.role < b.role;
}

void MyListModel::sortItem()
{
    std::sort(m_list.begin(), m_list.end(), comparator);

    //find out where the data was changed
    for(int index=0; index< m_list.size(); index++)
    {
        if(m_list[index].idx != index)
        {
            m_list[index].idx = index;
            //notify a signal when data changed
            emit dataChanged(this->index(index),this->index(index));
        }
    }
}

void MyListModel::saveListToFile()
{
    QFile saveDoc(FILENAME);

    if( !saveDoc.open(QIODevice::WriteOnly | QIODevice::Truncate))
    {
        qWarning("Could not open file");
        return;
    }

    QJsonObject rootObject;
    QJsonArray listArray;

    for(int index =0; index< m_list.size(); index++){

        QJsonObject itemJson;
        itemJson["name"] = m_list.at(index).name;
        itemJson["role"] = m_list.at(index).role;
        itemJson["age"] = m_list.at(index).age;
        listArray.append(itemJson);
    }
    rootObject["listModel"] = listArray;

    auto writeContent = QJsonDocument(rootObject).toJson();
    saveDoc.write(writeContent);
    saveDoc.close();
}

void MyListModel::loadListFromFile()
{
    QFile loadDoc(FILENAME);

    if(!loadDoc.open(QIODevice::ReadOnly))
    {
        qDebug() << "Can't open old file!";
        return;
    }

    auto fileContent = loadDoc.readAll();
    QJsonDocument saveFileDoc = QJsonDocument::fromJson(fileContent);

    QJsonObject rootObject = saveFileDoc.object();

    if(rootObject.contains("listModel") && rootObject["listModel"].isArray())
    {

        auto listJsonArray = rootObject["listModel"].toArray();
        QVector<MyListItem> newList;
        for(int index =0; index < listJsonArray.size(); index++)
        {
            auto jsonItem = listJsonArray[index].toObject();
            MyListItem newItem;
            newItem.idx = index;
            newItem.name = jsonItem["name"].toString();
            newItem.role = jsonItem["role"].toInt();
            newItem.age = jsonItem["age"].toInt();
            newList.append(newItem);
        }
        beginResetModel();
        m_list = newList;
        endResetModel();
        loadDoc.close();
    }
    else
    {
        qWarning("Error! SaveFile is incorrect!");
        return;
    }
}

QHash<int, QByteArray> MyListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdxRole] = "idx";
    roles[NameRole] = "name";
    roles[PositionRole] = "role";
    roles[AgeRole] = "age";

    return roles;
}


