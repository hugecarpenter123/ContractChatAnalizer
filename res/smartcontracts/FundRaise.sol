pragma solidity ^0.4.8;

contract FundRaise {
    address public owner;
    bool paused;

    // modifiers
    modifier onlyOwner() {
        assert(owner == msg.sender);
        _;
    }

    modifier whenNotPaused(){
        require(!paused);
        _;
    }

    // @dev constructor function. Sets contract owner
    function FundRaise() {
        owner = msg.sender;
    }

    // fallback function to accept ETH into contract.
    function () whenNotPaused payable {
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    function removeFunds() public {
        owner.transfer(this.balance);
    }
}

contract TestFundRaise is FundRaise {
    function echidna_test_pass() public View returns (bool) {
        return true;
    }   
}