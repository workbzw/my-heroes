// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract HeroNFT is ERC721, Ownable {
    uint256 private _tokenIdCounter = 0;
    string private _baseURI = "";

    constructor(address initialOwner, string memory name, string memory sym, string memory _base) ERC721(name, sym) Ownable(initialOwner){
        _baseURI = _base;
    }

    function mint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter;
        _safeMint(to, tokenId);
        _tokenIdCounter += 1;
    }

    function burn(uint256 _tokenId) public onlyOwner {
        _burn(_tokenId);
    }

    function setBaseURI(string _base) external onlyOwner {
        _baseURI = _base;
    }

    function _baseURI() internal view virtual returns (string memory) {
        return _baseURI;
    }
}
