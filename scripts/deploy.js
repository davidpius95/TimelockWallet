// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const ethers = hre.ethers; 

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
	const [Owner] = await ethers.getSigners();
  console.log("Address of caller of the contract:", Owner);
  const Token = await ethers.getContractFactory("Token");
  const token = await Token.deploy();
  await token.deployed();
  console.log("Address of the Token contract:", token.address);
  const TokenAddress = token.address;

const Timelock = await ethers.getContractFactory("Timelock");
const timelock = await Timelock.deploy(TokenAddress);
await timelock.deployed();
console.log("Address of the timelock contract:", timelock.address);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
