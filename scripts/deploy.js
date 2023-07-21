// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

/* DeployContract in ethers.js is an abstraction used t deploy new smart contracts,
  so whitelistContract here is a factory for instance of our Whitelist contract.
 */

async function main() {
  // 10 is the Maximum number of whitelisted addresses allowed
 const whitelistContract = await hre.ethers.deployContract("Whitelist", [10]);

 // wait for the contract ot deploy
 await whitelistContract.waitForDeployment();

 console.log("Whitelist Contract Address:", whitelistContract.target);
 await sleep(30 * 1000);

 // verify the contract on etherscan
  await hre.run("verify:verify", {
    address: whitelistContract.target,
    constructorArguments: [10],
  });

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
