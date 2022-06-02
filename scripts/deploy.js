
const main = async () => {

  const nftContractFactory = await hre.ethers.getContractFactory('ImperialToken');
  const nftContract = await nftContractFactory.deploy();
  // await nftContract.deployed();
  console.log(`Deployed NFT contract at ${nftContract.address}`);

  let txn = await nftContract.makeAnNFT()
  await txn.wait();
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
}

runMain();