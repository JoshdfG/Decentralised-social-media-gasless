import { ethers } from "hardhat";

async function main() {
  const socialMedia = await ethers.deployContract("SocialMedia");

  await socialMedia.waitForDeployment();

  console.log(`SocialMedia deployed to ${socialMedia.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
