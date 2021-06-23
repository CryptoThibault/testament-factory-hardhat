const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('TestamentFactory', async function () {
  let FACTORY, factory, dev, alice, bob;
  const ADDRESS_ZERO = ethers.constants.AddressZero;
  beforeEach(async function () {
    [dev, alice, bob] = await ethers.getSigners();
    FACTORY = await ethers.getContractFactory('TestamentFactory');
    factory = await FACTORY.connect(dev).deploy();
    await factory.deployed();
  });
  it('Should deploy Testament for good sender', async function () {
    await factory.connect(alice).deployTestament(bob.address);
    expect(await factory.testamentOf(alice.address)).to.not.equal(ADDRESS_ZERO);
  });
  it('Should deploy Testament with good doctor', async function () {});
  it('Should emits event DeployTestament', async function () {
    expect(await factory.connect(alice).deployTestament(bob.address))
      .to.emit(factory, 'DeployTestament')
      .withArgs(alice.address, bob.address);
  });
  it('Should reverts calls if Testament active', async function () {
    await factory.connect(alice).deployTestament(bob.address);
    await expect(factory.connect(alice).deployTestament(bob.address)).to.revertedWith(
      // eslint-disable-next-line comma-dangle
      'TestamentFactory: Sender already have a testament'
    );
  });
});
