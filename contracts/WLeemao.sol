//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Leemao.sol";

contract LeemaoWrapper {

  LeemaoToken public immutable leemaoToken;

  constructor(address _leemaoToken) {
    leemaoToken = LeemaoToken(_leemaoToken);
  }

  mapping(address => uint) public balances;

  function wrap(uint _amount) external {
    leemaoToken.transferFrom(msg.sender, address(this), _amount);
    balances[msg.sender] += _amount;
  }

  function unwrap(uint _amount) external {
    require(balances[msg.sender] >= _amount, "Insufficient balance");
    balances[msg.sender] -= _amount;
    leemaoToken.transfer(msg.sender, _amount);
  }

  function transfer(address _to, uint _amount) external {
    require(balances[msg.sender] >= _amount, "Insufficient balance");
    balances[msg.sender] -= _amount;
    balances[_to] += _amount;
  }

  function balanceOf(address _owner) external view returns (uint) {
    return balances[_owner]; 
  }

}