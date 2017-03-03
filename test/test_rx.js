/* TODO: Add tests for
  medication id
  pharmacy
  Test Stakeholders
    Add test for doctor, pharmacy address, prescription state
*/


contract('ARX_Prescription', function(accounts) {

// Set medication ID
it("should set med id to 42", function() {
  arx = ARX_Prescription.deployed();
  arx.setMedicationID(42);

  return arx.getMedicationID.call().then(function(id) {
      assert.equal(id.valueOf(), 42, "med id not 42");
    });
});


// send RX to new owner
it("should transfer contract to new owner",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.transferOwner(accounts[1], {from: accounts[0]}).then(function(success){
    arx.getOwner.call().then(function(own) {
      assert.equal(own, accounts[1], "ownership not xferred");
      console.log("new owner:" + own)
    });
  });
});  

// Invalid RX transfer
it("reject invalid transfer",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.transferOwner(accounts[2], {from: accounts[0]}).then(function(success){
    if (success != true){
      console.log("transfer reject because sender is not owner");
    }
    else {
    arx.getOwner.call().then(function(own) {
      assert.equal(own, accounts[2], "ownership not xferred");
      console.log("new owner:" + own)
    });
    }
  });
}); 



});
