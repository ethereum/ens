const ENS = artifacts.require("./ENSRegistry.sol");
const FIFSRegistrar = artifacts.require('./FIFSRegistrar.sol');

// Currently the parameter('./ContractName') is only used to imply
// the compiled contract JSON file name. So even though `Registrar.sol` is
// not existed, it's valid to put it here.
// TODO: align the contract name with the source code file name.
const web3 = new (require('web3'))();
const namehash = require('eth-ens-namehash').hash;

/**
 * Calculate root node hashes given the top level domain(tld)
 *
 * @param {string} tld plain text tld, for example: 'eth'
 */
function getRootNodeFromTLD(tld) {
  return {
    namehash: namehash.hash(tld),
    sha3: web3.sha3(tld)
  };
}

/**
 * Deploy the ENS and FIFSRegistrar
 *
 * @param {Object} deployer truffle deployer helper
 * @param {string} tld tld which the FIFS registrar takes charge of
 */
function deployFIFSRegistrar(deployer, tld) {
  var rootNode = getRootNodeFromTLD(tld);

  // Deploy the ENS first
  deployer.deploy(ENS)
    .then(() => {
      // Deploy the FIFSRegistrar and bind it with ENS
      return deployer.deploy(FIFSRegistrar, ENS.address, rootNode.namehash);
    })
    .then(function() {
      // Transfer the owner of the `rootNode` to the FIFSRegistrar
      return ENS.at(ENS.address).then((c) => c.setSubnodeOwner('0x0', rootNode.sha3, FIFSRegistrar.address));
    });
}

module.exports = function(deployer, network) {
  var tld = 'eth';

  if (network === 'dev.fifs') {
    deployFIFSRegistrar(deployer, tld);
  }

};
