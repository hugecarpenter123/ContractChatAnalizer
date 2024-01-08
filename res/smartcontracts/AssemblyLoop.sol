// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AssemblyLoop {
    function yul_for_loop() public pure returns (uint z) {
        assembly {
            for { let i := 0 } lt(i, 10) { i := add(i, 1) } {
                z := add(z, 1)
            }
        }
    }
    
    function yul_while_loop() public pure returns (uint z) {
        assembly {
            let i := 0
            for {} lt(i, 5) {} {
                i := add(i, 1)
                z := add(z, 1)
            }
        }
    }
}
contract TestAssemblyLoop is AssemblyLoop {
    function echidna_test_yul_for_loop() public pure returns (bool) {
        // Testujemy wynik pętli for
        return yul_for_loop() == 10;
    }

    function echidna_test_yul_while_loop() public pure returns (bool) {
        // Testujemy wynik pętli while
        return yul_while_loop() == 5;
    }
}