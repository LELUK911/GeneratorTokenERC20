// SPDX-License-Identifier: Leluk
pragma solidity ^0.8.7;

import "./erc20FixSupply.sol";
import "./erc20VariableSupply.sol";
import "./erc20FixSupplyPausable.sol";
import "./erc20VariableSupplyPausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./NFTSTandartURI.sol";
import "./NFTMintableProgressiveStorageURIpausable.sol";
import "./NFTMintableProgressiveStorageURIBurnablePausable.sol";
import "./NFTMintableProgressiveStorageURIBurnable.sol";
import "./NFTMintableProgressiveStorageURI.sol";

contract creatorToken is Ownable, ReentrancyGuard, Pausable {
    uint256 private balance;
    uint256 private fees;

    uint256 private feesNFT;

    constructor(uint256 _fees, uint256 _feesNFT) {
        fees = _fees;
        feesNFT = _feesNFT;
    }

    event CreateNewToken(address indexed sender, address token);
    event CreateNewNFT(address indexed user, address nft);

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

    function withdraw() external onlyOwner {
        _withdraw();
    }

    function createFixSupply(
        string memory _name,
        string memory _ticker,
        uint256 _supply,
        address _recipient
    )
        public
        payable
        nonReentrant
        whenNotPaused
        returns (address _tokenAddress)
    {
        require(msg.value == fees, "Payament fees is faill");
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
    )
        public
        payable
        nonReentrant
        whenNotPaused
        returns (address _tokenAddress)
    {
        require(msg.value == fees, "Payament fees is faill");
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
    )
        public
        payable
        nonReentrant
        whenNotPaused
        returns (address _tokenAddress)
    {
        require(msg.value == fees, "Payament fees is faill");
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
    )
        public
        payable
        nonReentrant
        whenNotPaused
        returns (address _tokenAddress)
    {
        require(msg.value == fees, "Payament fees is faill");
        balance += fees;
        _tokenAddress = _createFixSupply(_name, _ticker, _supply, _recipient);
        emit CreateNewToken(msg.sender, _tokenAddress);
        return _tokenAddress;
    }

    function createNFtStandardstring(
        address _owner,
        string memory _name,
        string memory _ticker,
        string memory _tokenURI
    ) public payable nonReentrant whenNotPaused returns (address _NftAddress) {
        require(msg.value == feesNFT, "Payament fees is faill");
        balance += feesNFT;
        _NftAddress = _createNFtStandard(_owner, _name, _ticker, _tokenURI);
        emit CreateNewNFT(msg.sender, _NftAddress);
        return _NftAddress;
    }

    function createNftProStoURIpausable(
        address _owner,
        string memory _name,
        string memory _ticker
    ) public payable nonReentrant whenNotPaused returns (address _NftAddress) {
        require(msg.value == feesNFT, "Payament fees is faill");
        balance += feesNFT;
        _NftAddress = _createNftProStoURIpausable(_owner, _name, _ticker);
        emit CreateNewNFT(msg.sender, _NftAddress);
        return _NftAddress;
    }

    function createNftProStoURIburnalblePausable(
        address _owner,
        string memory _name,
        string memory _ticker
    ) public payable nonReentrant whenNotPaused returns (address _NftAddress) {
        require(msg.value == feesNFT, "Payament fees is faill");
        balance += feesNFT;
        _NftAddress = _createNftProStoURIburnalblePausable(
            _owner,
            _name,
            _ticker
        );
        emit CreateNewNFT(msg.sender, _NftAddress);
        return _NftAddress;
    }

    function createNftProStoURIburnalble(
        address _owner,
        string memory _name,
        string memory _ticker
    ) public payable nonReentrant whenNotPaused returns (address _NftAddress) {
        require(msg.value == feesNFT, "Payament fees is faill");
        balance += feesNFT;
        _NftAddress = _createNftProStoURIburnalble(_owner, _name, _ticker);
        emit CreateNewNFT(msg.sender, _NftAddress);
        return _NftAddress;
    }

    function createNftMintableProURI(
        address _owner,
        string memory _name,
        string memory _ticker
    ) public payable nonReentrant whenNotPaused returns (address _NftAddress) {
        require(msg.value == feesNFT, "Payament fees is faill");
        balance += feesNFT;
        _NftAddress = _createNftMintableProURI(_owner, _name, _ticker);
        emit CreateNewNFT(msg.sender, _NftAddress);
        return _NftAddress;
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

    function _createNFtStandard(
        address _owner,
        string memory _name,
        string memory _ticker,
        string memory _tokenURI
    ) private returns (address _NftAddress) {
        erc721Standard _erc721Standard = new erc721Standard(
            _name,
            _ticker,
            _tokenURI,
            _owner
        );
        return _NftAddress = address(_erc721Standard);
    }

    function _createNftProStoURIpausable(
        address _owner,
        string memory _name,
        string memory _ticker
    ) private returns (address _NftAddress) {
        Erc721ProStoURIpausable _Erc721ProStoURIpausable = new Erc721ProStoURIpausable(
                _name,
                _ticker,
                _owner
            );
        return _NftAddress = address(_Erc721ProStoURIpausable);
    }

    function _createNftProStoURIburnalblePausable(
        address _owner,
        string memory _name,
        string memory _ticker
    ) private returns (address _NftAddress) {
        Erc721ProStoURIburnalblePausable _Erc721ProStoURIburnalblePausable = new Erc721ProStoURIburnalblePausable(
                _name,
                _ticker,
                _owner
            );
        return _NftAddress = address(_Erc721ProStoURIburnalblePausable);
    }

    function _createNftProStoURIburnalble(
        address _owner,
        string memory _name,
        string memory _ticker
    ) private returns (address _NftAddress) {
        Erc721ProStoURIburnalble _Erc721ProStoURIburnalble = new Erc721ProStoURIburnalble(
                _name,
                _ticker,
                _owner
            );
        return _NftAddress = address(_Erc721ProStoURIburnalble);
    }

    function _createNftMintableProURI(
        address _owner,
        string memory _name,
        string memory _ticker
    ) private returns (address _NftAddress) {
        erc721MintableProURI _erc721MintableProURI = new erc721MintableProURI(
            _name,
            _ticker,
            _owner
        );
        return _NftAddress = address(_erc721MintableProURI);
    }

    function _withdraw() private {
        uint256 withdraw_ = balance;
        balance = 0;
        (bool result, ) = owner().call{value: withdraw_}("");
        require(result, "Withdraw faill");
        emit WithdrawBalance(withdraw_);
    }
}
