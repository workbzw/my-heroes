// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./HeroNFT.sol";

contract HeroNFTFactory {
    address public immutable owner;
    uint256 public price = 10000000000000000;

    event FundsWithdrawn(address indexed owner, uint256 amount);
    constructor(address _owner){
        owner = _owner;
    }

    modifier isOwner() {
        // msg.sender: predefined variable that represents address of the account that called the current function
        require(msg.sender == owner, "Not the Owner");
        _;
    }

    function withdraw() public isOwner {
        uint256 b = address(this).balance;
        require(address(this).balance > 0, "No balance!!!");
        (bool success,) = owner.call{value: address(this).balance}("");
        require(success, "Failed to withdraw!!!");
        emit FundsWithdrawn(owner, b);
    }

    receive() external payable {}

    function addNewHero() public isOwner {

    }

    function summon() external payable {
        require(msg.value > price, "Error amount!!!");

    }

    function setPrice(uint256 _price) public isOwner {
        price = _price;
    }


}
