const { expect } = require("chai");
const { ethers } = require("hardhat");
const BigNumber = require('bignumber.js');

describe("Test token and Timelock contract:", async function () {
  let token, timelock,signer1, signer2, signer3;
  before(async function () {
    const signers = await ethers.getSigners();
    signer1 = signers[0];
    signer2 = signers[1];
    signer3 = signers[3];
  


const Token = await ethers.getContractFactory("Token");
 token = await Token.deploy();
  await token.deployed();

const Timelock = await ethers.getContractFactory("Timelock");
 timelock = await Timelock.deploy(token.address);
  await timelock.deployed();
  console.log('Owner Address',signer1.address);

  });

  
  it("Should test on approving the timelock and also to deposit  ", async function () {
    const amount = ethers.utils.parseUnits('100', 'ether')
    console.log("testing",amount.toString())

    const balance = await token.balanceOf(signer1.address)
    console.log("my balance",balance.toString())

   const Approve= await token.approve(timelock.address, amount)
   console.log("checking",Approve.toString());

   const Deposit= await timelock.deposit(30)
   console.log("Deposit",Deposit.toString())
   
   // const e = await timelock.withdraw();
    // expect(await timelock.deposit()).to.equal("TIMI");
    // expect(await token.symbol()).to.equal("TIM");
  });
   it("Should return the correct balance", async function () {
const AmountCall = await timelock.amountCal()
console.log("amount the user get every month:",AmountCall.toString())

const Withdraw = await timelock.withdraws()
console.log("what the user get each months out of their balance:" ,Withdraw.toString())
 // expect(await timelock.withdraws()).to.equal("2500000000000000000");
   });
  
});
