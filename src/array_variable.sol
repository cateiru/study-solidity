pragma solidity ^0.6.4;


contract pushLengthTest {
    uint8 arraylength = 5;
    uint256[] uintArray;

    constructor() public {
        uint8 i = 0;
        uint8 basenum = 10;
        while (i < arraylength) {
            // pushはPytonでいう`append`
            uintArray.push(basenum + i);
            i++;
        }
    }

    // uint型可変配列を取り出す
    function getArray() public view returns (uint256[] memory) {
        return uintArray;
    }

    // uint型可変配列の長さを取り出す
    function getLength() public view returns (uint256) {
        // Pythonでいう`len`
        return uintArray.length;
    }
}
