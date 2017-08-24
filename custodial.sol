pragma solidity ^0.4.15;

contract CustodialContract {
    
    address client;
    bool _switch = false;
    
    event UpdateStatus(string _msg, uint _amount);
    event UserStatus(string _msg, address user, uint _amount);
    
    function CustodialContract()  {
        
        client = msg.sender;
        
    }
    
    modifier ifClient(){
        if(msg.sender != client){
            throw;
        } else {
            _;
        }
    }
    
     function depositFunds() payable {
        UpdateStatus('Deposit Money = ', msg.value);
        UserStatus('Address + Money = ', msg.sender, msg.value);
    }
    
    function getFunds()  ifClient() constant returns(uint){
        
        return this.balance;
    }
    
     function withdrawFunds(uint amount)  ifClient() {
         
         if(client.send(amount)){
             _switch = true;
         } else {
             
             _switch = false; 
             
         }
        
    }
    
}//contract ends 