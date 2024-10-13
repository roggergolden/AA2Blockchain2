async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);
  
    const ArtNFT = await ethers.getContractFactory("ArtNFT");
    console.log("Contract factory loaded.");
  
    const nft = await ArtNFT.deploy();
    console.log("Deploy transaction sent, waiting for deployment...");
  
    const txReceipt = await nft.waitForDeployment();
    console.log("NFT deployed to:", nft.target);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error("Error during deployment:", error);
      process.exit(1);
    });
  