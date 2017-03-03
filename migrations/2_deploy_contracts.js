module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.autolink();

  //deployer.deploy(ARX_Pharmacy);
  //deployer.deploy(ARX_Doctor);
  //deployer.deploy(ARX_Patient);
  deployer.deploy(ARX_Prescription);
};
