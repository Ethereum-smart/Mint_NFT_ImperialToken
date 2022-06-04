// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import { Base64 } from "../libraries/Base64.sol";
import "hardhat/console.sol";

contract ImperialToken is ERC721URIStorage {

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  constructor () ERC721("ImperialToken", "IMP") {}

  event NewTokenEvent(address indexed sender, uint256 tokenId);

  modifier limitMint{
    require(_tokenIds.current() <= 50, "Limit reached");
    _;
  }

  function makeAnNFT() public limitMint {

    uint256 newTokenId = _tokenIds.current();

    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{',
                    '"name": "The NFT",',
                    '"description": "A highly acclaimed collection of squares.",',
                    '"image": "ipfs://Qmaz8oDvAKqJTxoNKYkd1xj4AJM45rNTRVD6LTpdka33gE/"'
                    '}'
                )
            )
        )
    );
    
    string memory finalTokenUri = string( abi.encodePacked("data:application/json;base64,", json) );

    _safeMint(msg.sender, newTokenId);
    _setTokenURI(newTokenId, finalTokenUri);
    _tokenIds.increment();
    emit NewTokenEvent(msg.sender, newTokenId);

  }

  function getTotalSupply() public view returns (uint256) {
    return _tokenIds.current();
  } 

}