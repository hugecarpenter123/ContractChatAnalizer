// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionManager {
    address public owner;
    uint256 public totalTransactions;

    event TransactionExecuted(address indexed executor, uint256 transactionId, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function executeTransaction(uint256 _amount) public onlyOwner {
        require(_amount > 0, "Amount must be greater than 0");

        // Symulowana transakcja
        totalTransactions++;
        emit TransactionExecuted(msg.sender, totalTransactions, _amount);
    }
}

contract TestTransactionManager is TransactionManager {
    uint256 public simulatedStateChange;

    function echidna_test_executeTransaction() external {
        // Symulacja zmiany stanu
        simulatedStateChange = simulatedStateChange + 1;

        // Sprawdzamy, czy funkcja executeTransaction zwiększa liczbę transakcji poprawnie
        uint256 initialTransactions = totalTransactions;
        executeTransaction(200);

        assert(totalTransactions == initialTransactions + 1);

        // Symulacja dodatkowej zmiany stanu
        simulatedStateChange = simulatedStateChange + 1;
    }
}
