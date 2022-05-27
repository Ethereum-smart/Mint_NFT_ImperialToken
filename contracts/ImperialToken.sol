// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract ImperialToken is ERC721URIStorage {

  using Counters for Counters.Counter;

  Counters.Counter private _tokenIds;

  constructor () ERC721("ImperialToken", "IMP") {}

  function makeAnNFT() public {

    uint256 newTokenId = _tokenIds.current();
    _safeMint(msg.sender, newTokenId);
    _setTokenURI(newTokenId, "https://jsonkeeper.com/b/RIGZ");
    _tokenIds.increment();

  }

}