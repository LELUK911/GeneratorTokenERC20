// SPDX-License-Identifier: Leluk
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract creatorTokenCoreFunction is Ownable, ReentrancyGuard, Pausable {
    uint256 public balance;

    event NewValueFee(uint256 _newFees);
    event WithdrawBalance(uint256 withdraw_);

    receive() external payable {
        _fallback();
    }

    fallback() external payable {
        _fallback();
    }

    function setPause() external onlyOwner {
        _pause();
    }

    function setUnpause() external onlyOwner {
        _unpause();
    }

    function _fallback() private pure {
        return;
    }

    function getBalance() public view returns (uint256 Balance) {
        Balance = balance;
    }

    function withdraw() external onlyOwner {
        _withdraw();
    }

    function _withdraw() private {
        uint256 withdraw_ = balance;
        balance = 0;
        (bool result, ) = owner().call{value: withdraw_}("");
        require(result, "Withdraw faill");
        emit WithdrawBalance(withdraw_);
    }
}
