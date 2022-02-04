const HDWalletProvider = require('@truffle/hdwallet-provider');
const privateKey = "";
const url = 'https://rinkeby.infura.io/v3/f430eed7088240ac9492fbdafe28350a';

module.exports = {
  networks: {
    cldev: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
    },
    ganache: {
      host: '127.0.0.1',
      port: 7545,
      network_id: '*',
    },
    binance_testnet: {
      provider: () => new HDWalletProvider(mnemonic,'https://data-seed-prebsc-1-s1.binance.org:8545'),
      network_id: 97,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    kovan: {
      provider: () => {
        return new HDWalletProvider(mnemonic, url)
      },
      network_id: '42',
      skipDryRun: true 
    },
    rinkeby: {
      provider: () => {
        return new HDWalletProvider(privateKey, "wss://rinkeby.infura.io/ws/v3/66566fe75bcd493baa674d8a26a42566")
      },
      network_id: '4',
      skipDryRun: true
    },
    mainnet: {
      provider: () => {
        return new HDWalletProvider(pk, "wss://mainnet.infura.io/ws/v3/66566fe75bcd493baa674d8a26a42566")
      },
      network_id: '1',
      skipDryRun: true
    },
  },
  compilers: {
    solc: {
      version: '0.7.0',
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        },
      evmVersion: 'byzantium', // Default: "petersburg"  
      }
    }
  },
  api_keys:{
    etherscan: 'NK8TUWYDKS1EZQGF9RTS5DEFJ2ZIPQFNGK',
  },
  plugins : [
    'truffle-plugin-verify'
  ]
}

// sudo remixd -s /local-folder-path --remix-ide https://remix.ethereum.org

