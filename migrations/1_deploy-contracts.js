const YulString = artifacts.require("YulString");
const DT = artifacts.require("DelegateTestYulString");

module.exports = async function(deployer) {
  await deployer.deploy(YulString);

  const ys = await YulString.deployed();
  await deployer.deploy(DT, ys.address);
}

