pragma solidity ^0.6.4;


contract SimpleStorage {
    function get() public view returns (string memory) {
        return "Hello World.";
    }
}
