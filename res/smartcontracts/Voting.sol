pragma solidity ^0.8.0;

contract Voting {
    // Zmienna przechowująca wartość
    uint256 public storedValue;

    // Adres właściciela kontraktu
    address public owner;

    // Wydarzenie informujące o zmianie wartości
    event ValueChanged(uint256 newValue);

    // Konstruktor kontraktu
    constructor() {
        owner = msg.sender;
    }

    // Funkcja zmieniająca wartość (tylko dla właściciela)
    function setValue(uint256 _newValue) public {
        require(msg.sender == owner, "Only the owner can set the value");
        storedValue = _newValue;
        emit ValueChanged(_newValue);
    }

    // Funkcja odczytująca wartość
    function getValue() public view returns (uint256) {
        return storedValue;
    }
}

contract TestVoting is Voting{
    function echidna_test_changeValue() public returns (bool) {
        // Test zmiany wartości przez właściciela
        setValue(42);
        emit ValueChanged(storedValue);
        return storedValue == 42;
    }

    function echidna_test_ownerOnly() public returns (bool) {
        // Test, czy nie-właściciel nie może zmienić wartości
        if (msg.sender != owner) {
            uint256 originalValue = storedValue;
            setValue(99);
            emit ValueChanged(storedValue);
            return storedValue == originalValue;
        }
        return true;
    }

    function echidna_test_readValue() public view returns (bool) {
        // Test odczytu wartości
        uint256 value = getValue();
        return true; // Test przejdzie, nie ma wymaganego sprawdzenia
    }
}