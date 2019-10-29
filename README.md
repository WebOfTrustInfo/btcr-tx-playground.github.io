# btcr-tx-playground.github.io

## Pre-requisites
In order to build btcr-did-tools-js for use in the browser we need to use browserify to convert the nodejs javascript.

```bash
sudo apt-get install xsltproc nodejs-dev node-gyp libssl1.0-dev
sudo apt-get install npm
sudo npm install -g browserify babelify jsonld jsonld-signatures commander \
bitcoinjs-lib babel-preset-es2015
```

## Installation
The playground is build ontop of the [coinbin](https://github.com/OutCast3k/coinbin/) wallet and utilises [btcr-did-tools-js](https://github.com/WebOfTrustInfo/btcr-did-tools-js), which in turn utilises [txref-conversion-js](https://github.com/WebOfTrustInfo/txref-conversion-js).

The dependencies have been added as submodules so when you first clone this reposiroty there will be file placeholders for the external repositories in the 'external' folder.  These will need to be imported using the `git submodule init` and `git submodule update` commands.

Some files need to be built so we use browserify to create build/btcrDidUtils.js and xsltproc to build the ./index.html file from external/coinbin/index.html.  The xsltproc step is configured in Make.

```bash
git clone https://github.com/WebOfTrustInfo/btcr-tx-playground.github.io.git
cd btcr-tx-playground.github.io
git submodule init
git submodule update
cd external/btcrDidUtils.js
browserify index.js --s BtcrUtils -t [ babelify --presets [ babel-presetes2015 ] ] -o ../../build/btcrDidUtils.js
make
```

## Making changes this code
The following dependencies are 
The core functionality is implemented by [btcr-did-tools-js](https://github.com/WebOfTrustInfo/btcr-did-tools-js) and [txref-conversion-js](https://github.com/WebOfTrustInfo/txref-conversion-js). 
Do not update the `btcrDidUtils.js` file directly. Instead, update those libraries and generate `btcrDidUtils.js` by following the instructions in [browserifying btcr-did-tools-js](https://github.com/WebOfTrustInfo/btcr-did-tools-js#browserify-this-library).

That tedious process can be improved! Please feel free to fix it for us!
