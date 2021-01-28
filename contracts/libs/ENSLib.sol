pragma solidity ^0.4.18;

import '../ENS.sol';

/**
 * @title ENS utility library for Solidity contracts.
 * @author Augusto Lemble <me@augustolemble.com>
 *
 * @dev This library allows the access to ens information by their name.
 *      Once the namehash of the ens is available it only need the address of
 *      the ENS registry to get the ens information.
 */
library ENSLib {

  /**
   * @dev Returns the address that owns the specified node.
   * @param node The specified node.
   * @return address of the owner.
   */
  function owner(bytes32 node, address ensAddress) public view returns (address) {
    return ENS(ensAddress).owner(node);
  }

  /**
   * @dev Returns the address of the resolver for the specified node.
   * @param node The specified node.
   * @return address of the resolver.
   */
  function resolver(bytes32 node, address ensAddress) public view returns (address) {
    return ENS(ensAddress).resolver(node);
  }

  /**
   * @dev Returns the TTL of a node, and any records associated with it.
   * @param node The specified node.
   * @return ttl of the node.
   */
  function ttl(bytes32 node, address ensAddress) public view returns (uint64) {
    return ENS(ensAddress).ttl(node);
  }

}
