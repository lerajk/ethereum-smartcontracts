pragma solidity ^0.4.15;

contract CustodialContract {
    
    address client;
    bool _switch = false;
    
    function CustodialContract()  {
        
        client = msg.sender;
        
    }
    
     function depositFunds() payable {
        
    }
    
    function getFunds() constant returns(uint){
        
        return this.balance;
    }
    
     function withdrawFunds(uint amount) {
         
         if(client.send(amount)){
             _switch = true;
         } else {
             
             _switch = false; 
             
         }
        
    }
    
}//contract ends 