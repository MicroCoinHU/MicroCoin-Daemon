# MicroCoin daemon

[![Build Status](https://travis-ci.org/MicroCoinHU/microcoind.svg?branch=master)](https://travis-ci.org/MicroCoinHU/microcoind) [![GitHub license](https://img.shields.io/github/license/MicroCoinHU/microcoind.svg)](https://github.com/MicroCoinHU/microcoind/blob/master/LICENSE)

## How to build
1. Clone git repository
2. Init submodules
3. Run lazbuild microcoind.lpi
4. Run daemon

```Shell
git clone https://github.com/MicroCoinHU/microcoind.git
cd microcoind
git submodule init
git submodule update
lazbuild ./microcoind.lpi
```

## Build for TESTNET
```Shell
lazbuild ./microcoind.lpi --bm=TESTNET
```
