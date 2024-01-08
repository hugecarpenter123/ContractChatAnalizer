// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Event {
    // Event declaration
    // Up to 3 parameters can be indexed.
    // Indexed parameters helps you filter the logs by the indexed parameter
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}

contract TestEvent is Event {
    function echidna_test_log() public view returns (bool) {
        uint256 logs = EchidnaTestFramework.echidna_logs();
        if (logs >= 3) {
            bytes32 logType = EchidnaTestFramework.echidna_log(logs - 1, 0);
            bytes32 sender = EchidnaTestFramework.echidna_log(logs - 1, 1);
            bytes32 message = EchidnaTestFramework.echidna_log(logs - 1, 2);

            // Sprawdzamy, czy ostatni log jest typu AnotherLog
            if (logType == keccak256("AnotherLog")) {
                // Sprawdzamy, czy poprzednie dwa logi zawierają oczekiwane adresy wysyłające i komunikaty
                bytes32 sender1 = EchidnaTestFramework.echidna_log(logs - 2, 1);
                bytes32 message1 = EchidnaTestFramework.echidna_log(logs - 2, 2);
                bytes32 sender2 = EchidnaTestFramework.echidna_log(logs - 3, 1);
                bytes32 message2 = EchidnaTestFramework.echidna_log(logs - 3, 2);

                return (
                    sender1 == bytes32(uint256(uint160(address(this)))) &&
                    message1 == keccak256("Hello EVM!") &&
                    sender2 == bytes32(uint256(uint160(address(this)))) &&
                    message2 == keccak256("Hello World!")
                );
            }
        }
        return false;
    }
}
