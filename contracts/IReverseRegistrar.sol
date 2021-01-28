pragma solidity >=0.4.24;

interface IReverseRegistrar {

    function claim(address owner) external returns (bytes32);
    function claimWithResolver(address owner, address resolver) external returns (bytes32);
    function setName(string calldata name) external returns (bytes32);
    function node(address addr) external pure returns (bytes32);

}
