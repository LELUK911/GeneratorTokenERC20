const creatorTokenERC = artifacts.require("creatorTokenERC");
const creatorTokenNFT = artifacts.require("creatorTokenNFT");

module.exports = async function (deployer) {
  const feesERC = "100000000000000000";
  const feesNFT = "100000000000000000";

  await deployer.deploy(creatorTokenERC, feesERC);
  await deployer.deploy(creatorTokenNFT, feesNFT);
};
