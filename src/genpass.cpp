#include "genpass.h"

GenPass::GenPass(QObject *parent)
    : QObject(parent)
{}

QString GenPass::getEasy() const
{
    return m_easyPass;
}

QString GenPass::getSalt() const
{
    return m_saltPass;
}

QString GenPass::getLess() const
{
    return m_lessPass;
}

void GenPass::setEasy(const QString &easyPass)
{
    if (easyPass == m_easyPass) {
        return;
    }

    m_easyPass = easyPass;
    emit easyPassChanged();
}

void GenPass::setSalt(const QString &saltPass)
{
    if (saltPass == m_saltPass) {
        return;
    }

    m_saltPass = saltPass;
    emit saltPassChanged();
}

void GenPass::genLess()
{
    QByteArray easyByte;
    QByteArray saltByte;
    QByteArray lessByte;

    // 1. 先对easyPass做md5
    easyByte.append(m_easyPass);
    QByteArray easyMd5 = QCryptographicHash::hash(easyByte, QCryptographicHash::Md5).toHex();

    // 2. 对第一步生成的md5值与saltPass做hmac256处理
    saltByte.append(m_saltPass);
    lessByte = QMessageAuthenticationCode::hash(easyMd5, saltByte, QCryptographicHash::Sha256)
                   .toHex();

    // 3. 再次md5后，取其base64编码的前16位
    const int lower = 0;
    const int higher = 16;
    lessByte = QCryptographicHash::hash(lessByte, QCryptographicHash::Md5)
                   .toBase64(QByteArray::Base64UrlEncoding);
    m_lessPass = QString(lessByte).mid(lower, higher).replace(QRegExp("\\-"), "_");

    emit lessPassChanged();
}
