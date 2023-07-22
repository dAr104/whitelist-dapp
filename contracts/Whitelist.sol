// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/// @title Whitelist contract
/// @notice This contract is used to whitelist addresses for a NFT collection
/// @dev It is used to restrict the free minting of NFTs to only whitelisted addresses
contract Whitelist {

    // variable state
    uint8 public immutable MAX_WHITELISTED_ADDRESSES;
    mapping(address => bool) public whitelistedAddresses;
    uint8 public numAddressesWhitelisted;

    constructor(uint8 _maxWhitelistedAddresses) {
        MAX_WHITELISTED_ADDRESSES = _maxWhitelistedAddresses;
    }

    /// @notice Add an address to the whitelist
    /// @dev Everyone can call this function, but only if the whitelist is not full and the address is not already whitelisted will be added
    function addAssressToWhitelist() public {
        require(numAddressesWhitelisted < MAX_WHITELISTED_ADDRESSES, "Max whitelist addresses reached");
        require(!whitelistedAddresses[msg.sender], "Address already whitelisted");

        whitelistedAddresses[msg.sender] = true;
        numAddressesWhitelisted++;
    }
}