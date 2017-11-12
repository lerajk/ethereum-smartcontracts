/**
 * https://www.toshblocks.com/solidity/complete-example-crowd-funding-smart-contract/
 */
contract  CrowdFunder {

	address creator;
	address fundRecipient;
	uint minimunToRaise;
	uint totalRaised;
	unit currentBalance;
	uint raiseBy;
	uint completeAt;
	string url;



	enum State { Fundraising, ExpiredRefund, Succesful, Closed}
	State state = State.Fundraising;

	modifier inState(State _state) { 
		if (state != _state) throw; 
		_; 
	}

	modifier isCreator() { 
		if (msg.sender != creator) throw; 
		_; 
	}

	modifier atEndOfLifeCycle() { 
		if (!((state == State.ExpiredRefund || (state == State.Succesful) && (completeAt + 1))) throw; 
		_; 
	}
	

	struc Contribution {

		uint amount;
		address contributor;
	}

	Contribution[] contributions;
	

	function  CrowdFunder (uint timeInHoursForFundraising, string _campaignUrl, address _fundRecipient, uint _minimumToRaise) {

		creator = msg.sender;
		fundRecipient = _fundRecipient;
		campaignUrl = _campaignUrl;
		minimunToRaise = _minimumToRaise * 10 * 100000000000000000; 
		raiseBy = now + (timeInHoursForFundraising * 1 hours);
		currentBalance = 0;
		
	}	

	function contribute() public inState(State.Fundraising) payable returns (uint256){

		contributions.push(Contribution({

				amount: msg.value;
				contributor: msg.sender;
			}));
		totalRaised += msg.value;
		currentBalance = totalRaised;

		checkIfFundingCompleteOrExpired();
		return contributions.length -1; 
	}

	function checkIfFundingCompleteOrExpired () {

		if(totalRaised > minimunToRaise){

			state = State.Succesful;
			payOut();

		} else if (now > raiseBy){

			state = State.ExpiredRefund;

		}

		completeAt = now;
		
	}
	
	function payOut() public inState(State.Succesful) {

		if(!fundRecipient.send(this.balance)){ throw ;}
		state = State.Closed;
		currentBalance = 0;
		
	}
	
	function getRefund(uint256 id) public inState(State.ExpiredRefund) returns (bool){

		if(contributions.length <= id || id < 0 || contributions[id].amount == 0){
			throw;
		}

		uint amountToRefund = contributions[id].amount;
		contributions[id].amount = 0;

		if(!contributions[id].contributor[id].send(amountToRefund)){
			contributions[id].amount = amountToRefund;
			return false;
		} else {
			totalRaised -= amountToRefund;
			currentBalance = totalRaised;
		}
		return true;
	}


}
