# MicroCoin daemon

[![GitHub license](https://img.shields.io/github/license/MicroCoinHU/microcoind.svg)](https://github.com/MicroCoinHU/microcoind/blob/master/LICENSE)

## How to build
### Lazarus
1. Clone git repository
2. Init submodules
3. Run lazbuild ./MicroCoinD.lpi
4. Run daemon

### Delphi
1. Clone git repository
2. Init submodules
3. Open MicroCoinD.dproj
4. Build & run

```Shell
git clone https://github.com/MicroCoinHU/microcoind.git
cd microcoind
git submodule init
git submodule update
lazbuild ./MicroCoinD.lpi
```

## Build for TESTNET
```Shell
lazbuild ./MicroCoinD.lpi --bm=TESTNET
```
