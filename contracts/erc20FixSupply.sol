// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Erc20FixSupply is ERC20 {
    constructor(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) ERC20(_name, _ticker) {
        _mint(_recipient, _supply * 10**decimals());

    }
}
