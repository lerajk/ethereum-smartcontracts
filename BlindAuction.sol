pragma solidity ^0.4.11;

contract BlindAuction {
    
    struct Bid {
        
        bytes32 blindedBid;
        uint deposit;
    }
    
    address public benefictiary;
    uint public biddingEnd;
    uint public revelEnd;
    bool public ended;
    
    mapping (address => Bid[]) public bids;
    
    address public higestestBidder;
    uint public highestBid; 
    
    mapping (address => uint) pendingReturns;
    
    modifier onlyBefore(uint _time){
        require (now < _time);
        _;
    }
    
    modifier onlyAfter(uint _time){
        require (now > _time);
        _;
    }
    
    function BlindAuction (uint _biddingTime, uint _revealTime, address _beneficiary){
        benefictiary = _beneficiary;
        biddingEnd = now + _biddingTime;
        revelEnd = biddingEnd + _revealTime;
    }
    
    function bid(bytes32 _blindedBid) payable onlyBefore(biddingEnd){
        
        bids[msg.sender].push(Bid({
            blindedBid: _blindedBid,
            deposit: msg.value
        }));
    }
    
    
    
    
}