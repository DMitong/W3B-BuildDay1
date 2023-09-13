import { ethers } from "hardhat";

async function main() {
  const LeemaoToken = await ethers.deployContract("LeemaoToken", []);
  await LeemaoToken.waitForDeployment();
  console.log(`Contract Adddress of Leemao Token is: ${LeemaoToken.target}`);

  const WrappedLeemao = await ethers.deployContract("LeemaoWrapper", [LeemaoToken.target,]);
  await WrappedLeemao.waitForDeployment();
  console.log(`Contract Adddress of Wrapped Leemao is: ${WrappedLeemao.target}`);

}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});