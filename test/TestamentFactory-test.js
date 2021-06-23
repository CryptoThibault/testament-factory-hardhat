// const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('TestamentFactory', async function () {
  let FACTORY, factory, dev, alice, bob;
  beforeEach(async function () {
    [dev, alice, bob] = await ethers.getSigners();
    FACTORY = await ethers.getContractFactroy('TestamentFactory');
    factory = await FACTORY.deploy();
    await factory.deployed();
  });
  it('Should deploy Testament with good sender', async function () {});
  it('Should deploy Testament with good doctor', async function () {});
  it('Should emits event DeployTestament', async function () {});
  it('Should reverts calls if Testament active', async function () {});
});
