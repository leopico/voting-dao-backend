const hre = require("hardhat");

async function main() {
  const VotingDAO = await hre.ethers.getContractFactory("VotingDAO");
  const votingDAO = await VotingDAO.deploy();

  await votingDAO.deployed();

  console.log(` address: deployed to ${votingDAO.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
