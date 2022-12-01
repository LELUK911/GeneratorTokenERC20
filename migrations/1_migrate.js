const Migrations = artifacts.require("creatorToken");

module.exports =async function (deployer) {
  const fees = "100000000000000000"
  const contract = await deployer.deploy(Migrations,fees);
  console.log(contract)
};