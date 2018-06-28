# MicroCoin daemon

## How to build
1. Clone git repositore
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
