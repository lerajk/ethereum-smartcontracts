pragma solidity ^0.4.15;

contract Lottery {

	address[20] public players;
	uint totalpot; 

	function () payable {
    sendplaymoney(msg.sender)
  }

   function sendplaymoney(address participant) payable{
    uint256 amount = msg.sender;
    totalpot += amount; 
  }


} //contract ends