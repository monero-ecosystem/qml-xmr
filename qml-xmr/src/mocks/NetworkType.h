#pragma once

#include <QObject>

class NetworkType : public QObject
{
Q_OBJECT

public:
    enum Type : uint8_t {
        MAINNET = 0,
        TESTNET = 1,
        STAGENET = 2
    };
    Q_ENUM(Type)
};
