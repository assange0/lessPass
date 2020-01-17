/**
* @brief 生成密码的头文件
* @author Roger Aries
* @date 2017/08/01
*/

#ifndef GENPASS_H
#define GENPASS_H

#include <QByteArray>
#include <QCryptographicHash>
#include <QMessageAuthenticationCode>
#include <QObject>
#include <QString>

class GenPass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString easyPass READ getEasy WRITE setEasy NOTIFY easyPassChanged)
    Q_PROPERTY(QString saltPass READ getSalt WRITE setSalt NOTIFY saltPassChanged)
    Q_PROPERTY(QString lessPass READ getLess NOTIFY lessPassChanged)

public:
    explicit GenPass(QObject *parent = nullptr);

    QString getEasy() const;
    QString getSalt() const;
    QString getLess() const;

    void setEasy(const QString &easyPass);
    void setSalt(const QString &saltPass);
    Q_INVOKABLE void genLess();

signals:
    void easyPassChanged();
    void saltPassChanged();
    void lessPassChanged();

private:
    QString m_easyPass;
    QString m_saltPass;
    QString m_lessPass;
};

#endif // GENPASS_H
