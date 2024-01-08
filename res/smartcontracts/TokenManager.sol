// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenManager {
    address public owner;
    uint256 public totalTokens;

    event TokenMinted(address indexed minter, uint256 tokenId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function mintToken() public onlyOwner {
        // Simulate minting a new token
        totalTokens++;
        emit TokenMinted(msg.sender, totalTokens);
    }
}

contract TestTokenManager is TokenManager {
    function echidna_test_mintToken() public returns (bool) {
        // Test mintowania nowego tokena przez właściciela
        uint256 initialTokens = totalTokens;
        mintToken();
        return totalTokens == initialTokens + 1;
    }

    function echidna_test_mintTokenFail() public returns (bool) {
        // Test mintowania nowego tokena przez nie-właściciela
        try this.mintToken() {
            return false; // Funkcja powinna zakończyć się niepowodzeniem
        } catch {
            return true;
        }
    }
}
