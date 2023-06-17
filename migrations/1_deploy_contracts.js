const Articles = artifacts.require("Articles");
const Auction = artifacts.require("Auction");
const Profile = artifacts.require("Profile");
const File = artifacts.require("File");
const role_access = artifacts.require("role_access");
module.exports = function(deployer) {
  deployer.deploy(Articles);
  deployer.deploy(Auction);
  deployer.deploy(Profile);
  deployer.deploy(File);
  deployer.deploy(role_access);

  //deployer.deploy(Articles,'0xAe441A3175Cbf45Ba18fEd634516154eC3Ad0c66','Hello World!','Hello World! this is content.');
};
