// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract BuyMeACoffee {

    event NewMemo(
      address indexed from,
      uint256 timestamp,
      string name,
      string message
    );

    struct Memo{
      address from;
      uint256 timestamp;
      string name;
      string message;
    }

    address payable owner;

// List of objects of Memo type
    Memo[] memos;

    constructor() {
        owner = payable(msg.sender);
    }

    function getMemos() public view returns (Memo[] memory) {
      return memos;
    }

    /**
 * @dev buy a coffee for owner (sends an ETH tip and leaves a memo)
 * payable modifier means that this function accepts ETH
 * @param _name name of the coffee purchaser
 * @param _message a nice message from the purchaser
 */

  function buyCoffee(string memory _name, string memory _message) public payable{
    // Must accept more than 0 ETH for a coffee.
        require(msg.value > 0, "can't buy coffee for free!");

        memos.push(
          Memo(msg.sender, block.timestamp, _name, _message)
        );

      // Emit NewMemo event
      emit NewMemo(msg.sender, block.timestamp, _name, _message);
  }

/**
* @dev allows owner of smart contract to withdraw tips
to the address that paid for the deployment of the smart contract
* address(this).balance fetches the ETH stored in the smart contract's balance
*/
    function withdrawTips() public {
      console.log("Withdrawing tips!");
      require(owner.send(address(this).balance));
    }
}
