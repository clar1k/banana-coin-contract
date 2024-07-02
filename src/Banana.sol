// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Banana {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public _allowances;
    uint256 public _totalSupply;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    function name() public pure returns (string memory) {
        return "Banana";
    }

    function symbol() public pure returns (string memory) {
        return "BANANA";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        if (balances[msg.sender] < _value) {
            return false;
        }

        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        if (_allowances[_from][msg.sender] < _value) {
            return false;
        }
        _allowances[_from][msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        if (balances[msg.sender] < _value) {
            return false;
        }

        _allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint256 remaining) {
        return _allowances[_owner][_spender];
    }

    function burn(uint256 _value) public returns (bool success) {
        // 5 > 10 ???? false
        if (_value > balances[msg.sender]) {
            return false;
        }

        _totalSupply -= _value;
        balances[msg.sender] -= _value;
        return true;
    }

    function mint(address _to, uint256 _value) public returns (bool success) {
        balances[_to] += _value;
        _totalSupply += _value;
        return true;
    }
}
