// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

const contracAddress = "0x673932BF160F47F734263a0994Dd3284Dce739B5";

async function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
 // Deploy the contract 
 const nftContract = await hre.ethers.deployContract("CryptoDevs", [contracAddress]);

 // wait for the contract ot deploy
 await nftContract.waitForDeployment();

 console.log("NFT Contract Address:", nftContract.target);

 await sleep(30 * 1000);

 // verify the contract on etherscan
  await hre.run("verify:verify", {
    address: nftContract.target,
    constructorArguments: [contracAddress],
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
