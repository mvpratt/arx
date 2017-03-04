/* TODO: Add tests for
  medication id
  pharmacy
  Test Stakeholders
    Add test for doctor, pharmacy address, prescription state
*/

// accounts[0] = doctor
// accounts[1] = patient
// accounts[2] = pharmacy


contract('ARX_Prescription', function(accounts) {

// -------- Doctor ---------------//

// Set medication ID
it("Doctor sets Medication ID to 42", function() {
  arx = ARX_Prescription.deployed();
  arx.setMedicationID(42);

  return arx.getMedicationID.call().then(function(id) {
      assert.equal(id.valueOf(), 42, "error: med id not 42");
    });
});

// Doctor sends Rx to Patient
// send RX to new owner
it("Doctor transfers Rx to Patient",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.transferOwner(accounts[1], {from: accounts[0]}).then(function(success){
    arx.getOwner.call().then(function(own) {
      assert.equal(own, accounts[1], "error: ownership not xferred");
      //console.log("new owner: " + own)
    });
  });
});  

// Patient sends Rx to Pharmacy
// send RX to new owner
it("Patient sends Rx to Pharmacy",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.transferOwner(accounts[2], {from: accounts[1]}).then(function(success){
    arx.getOwner.call().then(function(own) {
      assert.equal(own, accounts[2], "error: ownership not xferred");
      //console.log("new owner: " + own)
    });
  });
});  

// ------- Negative testing ------------//

console.log("Negative testing")
// Doctor tries to send RX to Pharmacy -- should fail
// Refject Invalid RX transfer
it("Doctor tries to transfer Rx back to Patient",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.transferOwner(accounts[1], {from: accounts[0]}).then(function(success){
    if (success != true){
      //assert.equal(own, accounts[1], "error: ownership xferred but it shouldn't have been");
      //console.log("success: ownership transfer rejected because sender is not owner");
    }
    else {
      console.log("error: ownership xferred without owner permission - should have failed");
    }
  });
}); 

});
