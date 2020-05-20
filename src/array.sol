pragma solidity ^0.6.4;


contract arrayText {
    uint8[5] uintArray; // 固定長配列
    string[3] stArray; // 固定長配列

    // コンストラクタ (Pythonでいうinit)
    constructor() internal {
        uint8 x = 0;
        while (x < 5) {
            uintArray[x] = 100 - x;
            x++;
        }
        stArray[0] = "Apple";
        stArray[1] = "Orange";
        stArray[2] = "Pineapple";
    }

    // uint型配列全体を取り出す
    function getUintArray() public view returns (uint8[5] memory) {
        return uintArray;
    }

    // uint型配列の特定の要素(x番目の要素)を取り出す
    function getUintValue(uint8 x) public view returns (uint8) {
        return uintArray[x];
    }

    // string型配列の特定の要素(x番目の要素)を取り出す
    function getStValue(uint8 x) public view returns (string memory) {
        return stArray[x];
    }

    // string型配列全体を取り出す(Not Supported)
    function getStArray() public view returns (string[3] memory) {
        return stArray;
    }
}
