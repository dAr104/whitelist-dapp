// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./Whitelist.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract CryptoDevs is ERC721Enumerable, Ownable {
    
    uint256 constant public PRICE = 0.01 ether;
    uint256 constant public MAX_TOKEN_IDS = 20;

    Whitelist whitelistContract;

    uint256 public immutable RESERVED_TOKENS;
    uint256 public reservedTokensClaimed;

    /**
      * @dev ERC721 constructor takes in a `name` and a `symbol` to the token collection.
      * name in our case is `Crypto Devs` and symbol is `CD`.
      * Constructor for Crypto Devs takes in the baseURI to set _baseTokenURI for the collection.
      * It also initializes an instance of whitelist interface.
      */
      constructor(address whitelistContractAddress) ERC721("Crypto Devs", "CD") {
        whitelistContract = Whitelist(whitelistContractAddress);
        RESERVED_TOKENS = whitelistContract.MAX_WHITELISTED_ADDRESSES();
      }


      function mint() public payable {
        // Make sure we always leave enough room for whitelist reservations
        require(totalSupply() + RESERVED_TOKENS - reservedTokensClaimed < MAX_TOKEN_IDS, "Exceeds maximum token supply");

        // If user is part of the whitelist, make sure there is still reserved tokens left
        if (whitelistContract.whitelistedAddresses(msg.sender) && msg.value < PRICE) {

            require(balanceOf(msg.sender) == 0, "Only one free token per address");
            reservedTokensClaimed++;

        } else {
            // If user is not part of the whitelist, make sure they have sent enough ETH
            require(msg.value >= PRICE, "Not enough Ether sent");
        }

        uint256 tokenId = totalSupply();
        _safeMint(msg.sender, tokenId);
      }

      /**
        * @dev withdraw sends all the ether in the contract
        * to the owner of the contract
        */
        function withdraw() public onlyOwner {

            address _owner = owner();
            uint256 amount = address(this).balance;

            (bool sent, ) = _owner.call{value: amount}("");
            require(sent, "Failed to send Ether");
        }

}