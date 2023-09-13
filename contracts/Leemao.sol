// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LeemaoToken is ERC20, Ownable {
    address public feeReceiver;
    constructor() ERC20("LEEMAOTOKEN", "LTN") {
        _mint(msg.sender, 10000000 * 10e18);
        feeReceiver = 0x3C5E0d51B3E5a09981bD070Fc7d1D4ABfD0f076C;
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        uint fee = (amount * 8) / 100;
        uint totalAmount = amount + fee;
        require(balanceOf(_msgSender()) >= totalAmount, "Insufficient balance");

        _transfer(_msgSender(), recipient, amount);
        _transfer(_msgSender(), feeReceiver, fee);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        uint fee = (amount * 8) / 100;
        uint totalAmount = amount + fee;
        require(balanceOf(sender) >= totalAmount, "Insufficient balance");

        _transfer(sender, recipient, amount);
         
        _transfer(sender, feeReceiver, fee);
        _approve(sender, _msgSender(), allowance(sender, _msgSender()) - amount);
        
        return true;
    }
}