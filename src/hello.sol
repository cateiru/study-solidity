pragma solidity ^0.6.8;


contract SimpleStorage {
    function get() public pure returns (string memory) {
        return "Hello World.";
    }
}
