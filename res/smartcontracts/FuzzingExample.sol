// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FuzzingExample {
    address public owner;
    uint256 public value;

    event ValueChanged(address indexed changer, uint256 newValue);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setValue(uint256 _newValue) public onlyOwner {
        value = _newValue;
        emit ValueChanged(msg.sender, _newValue);
    }

    function fuzzingFunction() public {
        // This function is intentionally vulnerable to fuzzing
        value = value + 1;
    }
}

contract TestFuzzingExample is FuzzingExample {
    function echidna_test_setValue() public onlyOwner returns (bool) {
        // Test setting a new value by the owner
        uint256 newValue = 42;
        setValue(newValue);
        return value == newValue;
    }

    function echidna_test_setValueFail() public returns (bool) {
        // Test setting a new value by non-owner
        try this.setValue(99) {
            return false; // The function should fail
        } catch {
            return true;
        }
    }

    function echidna_test_fuzzingFunction() public returns (bool) {
        // Test the fuzzing function
        uint256 initialValue = value;
        fuzzingFunction();
        return value == initialValue + 1;
    }
}
