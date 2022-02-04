const { upgradeProxy, deployProxy } = require('@openzeppelin/truffle-upgrades');

// // ############# 1st deployment  ####################


const myContract = artifacts.require("CroissantV1");

module.exports = async function (deployer) {
  const instance = await deployProxy(myContract, { deployer });
  console.log('Deployed', instance.address);
};

// ############# upgrade deployment  ####################

// const oldContract = artifacts.require('CroissantV1');
// const newContract = artifacts.require('CroissantV2');

// module.exports = async function (deployer) {
//   const existing = await oldContract.deployed();
//   const instance = await upgradeProxy(existing.address, newContract, { deployer});
//   console.log("Upgraded", instance.address);
// };


// simple deploy 


// const Migrations = artifacts.require("MonsterbudsV1");

// module.exports = function (deployer) {
//   deployer.deploy(Migrations);
// };0x2572c6f000fCF9a8EFD736D9870335e10cC5e004