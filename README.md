# btcr-tx-playground.github.io

## Pre-requisites
In order to build btcr-did-tools-js for use in the browser we need to use browserify to convert the nodejs javascript.

```bash
sudo apt-get install nodejs-dev node-gyp libssl1.0-dev
sudo apt-get install npm
sudo npm install -g browserify babelify jsonld jsonld-signatures commander \
bitcoinjs-lib txref-conversion-js babel-preset-es2015
```

## Installation
The playground is build ontop of the [coinbin](https://github.com/OutCast3k/coinbin/) wallet and utilises [btcr-did-tools-js](https://github.com/WebOfTrustInfo/btcr-did-tools-js).  These dependencies need to be added so that the resources can be utilised by the playground.

```bash
git clone https://github.com/WebOfTrustInfo/btcr-tx-playground.github.io.git
cd btcr-tx-playground.github.io
mkdir -p {external,build}
git submodule add https://github.com/OutCast3k/coinbin.git external/coinbin
git submodule add https://github.com/WebOfTrustInfo/btcr-did-tools-js external/btcr-did-tools-js
cd external/btcrDidUtils.js
browserify index.js --s BtcrUtils -t [ babelify --presets [ babel-presetes2015 ] ] -o ../../build/btcrDidUtils.js
```

## Making changes this code
The following dependencies are 
The core functionality is implemented by [btcr-did-tools-js](https://github.com/WebOfTrustInfo/btcr-did-tools-js) and [txref-conversion-js](https://github.com/WebOfTrustInfo/txref-conversion-js). 
Do not update the `btcrDidUtils.js` file directly. Instead, update those libraries and generate `btcrDidUtils.js` by following the instructions in [browserifying btcr-did-tools-js](https://github.com/WebOfTrustInfo/btcr-did-tools-js#browserify-this-library).

That tedious process can be improved! Please feel free to fix it for us!
