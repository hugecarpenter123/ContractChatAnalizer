// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenVault {
    address public owner;
    uint256 public tokenBalance;

    event TokensDeposited(address indexed depositor, uint256 amount);
    event TokensWithdrawn(address indexed withdrawer, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function depositTokens(uint256 _amount) public onlyOwner {
        require(_amount > 0, "Amount must be greater than 0");
        tokenBalance += _amount;
        emit TokensDeposited(msg.sender, _amount);
    }

    function withdrawTokens(uint256 _amount) public onlyOwner {
        require(_amount > 0, "Amount must be greater than 0");
        require(_amount <= tokenBalance, "Insufficient balance");
        tokenBalance -= _amount;
        emit TokensWithdrawn(msg.sender, _amount);
    }
}

contract TestTokenVault is TokenVault {
    function echidna_test_depositTokens() external {
        // Sprawdzamy, czy funkcja depositTokens zwiększa balans poprawnie
        uint256 initialBalance = tokenBalance;
        depositTokens(100);
        assert(tokenBalance == initialBalance + 100);
    }

    function echidna_test_withdrawTokens() external {
        // Sprawdzamy, czy funkcja withdrawTokens zmniejsza balans poprawnie
        uint256 initialBalance = tokenBalance;
        withdrawTokens(50);
        assert(tokenBalance == initialBalance - 50);
    }
}
