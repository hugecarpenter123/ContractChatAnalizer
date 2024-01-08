// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FunctionSelector {
    /*
    "transfer(address,uint256)"
    0xa9059cbb
    "transferFrom(address,address,uint256)"
    0x23b872dd
    */
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}
contract TestFunctionSelector is FunctionSelector {
    function echidna_test_getSelectorTransfer() public pure returns (bool) {
        // Testujemy, czy getSelector zwraca poprawny selektor dla "transfer(address,uint256)"
        return getSelector("transfer(address,uint256)") == 0xa9059cbb;
    }

    function echidna_test_getSelectorTransferFrom() public pure returns (bool) {
        // Testujemy, czy getSelector zwraca poprawny selektor dla "transferFrom(address,address,uint256)"
        return getSelector("transferFrom(address,address,uint256)") == 0x23b872dd;
    }
}