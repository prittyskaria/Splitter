pragma solidity ^0.4.18;

contract Splitter {
    address public Alice;
    address public Bob;
    address public Carol;
    
    mapping (address => uint) balances;
    
    uint256 public balance;
    
    function Splitter() public {
        Alice = msg.sender;
    }

    function setAddressBob(address BobAddress) public {
        require(msg.sender == Alice);
         Bob = BobAddress;
    }
    
    function setAddressCarol(address CarolAddress) public {
         require(msg.sender == Alice);
         Carol = CarolAddress;
    }
   
    function getBalances() public view returns(uint, uint, uint, uint){
        return (address(this).balance,Alice.balance, Bob.balance, Carol.balance);
    } 

    function getBalance(address x) public view returns(uint){
       return x.balance;
    }
   
    function sendEther() public payable{
        uint amountToSplit;
        require(msg.sender == Alice && Bob != 0 && Carol!= 0);
        if(address(this).balance %2 == 0){
         amountToSplit = address(this).balance/2;
        }
        else{
         amountToSplit = (address(this).balance - 1)/2;    
        }
        Bob.transfer(amountToSplit);
        Carol.transfer(amountToSplit);  
    }
    
}
