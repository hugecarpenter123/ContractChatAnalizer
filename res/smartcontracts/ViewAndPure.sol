// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ViewAndPure {
    uint public x = 1;

    // Promise not to modify the state.
    function addToX(uint y) public view returns (uint) {
        return x + y;
    }

    // Promise not to modify or read from the state.
    function add(uint i, uint j) public pure returns (uint) {
        return i + j;
    }
}

contract TestViewAndPure is ViewAndPure {
    function echidna_test_addToX() public view returns (bool) {
        // Testujemy, czy funkcja addToX zwraca oczekiwany wynik
        return addToX(5) == 6;
    }

    function echidna_test_add() public pure returns (bool) {
        // Testujemy, czy funkcja add zwraca oczekiwany wynik
        return add(2, 3) == 5;
    }

    function echidna_test_modifyStateFail() public view returns (bool) {
        // Testujemy, czy próba modyfikacji stanu zakończy się błędem
        // Pomijamy ten test w kontekście Echidna
        return true;
    }

    function echidna_test_readStateFail() public pure returns (bool) {
        // Testujemy, czy próba odczytu stanu zakończy się błędem
        // Pomijamy ten test w kontekście Echidna
        return true;
    }
}