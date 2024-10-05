// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./HeroNFT.sol";

contract HeroNFTFactory is Ownable {

    uint256 public price = 10000000000000000;

    mapping(string => address) private _allHeroesMap;
    HeroNFT[] public allHeroesArr;

    event FundsWithdrawn(address indexed owner, uint256 amount);

    constructor(address _initialOwner) Ownable(_initialOwner){}

    function withdraw() public onlyOwner {
        require(address(this).balance > 0, "No balance!!!");
        uint256 b = address(this).balance;
        (bool success,) = owner.call{value: address(this).balance}("");
        require(success, "Failed to withdraw!!!");
        emit FundsWithdrawn(owner, b);
    }

    receive() external payable {}
    /*
    * 新建Hero
    */
    function createNewHero(string name, string sym) public onlyOwner {
        HeroNFT hero = new HeroNFT(address(this));
        _allHeroesMap[name] = address(hero);
        allHeroesArr.push(hero);
    }
    /*
    * 抽卡
    */
    function summon() external payable {
        require(msg.value > price, "Error amount!!!");
        uint256 num = getRandomOnChain() % allHeroesArr.length;
        allHeroesArr[num].mint(_msgSender());
    }

    /*
    * random number for summon
    */
    function getRandomOnChain() public view returns (uint256){
        bytes32 randomBytes = keccak256(abi.encodePacked(block.number, msg.sender, blockhash(block.timestamp - 1)));
        return uint256(randomBytes);
    }
    /*
    * set price
    */
    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }
    /*
    * mint
    */
    function callHeroMint(address _contract, address _to) private {
        HeroNFT(_contract).mint(_to);
    }
    /*
    * burn
    */
    function callHeroBurn(address _contract, uint256 _targetId) private {
        HeroNFT(_contract).burn(_targetId);
    }
    /*
    * set base uri
    */
    function callHeroSetBaseURI(address _contract, string _base) external {

    }
}
