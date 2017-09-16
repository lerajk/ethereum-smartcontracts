pragma solidity ^0.4.11;

contract Voting {

	mapping(bytes32 =>uint8) public votesReceived;

	bytes32[] public candidateList;

	function Voting(bytes32[] candidateNames) {

		candidateList = candidateNames;
	}

	function totalVotesFor(bytes32 candidate) returns (uint){
		if(validCandidate(candidate) == false) throw;
		return votesReceived[candidate];
	}

	function voteForCandidate(bytes32 candidate){
		if(validCandidate(candidate) == false) throw;
		votesReceived[candidate] += 1;
	}

	function validCandidate(bytes32 candidate) returns (bool) {
		for(uint i=0; i < candidateList.length; i++){
			if(candidate[i] == candidate){
				return true;
			}
		}

		return false;
	}


} //contract ends


//https://medium.com/@mvmurthy/full-stack-hello-world-voting-ethereum-dapp-tutorial-part-1-40d2d0d807c2
