// Script to test the Spotify Portal Contract

const main = async () => {

    // A contract factory is an abstraction used to deploy new smart contracts. 
    const playlistContractFactory = await hre.ethers.getContractFactory('SpotifyPortal');

    // Using our abstaction from above, called playlistContractFactory, 
    // to deploy 
    const playlistContract = await playlistContractFactory.deploy();
    await playlistContract.deployed();
    console.log('Contract address:', playlistContract.address);
    

    let playlistCount;

    // playlistCount will store total amount of playlists (int)
    playlistCount = await playlistContract.getTotalPlaylists();
    console.log(playlistCount.toNumber());
  
    // Send some test waves

    let playlistTxn = await playlistContract.drop('Some link', 'for mom');
    await playlistTxn.wait(); // Wait for the transaction to be mined 

    const [_, randomPerson] = await hre.ethers.getSigners();
    playlistTxn = await playlistContract.connect(randomPerson).drop('Some other playlist', 'for dad');
    await playlistTxn.wait(); // wait for the transaction to be mined

    let allPlaylists = await playlistContract.getAllPlaylists();
    console.log(allPlaylists)
     
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();