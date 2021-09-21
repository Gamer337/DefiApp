require('babel-register');
require('babel-polyfill');

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      host: "127.0.0.1", 
      port: 7545, 
      from: "0xF82b1be8edb7695bd195d288C2Dc4AB0BB339758", // default address to use for any transaction Truffle makes during migrations
      network_id: 4,
      gas: 4612388 // Gas limit used for deploys
    },
    ganacheOptions: {
      host: "127.0.0.1",
      port: 7545,
      network_id: 5777,
      noVMErrorsOnRPCResponse: true
    },
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  compilers: {
    solc: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      evmVersion: "petersburg"
    }
  }
}
