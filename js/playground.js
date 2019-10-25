var toDisplayChain = function (chain) {
  return chain === "testnet" ? "testnet3" : chain;
};


var clearStatus = function() {
  //document.getElementById('txidLink').innerHTML = "";
  //document.getElementById('d-ddo').innerHTML = "<pre></pre>";
};

var updateTxDetails = function (result, isMainnet) {
	let txDetails = result.txDetails;
	let ddoResult = result.ddoResult;

	updateBlockHeightAndPos(txDetails.blockHeight, txDetails.blockIndex, txDetails.utxoIndex, isMainnet);
	updateTxLink(isMainnet, txDetails.txid);

	let ddo1 = ddoResult.implicitDdo ? ddoResult.implicitDdo : ddoResult.explicitDdo;

	if (ddo1) {
		document.getElementById('d-ddo1').innerHTML = "<pre>" + JSON.stringify(ddo1.didDocument, null, 4) + "</pre>";
		document.getElementById('vc').innerHTML = "<pre>" + JSON.stringify(ddo1.claims, null, 4) + "</pre>";
	} else {
		document.getElementById('raw').innerHTML = "<pre>" + ddoResult.raw + "</pre>";
		document.getElementById('errors').innerHTML = "<pre>" + JSON.stringify(ddoResult.error, null, 4) + "</pre>";

	}
};

var formatUrl = function (theUrl) {
  var txLink = "<a href=\"" + theUrl + "\" target='new'>" + theUrl + "</a>";
  return txLink;
};

var updateBlockHeightAndPos = function (blockHeight, blockIndex, utxoIndex, isMainnet) {
  // update mainnet/testnet
  if (isMainnet) {
	document.getElementById('mainnetChain').checked = true;
  } else {
	document.getElementById('testnet3Chain').checked = true;
  }

  var blockUrl = isMainnet ? "https://live.blockcypher.com/btc/block/" + blockHeight :
	"https://live.blockcypher.com/btc-testnet/block/" + blockHeight;

  document.getElementById('blockHeight').value = blockHeight;
  document.getElementById('blockPosition').value = blockIndex;
  document.getElementById('utxoIndex').value = utxoIndex;
};

var updateTxLink = function (isMainnet, txid) {
  var theUrl = isMainnet ? "https://api.blockcypher.com/v1/btc/main/txs/" + txid : "https://api.blockcypher.com/v1/btc/test3/txs/" + txid;
  var txLink = formatUrl(theUrl);
  //var txRef = document.getElementById('txidLink');
  //txRef.innerHTML = txLink;
};

var convertFromTxid = function () {
  var txidElement = document.getElementById('txid');
  var utxoIndexElement = document.getElementById('utxoIndex');
  var txrefElement = document.getElementById('txref');
  var isMainnet = document.getElementById('mainnetChain').checked;
  var txid = txidElement.value.trim();
  var utxoIndex = utxoIndexElement.value.trim();

  txrefElement.value = "computing...";
  var chain = isMainnet ? "mainnet" : "testnet";

  BtcrUtils.resolveFromTxid(txid, chain, utxoIndex)
	.then(function (result) {
	  txrefElement.value = result.txDetails.txref;
	  updateTxDetails(result, isMainnet);
	}, function (err) {
	  txidElement.value = "error looking up transaction. This may not a valid value";
	  clearStatus();
	});
};

var convertFromTxref = function () {
  var txrefElement = document.getElementById('txref');
  var txidElement = document.getElementById('txid');
  txidElement.value = "computing...";
  var txref = txrefElement.value.trim();
  var isMainnet = txref.charAt(4) == 'r'; // TODO!!

  BtcrUtils.resolveFromTxref(txref)
	.then(function (result) {
	  txidElement.value = result.txDetails.txid;
	  updateTxDetails(result, isMainnet);
	}, function (err) {
	  txidElement.value = "error decoding txref. This may not a valid value";
	  clearStatus();
	});
};
