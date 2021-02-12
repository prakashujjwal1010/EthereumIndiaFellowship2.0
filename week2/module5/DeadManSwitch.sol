// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

contract DeadManSwitchContract {
    address public owner;
    address payable recipient;
    uint256 public lastCheckInBlock = 0;
    uint256 public checkInPeriodBlocks = 10;

    event FundsReleased(address payable sender, uint256 amount);

    constructor(address payable _recipient) {
        recipient = _recipient;
        owner = msg.sender;
    }

    function stillAlive() external {
        require(msg.sender == owner);
        lastCheckInBlock = block.number;
    }

    function checkIfStillAlive() public returns (bool) {
        if(checkInPeriodBlocks < block.number - lastCheckInBlock){
            emit FundsReleased(recipient, address(this).balance);
            selfdestruct(recipient);
            return true;
        } else {
            return false;
        }
    }

    function setCheckInPeriod(uint _periodBlocks) public {
        require(msg.sender == owner);
        checkInPeriodBlocks = _periodBlocks;
	  }

    function getOwner() public view returns (address) {
        return owner;
    }

  	function getRecipient() public view returns (address) {
  	    return recipient;
  	}

  	function setRecipient(address payable _recipient) public {
        require(msg.sender == owner);
        recipient = _recipient;
  	}

}
