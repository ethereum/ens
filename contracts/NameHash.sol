pragma solidity ^0.4.11;

import "github.com/Arachnid/solidity-stringutils/strings.sol";


/**
 * Namehash algorighm implementation in Solidity.
 */
library NameHash
 {
    using strings for *;
    
    
    /**
     * Native namehash algorighm implementation in Solidity.
     * @param  _node The string over which the namehash algorithm will be applied.
     * @return _namehash The result of namehash algorighm applied at _node.
     */
    function namehash(string _node) constant returns (bytes32 _namehash)
    {
        var node = _node.toSlice();
        bytes32 namehash = 0x0000000000000000000000000000000000000000000000000000000000000000;
        if(!node.empty())
        {
            var delim = ".".toSlice();
            var parts = new string[](node.count(delim) + 1);
            for(uint i = 0; i < parts.length; i++)
            {
                parts[i] = node.split(delim).toString();
            }
            
            for(i = 0; i < parts.length; i++)
            {
                namehash = sha3(namehash, sha3(parts[parts.length - i - 1]));
            }
        }
        return namehash;
    }
 }
