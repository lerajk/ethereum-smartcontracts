pragma solidity ^0.4.15;

contract Lottery {

	//address[20] public players;
	address public participant; 
	uint totalpot; 
	uint bet;
	
	//mapping (address => uint256) balances;

	
	event sendplay(address indexed _from, uint _value);

	function sendplaymoney (uint _bet) public returns (address){

		participant = msg.sender;
		totalpot += _bet;
		sendplay(msg.sender, _bet);
	    return participant;

	}
	
	function potbalance() public returns (uint){
	    
	    return totalpot; 
	}
	
	/*function guessNumber(uint _number) public returns (uint){
	    
	    participant = msg.sender;
	    if(_number == 5)
	    balances(participant, totalpot);
	    //msg.value = totalpot;
	    return totalpot;
	} */
	
		function transfer(uint _number) public returns (bool){
	    participant = msg.sender;
	    if(_number == 5)
	    participant.send(totalpot);
	    return true;
	 
	    //participant = msg.sender;
	    
	    
	}
	
	

} //contract ends


	/*
	function () payable {
    sendplaymoney(msg.sender)
  }

   function sendplaymoney(address participant) payable{
    uint256 amount = msg.sender;
    totalpot += amount; 
  }
	*/