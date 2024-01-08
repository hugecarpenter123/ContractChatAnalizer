// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomContract {
    enum State { Active, Inactive }
    State public state;
    address public owner;

    event Deactivated();

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        state = State.Active;
        owner = msg.sender;
    }

    function deactivate() public onlyOwner {
        require(owner != address(0), "Owner address cannot be 0");
        require(state == State.Active, "Contract is already inactive");
        
        state = State.Inactive;
        emit Deactivated();
    }

    function kill() public onlyOwner {
        selfdestruct(payable(owner));
    }
}

contract TestCustomContract is CustomContract {
    function echidna_test_ownerOnly() external view returns (bool) {
        // Sprawdzamy, czy tylko właściciel może wywołać funkcję onlyOwner
        try this.deactivate() {
            revert("Echidna test failed: ownerOnly");
        } catch Error(string memory) {
            return true;
        } catch {
            return false;
        }
    }

    function echidna_test_deactivate() external {
        // Sprawdzamy, czy funkcja deactivate zmienia stan kontraktu poprawnie
        uint256 initialState = uint256(state);
        deactivate();
        assert(uint256(state) != initialState);
    }
}
