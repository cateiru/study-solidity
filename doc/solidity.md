# Solidity

## 目次

[TOC]

## Hello Worldを書いてみる

```sol
pragma solidity ^0.6.4;

contract SimpleStorage {
    function get() public view returns (string memory) {
        return "Hello World.";
    }
}
```

### 個々の説明

- ```pragma solidity ^0.6.4```
  - Solidityのバージョンを指定。
- ```contract```
  - 他のオブジェクト指向言語での「クラス」に相当。1つのソースファイルに複数のContractを定義可能。
- ```function```
  - 関数。

## 詳しい説明

### 書き方

- 変数名、関数名は大文字小文字が区別される。
- 文の最後にはセミコロン`;`をつける。
- コメントは`//`, `/* ~~ */`を使用する。

### 変数の宣言

- int型の変数`x`を宣言する。
  - `int x;`(初期値は0)
  - `int x = 10;`(初期値を入れることができる)

### 変数

- 符号付き整数型
  - `int16` , `int8` というようにintの後に**8~256**までの変数のビット長の指定がある。
  - 数字が省略され`int`と指定された場合は`int256`と同等であり、デフォルト値は0。

- 符号なし整数型(自然数のみ)

  - `uint16`, `uint8` というようにuintの後に**8~256**までの変数のビット長の指定がある。
  - 数字が省略され`uint`と指定された場合は`uint256`と同等であり、デフォルト値は0。

- 真偽値

  - `bool`を使用。true, falseの2値が格納可能。デフォルトはfalse。

- アドレス型

  - `address`を使用。EOAやContractの20バイト長のアドレスを格納する。

  - デフォルトは`0x0000000000000000000000000000000000000000`

  - `address payable`にすることでetherを送信可能にできるか出来ないかの設定ができる。

    - `payable`あり→支払い(送信)可能
    - `payable`なし→支払い(送信)不可能

  - `balance`属性

    - アドレスが保有するether量が取得可能。

    ```sol
    address a = 0xa; // アドレス型変数aに0xaのアドレスを格納
    uint b = a.balance; // アドレス"0xa"の持つetherの量をbに格納
    ```

  - `transfer()`関数

    - `<address>.send(x)`を使用することで`<address>`に`x`weiのetherを送金することができる。

    ```sol
    contract Test {
    	function sendText() {
    		address a = 0x~~~~~~~;
    		a.transfer(5);  // コントラクト・アドレスが保有するetherから指定のアドレス"a"へ5weiを送金
    	}
    }
    ```

- 配列

  - 固定長
    
    - データ型`T`、長さ`k`の配列→`T[k]`で宣言する。
    - [example](../src/array.sol)
  
    ```text
    > arrayTest.getUintArray()
    [100, 99, 98, 97, 96]
    > arrayTest.getUinyValue(2)
    98
    > arrayTest.getString(1)
    "Orange"
    ```
    
  - 可変長
    
    - データ型`T`の配列→`T[]`で宣言する。
    
    - `length`属性、`push`関数
    
      - [example](../src/array_variable.sol)
    
      ```text
      > pushLengthTest.getArray()
      [10, 11, 12, 13, 14]
      > pushLengthTest.getLength()
      5
      ```
    
  
- 定数状態変数

  - `constant`を使用。

    ```sol
    uint constant x = 32**32 + 8;
    string constant text = "abc";
    bytes32 constant myHash = keccak256("abc");
    ```

    

### 演算子

- 比較演算子
  - `!`(論理否定), `&&`(論理積), `||`(論理和), `==`(等しい), `!=`(等しくない)
- ビット演算子
  - `&`, `|`, `^`(ビット単位の排他的論理和), `~`(ビット否定)
  - 例: `~int256(0) == int256(-1)`
- シフト演算子
  - `<<`(左シフト), `>>`(右シフト)
- 加算、減算、乗算
  - 2の補数表現でラップするためオーバーフローを考慮する必要がある。
- 除算
  - ゼロ除算はAssert.
  - 整数値の除算結果は整数値になる。
- 剰余
  - `%`を使用。
- べき乗
  - `**`を使用。
- その他
  - `+=`, `-=`, `*=`, `/=`, `%=`, `|=`, `&=`, `^=`, `a++`, `a--`
- 削除
  - `delete a`
    - aを初期値にする

### 関数

- `function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]`
  - pure関数→view関数とnon-payable関数に変換可能
  - view関数→non-payable関数に変換可能
  - payable関数→non-payable関数に変換可能

