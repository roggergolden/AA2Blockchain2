async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const RealEstateNFT = await ethers.getContractFactory("RealEstateNFT");
  const nft = await RealEstateNFT.deploy();

  console.log("Deploy transaction sent, waiting for deployment...");

  await nft.waitForDeployment();

  console.log("RealEstateNFT deployed to:", await nft.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Error during deployment:", error);
    process.exit(1);
  });
