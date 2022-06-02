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

  string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='brown' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

  constructor () ERC721("ImperialToken", "IMP") {}

  event NewTokenEvent(address indexed sender, uint256 tokenId);

  function makeAnNFT() public {

    uint256 newTokenId = _tokenIds.current();
    string memory combinedWord = string(abi.encodePacked("The ", Strings.toString(newTokenId)));
    string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord , "</text></svg>"));

    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    combinedWord,
                    '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(finalSvg)),
                    '"}'
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

}