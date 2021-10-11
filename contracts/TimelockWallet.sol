// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";

contract Timelock {
  uint time;
  address payable public immutable owner;
  uint public countMonths =0;
  address token;
uint amount;

event logDepo(address Address, address Address_ , uint amount);
event logWithdraw(address Addr, uint amount);


  constructor(address token_ ) {
    owner = payable(msg.sender);
     token = token_;
   
  }
  mapping(address => uint)balanceCheck;
  mapping (address => uint)balance;
  mapping (address => bool) hasDeposited;
  
  function deposit( uint amount_) external {
   require(hasDeposited[msg.sender]==false, "");
  amount =amount_*10**18;
  console.log(amount);

  //require(token, "Invalid token Address" );
    time=block.timestamp;
    IERC20(token).transferFrom(msg.sender, address(this), amount);
    balanceCheck[msg.sender]+=amount;
     balance[msg.sender]+=amount;
     hasDeposited[msg.sender]=true;
     emit logDepo(msg.sender,address(this), amount);
    
  }
  
  receive() external payable {}
  
 function amountCal() public view  returns(uint){
   console.log(balance[msg.sender]);
    uint Receive = ((balance[msg.sender])/12);
    console.log(Receive);
   return Receive;
  }
//   function checks()public   returns(uint){
//       return amountCal();
//   }
  
	

  
  
  function withdraws() external {
    
    require(balanceCheck[msg.sender]>0, "Insufficiant balance");
    require(countMonths<=12, "maximum count reached");
    countMonths++;
    require( block.timestamp >= time+ 1 seconds, "must be up to 30 days" );
    require(msg.sender == owner, 'only owner');
    balanceCheck[msg.sender]-=amountCal();
    IERC20(token).transfer(owner, amountCal());
    time=block.timestamp;
    emit logWithdraw(msg.sender, amountCal());
  }
  function balancecheck(address Address_ ) public view returns(uint){
      return balanceCheck[msg.sender];
      
  }
  // scenario 3
//   function withdraw(address token) external {                                        
//     uint amount =100;                                                               
//     require(countMonths<=12, "maximum count reached");                               
//     countMonths++;                                                                   
//     require( block.timestamp >= time+30 days );                                    
//     require(msg.sender == owner, 'only owner');                                     
//     IERC20(token).transfer(owner, amount);                                           
//     time=block.timestamp;                                                            
//   }         
}

// Test scenario 1:
// deposit(token1, 1000)
// deposit(token2, 1000)
// 
// the second deposit should be disallowed

// Test scenario 2
// deposit(token1, 1000)
// deposit(token1, 2000)
// 
//// receiver should receive 3000/12 each month

// Test scenario 3
// deposit(token1, 100)
//
// one should compute that tranche that received after the deposit
// 100/12
//
// Total payoff to the receiver:
// month 1: 1/12*100
// month 2: 2/12*100
//
// month 12: 12/12*100=100

// Owner of the contract:
///  * initializes it
///  * pays the money

// Receiver of the money:
//   * gets the money over 12 months
//   * month is approximate as 30 days
//   * receiver should get month/12*1000 every month
//   * at the end receiver gets all the money
