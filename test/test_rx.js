

// accounts[0] = doctor
// accounts[1] = patient
// accounts[2] = pharmacy


contract('ARX_Prescription', function(accounts) {

  // Prescription state
  const CREATED = 0;   
  const SIGNED = 1;    
  const SUBMITTED = 2; 
  const FILLED = 3;    
  const EXPIRED = 4;   
  const ERROR = 4;     


it("Doctor sets doctor address", function() {
  arx = ARX_Prescription.deployed();
  arx.setDoctor(accounts[0], {from: accounts[0]});

  return arx.getDoctor.call().then(function(addr) {
      assert.equal(addr, accounts[0], "error: doctor address incorrect");
    });
});


it("Doctor sets Medication ID to 42", function() {
  arx = ARX_Prescription.deployed();
  arx.setMedicationID(42, {from: accounts[0]});

  return arx.getMedicationID.call().then(function(id) {
      assert.equal(id.valueOf(), 42, "error: med id not 42");
    });
});


it("Doctor sets Patient address", function() {
  arx = ARX_Prescription.deployed();
  arx.setPatient(accounts[1], {from: accounts[0]});

  return arx.getPatient.call().then(function(addr) {
      assert.equal(addr, accounts[1], "error: patient address incorrect");
    });
});


it("Doctor changes prescription state to SIGNED", function() {
  arx = ARX_Prescription.deployed();
  arx.setPrescriptionState(SIGNED, {from: accounts[0]});

  return arx.getPrescriptionState.call().then(function(state) {
      assert.equal(state, SIGNED, "error: Rx state not SIGNED");
    });
});



it("Doctor transfers Rx to Patient",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.transferOwner(accounts[1], {from: accounts[0]}).then(function(success){
    arx.getOwner.call().then(function(own) {
      assert.equal(own, accounts[1], "error: ownership not xferred");
    });
  });
});  

 
// Doctor tries to send RX back to patient -- should fail
it("Negative testing:   Doctor tries to transfer Rx back to Patient",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.transferOwner(accounts[1], {from: accounts[0]}).then(function(success){
    if (success != true){
    }
    else {
      console.log("error: ownership xferred without owner permission - should have failed");
    }
  });
}); 


it("Patient sets Pharmacy address",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.setPharmacy(accounts[2], {from: accounts[1]}).then(function(){
    arx.getPharmacy.call().then(function(pharm) {
      assert.equal(pharm, accounts[2], "error: pharmacy address incorrect");
    });
  });
}); 


it("Patient changes prescription state to SUBMITTED", function() {
  arx = ARX_Prescription.deployed();
  arx.setPrescriptionState(SUBMITTED, {from: accounts[0]});

  return arx.getPrescriptionState.call().then(function(state) {
      assert.equal(state, SUBMITTED, "error: Rx state not SUBMITTED");
    });
});


it("Patient changes ownership to Pharmacy",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.transferOwner(accounts[2], {from: accounts[1]}).then(function(){
    arx.getOwner.call().then(function(own) {
      assert.equal(own, accounts[2], "error: ownership not xferred");
    });
  });
}); 


it("Patient requests a refill",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.incRefillsTaken({from: accounts[1]}).then(function(){
    arx.getRefillsLeft.call().then(function(refill) {
      assert.equal(refill, 2, "error: refills left not decremented");
    });
  });
}); 


it("Pharmacy changes prescription state to FILLED", function() {
  arx = ARX_Prescription.deployed();
  arx.setPrescriptionState(FILLED, {from: accounts[0]});

  return arx.getPrescriptionState.call().then(function(state) {
      assert.equal(state, FILLED, "error: Rx state not FILLED");
    });
});


it("Patient requests 2nd refill",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.incRefillsTaken({from: accounts[1]}).then(function(){
    arx.getRefillsLeft.call().then(function(refill) {
      assert.equal(refill, 1, "error: refills left not decremented");
    });
  });
}); 


it("Patient requests last refill",function(){
  arx = ARX_Prescription.deployed();
  
  return arx.incRefillsTaken({from: accounts[1]}).then(function(){
    arx.getRefillsLeft.call().then(function(refill) {
      assert.equal(refill, 0, "error: refills left not decremented");
    });
  });
}); 


it("Prescription state should change to EXPIRED automatically when 3rd refill is requested", function() {
  arx = ARX_Prescription.deployed();

  return arx.getPrescriptionState.call().then(function(state) {
      assert.equal(state, EXPIRED, "error: Rx state not EXPIRED");
    });
});


// Patient requests 4th refill -- should fail
it("Negative Testing: Patient requests extra refill - should fail",function(){
  arx = ARX_Prescription.deployed();

  return arx.incRefillsTaken({from: accounts[1]}).then(function(){
      arx.getRefillsLeft.call().then(function(refill) {
      assert.equal(refill, 0, "error: max refills reached, refills left should be 0");
    });
  });
});





});
