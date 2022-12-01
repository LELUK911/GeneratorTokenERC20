// SPDX-License-Identifier: Leluk
pragma solidity ^0.8.7;

import "./erc20FixSupply.sol";
import "./erc20VariableSupply.sol";
import "./erc20FixSupplyPausable.sol";
import "./erc20VariableSupplyPausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract creatorToken is Ownable, ReentrancyGuard, Pausable {
    uint256 private balance;
    uint256 private fees;

    constructor(uint256 _fees) {
        fees = _fees;
    }

    event CreateNewToken(address indexed sender, address token);
    event NewValueFee(uint256 _newFees);
    event WithdrawBalance(uint withdraw_);

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

    function setFees(uint256 _newFees) external onlyOwner {
        _setFees(_newFees);
        emit NewValueFee(_newFees);
    }

    function getBalance() public view returns (uint256 Balance) {
        Balance = balance;
    }

    function getFees() public view returns (uint256 Fees) {
        Fees = fees;
    }

    function withdraw() external onlyOwner{
        _withdraw();
    }

    function createFixSupply(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) public payable nonReentrant  whenNotPaused returns (address _tokenAddress) {
        require(msg.value==fees, "Payament fees is faill");
        balance += fees;
        _tokenAddress = _createFixSupply(_name, _ticker, _supply, _recipient);
        emit CreateNewToken(msg.sender, _tokenAddress);
        return _tokenAddress;
    }

    function createFixSupplyPausable(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) public payable nonReentrant  whenNotPaused returns (address _tokenAddress) {
        require(msg.value==fees, "Payament fees is faill");
        balance += fees;
        _tokenAddress = _createFixSupply(_name, _ticker, _supply, _recipient);
        emit CreateNewToken(msg.sender, _tokenAddress);
        return _tokenAddress;
    }

    function createVariableSupply(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) public payable nonReentrant  whenNotPaused returns (address _tokenAddress) {
        require(msg.value==fees, "Payament fees is faill");
        balance += fees;
        _tokenAddress = _createFixSupply(_name, _ticker, _supply, _recipient);
        emit CreateNewToken(msg.sender, _tokenAddress);
        return _tokenAddress;
    }

    function createVariableSupplyPausable(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) public payable nonReentrant  whenNotPaused returns (address _tokenAddress) {
        require(msg.value==fees, "Payament fees is faill");
        balance += fees;
        _tokenAddress = _createFixSupply(_name, _ticker, _supply, _recipient);
        emit CreateNewToken(msg.sender, _tokenAddress);
        return _tokenAddress;
    }

    function _fallback() private pure {
        return;
    }

    function _setFees(uint256 _newFees) private {
        fees = _newFees;
    }

    function _createFixSupply(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) private returns (address _tokenAddress) {
        Erc20FixSupply _erc20FixSupply = new Erc20FixSupply(
            _name,
            _ticker,
            _supply,
            _recipient
        );
        return _tokenAddress = address(_erc20FixSupply);
    }

    function _createFixSupplyPausable(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) private returns (address _tokenAddress) {
        Erc20FixSupplyPausable _erc20FixSupplyPausable = new Erc20FixSupplyPausable(
                _name,
                _ticker,
                _supply,
                _recipient
            );
        return _tokenAddress = address(_erc20FixSupplyPausable);
    }

    function _createVariableSupply(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) private returns (address _tokenAddress) {
        Erc20VariableSupply _erc20VariableSupply = new Erc20VariableSupply(
            _name,
            _ticker,
            _supply,
            _recipient
        );
        return _tokenAddress = address(_erc20VariableSupply);
    }

    function _createVariableSupplyPausable(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    ) private returns (address _tokenAddress) {
        Erc20VariableSupplyPausable _erc20VariableSupplyPausable = new Erc20VariableSupplyPausable(
                _name,
                _ticker,
                _supply,
                _recipient
            );
        return _tokenAddress = address(_erc20VariableSupplyPausable);
    }

    function _withdraw() private {
        uint256 withdraw_ = balance;
        balance = 0;
        (bool result, ) = owner().call{value: withdraw_}("");
        require(result, "Withdraw faill");
        emit WithdrawBalance(withdraw_);
    }
}
