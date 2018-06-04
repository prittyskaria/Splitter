pragma solidity ^0.4.18;

contract Splitter {
    address public Alice;
    address public Bob;
    address public Carol;

    
    mapping (address => uint) public balances;
    
    event  FundsWithdrawn(address to, uint amount);
    event  AliceDeposits(address B, address C, uint amount);
    
    function Splitter() public {
        Alice = msg.sender;
    }
    
    function sendEther(address B, address C) public payable{
        uint amountToSplit;
        uint oddBalance;
        uint oldBobBalance;
        uint oldCarolBalance;
        
        require(msg.sender == Alice && msg.value > 0);
       
        
        if(B != Bob) {
           oldBobBalance = balances[Bob];
        }
        
        if(C != Carol) {
           oldCarolBalance = balances[Carol];
        }
        
        Bob = B;
        Carol = C;
        balances[Bob] += oldBobBalance;
        balances[Carol] += oldCarolBalance;
        
        AliceDeposits(B,C,msg.value);
        
        if(address(this).balance %2 == 0){
         amountToSplit = msg.value/2;
        }
        else{
         amountToSplit = (msg.value - 1)/2;  
         oddBalance = 1;
        }
       balances[Bob] += amountToSplit;
       balances[Carol] += amountToSplit;  
       balances[Alice] +=  oddBalance;  
    }
    
    function withdraw() public {
          uint amount = balances[msg.sender];
          balances[msg.sender] = 0;
          
          if(amount > 0) {
              msg.sender.transfer(amount);
              FundsWithdrawn(msg.sender, amount);
          }
          
    }    
    
    function() public payable { }      
  
}
        
        
    

