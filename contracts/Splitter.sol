pragma solidity ^0.4.19;

contract Splitter {
    
    mapping (address => uint) public balances;
    address owner;
    
    event  LogWithdrawal(address withdrawer, uint amount);
    event  LogDeposit(address sender, address receiver1, address receiver2, uint amount);
    
    function Splitter() public {
        owner = msg.sender;
    }
    
    function deposit(address B, address C) public payable returns(bool success){
        require(B!=C && B!=msg.sender && C!=msg.sender && msg.value >0);
        
        uint amountToSplit;
        uint oddBalance;
        LogDeposit(msg.sender,B,C,msg.value);
        
        oddBalance = msg.value %2;
        if (oddBalance > 0){
         balances[msg.sender] +=  oddBalance; 
         }
        
        amountToSplit = (msg.value - oddBalance)/2;  
         
        balances[B] += amountToSplit;
        balances[C] += amountToSplit;  
        
       return true;
    }
    
    function withdraw() public returns(bool success){
          require (balances[msg.sender] > 0);
          
          uint amount = balances[msg.sender];
          LogWithdrawal(msg.sender, amount);

          balances[msg.sender] = 0;
          msg.sender.transfer(amount);
          
          return true;  
    }    
    
    function() public  { }      
  
}
        
        
    

