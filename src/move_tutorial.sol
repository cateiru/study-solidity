pragma solidity ^0.6.4;


contract MyContract {
    // アドレス⇔uint256をリンクさせるマッピング関数を作成
    mapping(address => uint256) public balances;
    // 支払い可能なアドレス変数を作成
    address payable wallet;

    // 実行結果をweb上に伝える
    event Purchase(address indexed _buyer, uint256 _amount);

    // Pythonで言うところのinit
    // 起動時？の入力したアドレスをwalletに格納する
    constructor(address payable _wallet) public {
        wallet = _wallet;
    }

    function() external payable {
        buyToken();
    }

    function buyToken() public payable {
        // balancesボタンを押したときにそのアドレスの中の値(uint256)をインクリメントする
        balances[msg.sender] += 1;
        // walletに入力されたアドレスにmsg.value分を送信する
        wallet.transfer(msg.value);
        // イベント関数を読み込み。emitをつけなくてもいいがつけることが推奨されている
        emit Purchase(msg.sender, 1);
    }
}
