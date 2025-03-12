// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

// IERC20 token
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns(bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);    
}

// contract
contract MyToken is IERC20{
    string public name="MyToken";
    string public symbol="_mkT";
    uint8 public  decimals = 18;
    uint256 public _totalSupply;

    mapping (address => uint256 ) public balances;
    mapping (address => mapping(address => uint256)) public override allowance;

    constructor(uint256 _initialSupply) {
        _totalSupply = _initialSupply;
        balances[msg.sender]=_initialSupply;
    }    
    

    function totalSupply() external override view returns(uint256){
        return _totalSupply;
    }

    function balanceOf(address _account) external override  view returns (uint256) {
        require(_account != address(0) ,"Invalid address");
        return balances[_account];
    }

    function transferFrom(address _sender, address _recipient, uint256 _amount ) external override  returns (bool){
        if(allowance[_sender][msg.sender] < _amount) revert("Your are not allowed to spend this amount");
        if(_sender!= address(0)) revert ("Invalid sender address");
        if(_recipient!= address(0)) revert ("Invalid recipient address");
        balances[_sender]-=_amount;
        allowance[_sender][msg.sender]-=_amount;
        balances[_recipient]+=_amount;
        emit Transfer(_sender, _recipient, _amount);
        return true;
    }

    function increaseAllowance(address _spender, uint256 _amount) external returns (bool){
        if(balances[msg.sender]<_amount) revert ("Insufficient Balance");
        if(_spender != address(0)) revert ("Invalid spender address");
        allowance[msg.sender][_spender]+=_amount;
        emit Approval (msg.sender, _spender , allowance[msg.sender][_spender]);
        return true;
    }

    function decreaseAllowance(address _spender, uint256 _amount) external  returns (bool){
        if(_spender != address(0))revert ("Invalid spender address");
        if(allowance[msg.sender][_spender] < _amount )revert("Insufficient allowance");
        allowance[msg.sender][_spender]-= _amount;
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }

    function transfer(address _to, uint256 _amount) external override returns (bool){
        require(balances[msg.sender] >= _amount, "Your balance is too low");
        balances[msg.sender] -=_amount;
        balances[_to] +=_amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }   

    function approve(address _spender, uint256 _amount) external override returns (bool){
        if(balances[msg.sender] < _amount) revert("Your balance is too low");
        if(_spender != address(0)) revert("Invalid spender address");
        allowance[msg.sender][_spender]= _amount;
        emit Approval (msg.sender, _spender , allowance[msg.sender][_spender]);
        return true;
    }
}