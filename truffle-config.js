require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');
const mnemonic = process.env.METAMASK_MNEMONIC; // Make sure this is correctly set in your .env file

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
    },
    maticmumbai: {
      provider: () => new HDWalletProvider({
        mnemonic: {
          phrase: mnemonic
        },
        providerOrUrl: 'https://polygon-mumbai.infura.io/v3/c913bd3d28e04812a11b63eba6268262'
      }),
      network_id: 80001,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    },
  },
  compilers: {
    solc: {
      version: "0.8.21", // Use the version of Solidity you need
    }
  },
  // Add other configurations as needed
};
