//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LeemaoWrapper is ERC20 {
    IERC20 public Leemao;
    
    constructor(address _leemao) ERC20("WRAPPED_LEEMAO_TOKEN", "WLTN") {
        Leemao = IERC20(_leemao);
    }

function wrapLeemao(uint256 _amount) external {
    bool transferSuccess = Leemao.transferFrom(msg.sender, address(this), _amount);
    require(transferSuccess, "Transfer failed");

    uint256 amountToMint = (_amount * 92) / 100;

    _mint(msg.sender, amountToMint);
}

function unwrapLeemao(uint256 _amount) external {
    require(balanceOf(msg.sender) >= _amount, "Insufficient balance");

    _burn(msg.sender, _amount);

    require(Leemao.transfer(msg.sender, _amount), "Transfer failed");
}
    
}