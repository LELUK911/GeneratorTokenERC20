// SPDX-License-Identifier: Leluk
pragma solidity ^0.8.7;

import "./coreFunction.sol";
import "./NFTMintableProgressiveStorageURIBurnablePausable.sol";
import "./NFTMintableProgressiveStorageURIBurnable.sol";

contract creatorTokenNFT is creatorTokenCoreFunction {
    uint256 private feesNFT;

    constructor(uint256 _feesNFT) {
        feesNFT = _feesNFT;
    }

    event CreateNewNFT(address indexed user, address nft);

    function setFees(uint256 _newFees) external onlyOwner {
        _setFees(_newFees);
        emit NewValueFee(_newFees);
    }

    function getFees() public view returns (uint256 Fees) {
        Fees = feesNFT;
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

    function _setFees(uint256 _newFees) private {
        feesNFT = _newFees;
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
}
