// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract HeroNFT is ERC721 {
    uint256 private _tokenIdCounter;

    constructor(string memory name, string memory sym) ERC721(name, sym){

    }

    function mint(address to) public isOwner{
        uint256 tokenId = _tokenIdCounter;
        _safeMint(to, tokenId);
        _tokenIdCounter += 1;
    }

    function burn() public isOwner {
        
    }



}
