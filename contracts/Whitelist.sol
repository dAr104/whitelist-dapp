// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Whitelist {

    uint8 immutable MAX_WHITELISTED_ADDRESSES;
    mapping(address => bool) public whitelistedAddresses;
    uint8 public numAddressesWhitelisted;

    constructor(uint8 _maxWhitelistedAddresses) {
        MAX_WHITELISTED_ADDRESSES = _maxWhitelistedAddresses;
    }

    function addAssressToWhitelist() public {
        require(numAddressesWhitelisted < MAX_WHITELISTED_ADDRESSES, "Max whitelist addresses reached");
        require(!whitelistedAddresses[msg.sender], "Address already whitelisted");

        whitelistedAddresses[msg.sender] = true;
        numAddressesWhitelisted++;
    }
}