#include "ListModelLib.h"


QString MyListModel::inputFile() const
{
    return pInputFile;
}

void MyListModel::setInputFile(QString const &inputFile)
{
    if(pInputFile == inputFile)
        return;
    pInputFile = inputFile;
    loadListModelFromFile();
    emit inputFileChanged();
}

int MyListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_list.size();
}

QVariant MyListModel::data(const QModelIndex &index, int role) const
{

    if (!hasIndex(index.row(), index.column(), index.parent()))
        return {};
    const MyListItem &item = m_list.at(index.row());
    if (role == NameRole) return item.name;
    if (role == PositionRole) return item.role;
    if (role == AgeRole) return item.age;

    return {};
}

bool MyListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{

    if (!hasIndex(index.row(), index.column(), index.parent()) || !value.isValid())
        return false;
    MyListItem &item = m_list[index.row()];
    if (role == NameRole)
        item.name = value.toString();
    else if (role == PositionRole)
        item.role = value.toInt();
    else if (role == AgeRole)
        item.age = value.toInt();
    else
        return false;
    emit dataChanged(index, index, { role } );
    return true;
}

Q_INVOKABLE void MyListModel::addItem(QString const name, const int role, const int age)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_list.append(MyListItem{name, role, age});
    endInsertRows();
    sortItem();
}

Q_INVOKABLE void MyListModel::removeItem(const int &index)
{
    beginRemoveRows(QModelIndex(),index, index);
    m_list.remove(index);
    endRemoveRows();
}

Q_INVOKABLE QVariant MyListModel::getItem(const int index)
{
    if(index>=0 && index < m_list.size())
    {
        QVariantMap item;
        item.insert("name", m_list.at(index).name);
        item.insert("role", m_list.at(index).role);
        item.insert("age", m_list.at(index).age);
        return item;
    }
    else
        return {};
}

Q_INVOKABLE void MyListModel::updateItem(const int index, QString const name, const int role, const int age)
{
    m_list.replace(index, MyListItem{name, role, age});
    //notify a signal when data changed
//    emit dataChanged(this->index(index),this->index(index));
    sortItem();
}

bool operator<(const MyListItem& a, const MyListItem& b) { return a.role < b.role; }

void MyListModel::sortItem()
{
    std::sort(m_list.begin(), m_list.end());
    //notify a signal when data changed
    for(int index=0; index< m_list.size(); index++)
    emit dataChanged(this->index(index),this->index(index));
}

Q_INVOKABLE void MyListModel::saveListModelToFile()
{
    QFile saveDoc(pInputFile);

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

void MyListModel::loadListModelFromFile()
{
    QFile loadDoc(pInputFile);

    if(!loadDoc.open(QIODevice::ReadOnly))
        return;

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
    roles[NameRole] = "name";
    roles[PositionRole] = "role";
    roles[AgeRole] = "age";

    return roles;
}


