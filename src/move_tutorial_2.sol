pragma solidity ^0.6.4;


contract ERC20Token {
    mapping(address => uint256) public balances;

    function mint() public {
        balances[msg.sender]++;
    }
}


contract MyContract {
    address payable wallet;
    address public token;

    event Purchase(address indexed _buyer, uint256 _amount);

    constructor(address payable _wallet, address _token) public {
        wallet = _wallet;
        token = _token;
    }

    function buyToken() public payable {
        ERC20Token _token = ERC20Token(address(token));
        _token.mint();
        wallet.transfer(msg.value);
    }
}