### データの場所

- `memory`, `storage`, `calldata`

### mapping

- ハッシュテーブル。

```sol
contract MappingExample {
    mapping(address => uint) public balances;

    function update(uint newBalance) public {
        balances[msg.sender] = newBalance;
    }
}

contract MappingUser {
    function f() public returns (uint) {
        MappingExample m = new MappingExample();
        m.update(100);
        return m.balances(address(this));
    }
}
```

## 単位

- エーテルユニット

  - `wei`, `finney`, `szabo` or `ether`

    ```sol
    assert(1 wei == 1);
    assrtt(1 szabo == 1e12);
    assrtt(1 finney == 1e15);
    assrtt(1 ether == 1e18);
    ```

- 時間単位

  - 注意: うるう秒があるため毎日24時間であるとは限りません。

  ```sol
  1 == 1 seconds
  1 minutes == 60 seconds
  1 hours = 60 minutes
  1 days == 24 hours
  1 weeks == 7 days
  ```

### エラー処理

- `assert(bool condition);`
  - 条件が満たされなかった場合、無効なオペコードが生成され元の状態に戻されます。
- `require(bool, condition);`
  - 条件が満たされなかった場合、元の状態に戻ります。入力または外部コンポーネントのエラーに使用されます。
- `require(bool, condition, string memory message);`
  - 条件が満たされなかった場合、元の状態に戻ります。上記のエラーメッセージが表示されるバージョン。
- `revert()`
  - 実行を中止して元の状態に戻ります。Pythonでいうraise。
- `revert(string memory reason);`
  - 上記のエラーメッセージが表示されるバージョン。

## ハッシュ関数

- `keccak256(bytes memory) returns (bytes32)`
  - 入力をKeccak-256でハッシュ化する。
- `sha256(bytes memory) returns (bytes32)`
  - 入力をSHA-256でハッシュ化する。
- `ripemd160(bytes memory) returns (byte20)`
  - 入力をRIPEMD-160でハッシュ化する。
- `ecrecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) returns (address)`
  - 楕円曲線DSAから公開鍵に関連付けられたアドレスを復元する。エラーの場合は0を返します。

## コントラクト関連

- `this`
  - 現在のコントラクトをアドレスに変換します。
- `selfdesutruct(address payable recipient)`
  - 現在のコントラクトを破棄し、その資金を指定されたアドレスに送信します。
- 可視性
  - `external`
    - 他のコントラクトからまたはトランザクションを介して呼び出すことができます。
    - 外部関数`f`を内部で呼び出すことは出来ません。(`f()`は機能しないが`this.f()`は機能する)
  - `public`
    - 内部またはメッセージを介して呼び出すことができます。
  - `internal`
    - 内部的にのみ(現在のコントラクト、またはそこから派生したコントラクト内から)アクセス可能。
  - `private`
    - 完全なプライベート。それが定義されているコントラクトでのみ表示される。

## 制御構造

- `if`, `else`, `while`, `do`, `for`, `break`, `continue`, `return`

- 条件分の場合単一ステートメントなら中括弧は省略可能。

- 関数呼び出し

  - 内部関数を再帰的に呼び出す

  ```sol
  pragma solidity >=0.4.16 <0.6.0;
  
  contract C {
      function g(uint a) public pure returns (uint ret) { return a + f(); }
      function f() internal pure returns (uint ret) { return g(7) + f(); }
  }
  ```

  - 外部関数を呼び出す

  ```sol
  pragma solidity >=0.4.0 <0.6.0;
  
  contract InfoFeed {
      function info() public payable returns (uint ret) { return 42; }
  }
  
  contract Consumer {
      InfoFeed feed;
      function setFeed(InfoFeed addr) public { feed = addr; }
      function callFeed() public { feed.info.value(10).gas(800)(); }
  }
  ```

## `new`によるコントラクトの作成

- newキーワードを使用して、他のコントラクトを作成することが出来ます。

```sol
pragma solidity ^0.5.0;

contract D {
    uint public x;
    constructor(uint a) public payable {
        x = a;
    }
}

contract C {
    D d = new D(4); // will be executed as part of C's constructor

    function createD(uint arg) public {
        D newD = new D(arg);
        newD.x();
    }

    function createAndEndowD(uint arg, uint amount) public payable {
        // Send ether along with the creation
        D newD = (new D).value(amount)(arg);
        newD.x();
    }
}
```



