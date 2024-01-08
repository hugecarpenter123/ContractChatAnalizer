pragma solidity ^0.4.8;
/// @title BugSquash
contract BugSquash {
    enum State { Alive, Squashed }
    State state;
    address owner;
    function BugSquash () {
        state = State.Alive;
        owner = msg.sender;
    }
    function squash () {
        // this should never throw an error
        assert(owner != address(0));
        if (state == State.Alive)
        state = State.Squashed;
        else if (state == State.Squashed)
        revert(); // user error, refund gas
    }
    function kill () {
        // any nonowner trying to kill the contract
        // likely has malicious intent
        require(msg.sender == owner);
        selfdestruct(owner);
    }
}

contract TestBugSquash is BugSquash {
    function echidna_test_squash() public View returns (bool) {
        // Testujemy, czy funkcja squash zmienia stan na Squashed
        // i czy emituje odpowiedni event
        State initialState = state;
        squash();
        return initialState == State.Alive && state == State.Squashed;
    }


    function echidna_test_kill() public View returns (bool) {
        // Testujemy, czy funkcja kill działa poprawnie dla właściciela
        State initialState = state;
        kill();
        return initialState == State.Squashed && state == State.Squashed;
    }

}