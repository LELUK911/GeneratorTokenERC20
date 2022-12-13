// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Erc20VariableSupply is ERC20, ERC20Burnable, Ownable {
    constructor(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) ERC20(_name, _ticker) {
        _mint(_recipient, _supply * 10**decimals());
         super.transferOwnership(_recipient);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
