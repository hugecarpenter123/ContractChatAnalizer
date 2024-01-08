// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ThemedToken {
    uint256 public value;
    address public owner;

    event ValueChanged(uint256 newValue);

    constructor() {
        owner = msg.sender;
        value = 42;
    }

    function setValue(uint256 _newValue) public {
        require(msg.sender == owner, "Only the owner can set the value");
        value = _newValue;
        emit ValueChanged(_newValue);
    }

    function getValue() public view returns (uint256) {
        return value;
    }

    function doubleValue() public {
        // Podwajamy bieżącą wartość kontraktu
        value *= 2;
    }
}

contract TestThemedToken is ThemedToken {
    function echidna_test_invariant() public view returns (bool) {
        // Testujemy, czy wartość kontraktu zawsze wynosi 42
        return value == 42;
    }

    function echidna_test_doubleValue() public returns (bool) {
        // Sprawdzamy, czy funkcja doubleValue podwaja wartość kontraktu
        uint256 initialValue = value;
        doubleValue();
        return value == initialValue * 2;
    }
}
