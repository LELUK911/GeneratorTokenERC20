const truffleAssertions = require("truffle-assertions");
const { assert } = require("chai");
const CreateContract = artifacts.require("creatorTokenNFT");
console.clear();
contract("NFT preliminary Test", async (accounts) => {
  const account = accounts[0];
  const account2 = accounts[1];

  const supply = "10000000000000000000000000000";
  const fees = "100000000000000000";

  it("NFTMintableProgressiveStorageURIBurnable", async () => {
    const createContract = await CreateContract.deployed();
    const balanceBefore = await createContract.getBalance();

    const newToken = await createContract.createNftProStoURIburnalble(
      account,
      "Nft burnable",
      "NFB",
      { value: fees }
    );
    console.log("address new token " + newToken.logs[0].address);

    let ethBalance = await web3.eth.getBalance(createContract.address);
    const balance = await createContract.getBalance();
    //console.log(ethBalance);
    //console.log(balance.toString());

    assert(
      ethBalance.toString() == balance.toString(),
      "balance not correspond"
    );
    assert(
      balance.toString() === fees,
      "Problem with update balance or deposit fees"
    );
  });

  it("Withdraw balance", async () => {
    const createContract = await CreateContract.deployed();
    const balanceBefore = await createContract.getBalance();
    let ethBalance = await web3.eth.getBalance(createContract.address);
    let ownerBalance = await web3.eth.getBalance(account);
    //console.log(ownerBalance);
    assert(
      ethBalance.toString() === balanceBefore.toString(),
      "balance not correspond"
    );

    await createContract.withdraw();
    const balanceAfter = await createContract.getBalance();
    ethBalance = await web3.eth.getBalance(createContract.address);
    ownerBalance = await web3.eth.getBalance(account);
    //console.log(ownerBalance);
    assert(
      ethBalance.toString() === balanceAfter.toString(),
      "balance not correspond"
    );
    assert(
      +balanceBefore != 0 && +balanceAfter === 0,
      "Problem with update balance"
    );
  });
  it("set new fees", async () => {
    const createContract = await CreateContract.deployed();

    await createContract.setFees("1000000000000000000");

    const newFees = await createContract.getFees();

    assert(
      newFees.toString() === "1000000000000000000",
      "fees not correct update"
    );
  });
  //Faills transaction
  it("Only Owner Withdraw balance", async () => {
    const createContract = await CreateContract.deployed();

    await truffleAssertions.reverts(
      createContract.withdraw({ from: account2 })
    );
  });
  it("Set Correct Fees for createFixSupply", async () => {
    const createContract = await CreateContract.deployed();

    await truffleAssertions.reverts(
      createContract.createNftProStoURIburnalble(
        account,
        "Nft burnable",
        "NFB",
        { value: "100" }
      )
    );
  });
  it("Only Owner can set new fees", async () => {
    const createContract = await CreateContract.deployed();

    await truffleAssertions.reverts(
      createContract.setFees("1000000", { from: account2 })
    );
  });
  it("when in pause , function are in PAUSA!", async () => {
    const createContract = await CreateContract.deployed();

    await createContract.setPause();

    await truffleAssertions.reverts(
      createContract.createNftProStoURIburnalble(
        account,
        "Nft burnable",
        "NFB",
        { value: "100" }
      )
    );
  });
});
