#include "listmodellib.h"


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
    MyListItem item = m_list.at(index.row());
    switch (role)
    {
    case TypeRole:
        return item.bType;
    case ColorRole:
        return item.bColor;
    case ValueRole:
        return item.bValue;
    }
    return {};
}

bool MyListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!hasIndex(index.row(), index.column(), index.parent()) || !value.isValid())
        return false;
    MyListItem item = m_list.at(index.row());
    switch (role)
    {
    case TypeRole:
        item.bType = value.toInt();
        break;
    case ColorRole:
        item.bColor = value.toString();
        break;
    case ValueRole:
        item.bValue = value.toInt();
        break;
    default:
        return false;
    }
    emit dataChanged(index, index, { role } );
    return true;
}

void MyListModel::addItem(const int bType, const QString bColor, const int bValue)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_list.append(MyListItem{bType, bColor, bValue});
    endInsertRows();
    emit countChanged();
}

void MyListModel::clearList()
{
    beginResetModel();
    m_list.clear();
    endResetModel();
    emit countChanged();
}

QHash<int, QByteArray> MyListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TypeRole] = "bType";
    roles[ColorRole] = "bColor";
    roles[ValueRole] = "bValue";

    return roles;
}



int MyListModel::count() const
{
    return m_list.size();
}

void MyListModel::setCount(int newCount)
{
//    if (m_count == newCount)
//        return;
//    m_count = newCount;
//    emit countChanged();
}
