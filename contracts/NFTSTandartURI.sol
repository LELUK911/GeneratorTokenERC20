// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract erc721Standard is ERC721, Ownable {
    
    string private baseUri;
    constructor(string memory _name, string memory _ticker, string memory _tokenURI,address _user) ERC721(_name,_ticker) {
        baseUri = _tokenURI;
        transferOwnership(_user);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseUri;
    }
}
