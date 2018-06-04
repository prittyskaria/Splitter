pragma solidity ^0.4.18;

contract Splitter {
    
    mapping (address => uint) public balances;
    
    address owner;
    
    event  FundIsWithdrawn(address withdrawer, uint amount);
    event  DepositIsMade(address sender, address receiver1, address receiver2, uint amount);
    
    function Splitter() public {
       owner = msg.sender;
    }
    
    function sendFundsToSplit(address B, address C) public payable{
        uint amountToSplit;
        uint oddBalance;
        
        DepositIsMade(msg.sender, B, C, msg.value);
        
        if(msg.value %2 == 0){
         amountToSplit = msg.value/2;
        }
        else{
         amountToSplit = (msg.value - 1)/2;  
         oddBalance = 1;
        }
        
       balances[B] += amountToSplit;
       balances[C] += amountToSplit;  
       balances[msg.sender] +=  oddBalance;  
    }
    
    function withdraw() public {
          uint amount = balances[msg.sender];
          balances[msg.sender] = 0;
          
          if(amount > 0) {
              msg.sender.transfer(amount);
              FundIsWithdrawn(msg.sender, amount);
          }
          
    }    
    
    function() public payable { }      
  
}
        
        
    

