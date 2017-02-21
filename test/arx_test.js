/* TODO: Add tests for
  medication id
  pharmacy
  Test Stakeholders
    Add test for doctor, pharmacy address, prescription state
*/


contract('ARX_Pharmacy', function(accounts) {

// -------- Old stuff -------------------------------------------------------//  

  it("should put 10000 ARX_Pharmacy in the first account", function() {
    var meta = ARX_Pharmacy.deployed();

    return meta.getBalance.call(accounts[0]).then(function(balance) {
      assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
    });
  });
  it("should call a function that depends on a linked library", function() {
    var meta = ARX_Pharmacy.deployed();
    var ARX_PharmacyBalance;
    var ARX_PharmacyEthBalance;

    return meta.getBalance.call(accounts[0]).then(function(outCoinBalance) {
      ARX_PharmacyBalance = outCoinBalance.toNumber();
      return meta.getBalanceInEth.call(accounts[0]);
    }).then(function(outCoinBalanceEth) {
      ARX_PharmacyEthBalance = outCoinBalanceEth.toNumber();
    }).then(function() {
      assert.equal(ARX_PharmacyEthBalance, 2 * ARX_PharmacyBalance, "Library function returned unexpeced function, linkage may be broken");
    });
  });
  it("should send coin correctly", function() {
    var meta = ARX_Pharmacy.deployed();

    // Get initial balances of first and second account.
    var account_one = accounts[0];
    var account_two = accounts[1];

    var account_one_starting_balance;
    var account_two_starting_balance;
    var account_one_ending_balance;
    var account_two_ending_balance;

    var amount = 10;

    return meta.getBalance.call(account_one).then(function(balance) {
      account_one_starting_balance = balance.toNumber();
      return meta.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_starting_balance = balance.toNumber();
      return meta.sendCoin(account_two, amount, {from: account_one});
    }).then(function() {
      return meta.getBalance.call(account_one);
    }).then(function(balance) {
      account_one_ending_balance = balance.toNumber();
      return meta.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_ending_balance = balance.toNumber();

      assert.equal(account_one_ending_balance, account_one_starting_balance - amount, "Amount wasn't correctly taken from the sender");
      assert.equal(account_two_ending_balance, account_two_starting_balance + amount, "Amount wasn't correctly sent to the receiver");
    });
  });

// -------- Old stuff -------------------------------------------------------//
  


  it("should initialize to 0 refills allowed", function() {
    var meta = ARX_Prescription.deployed();

    return meta.getRefillsAllowed.call().then(function(refills_allowed) {
      assert.equal(refills_allowed.valueOf(), 0, "Refills allowed not initialized to 0");
    });
  });

  it("should be able to set refills allowed to 3", function() {
    var meta = ARX_Prescription.deployed();
    var refills = 3;

    return meta.setRefillsAllowed.call(refills, {from: accounts[1]}).then(function(done) {
      assert.equal(done, true, "Refills allowed set error");
    });
    return meta.getRefillsAllowed.call().then(function(refills_allowed) {
      assert.equal(refills_allowed.valueOf(), 3, "Refills allowed not set to 3");
    });
  });

  it("should initialize to 0 refills taken", function() {
    var meta = ARX_Prescription.deployed();

    return meta.getRefillsTaken.call().then(function(refills_taken) {
      assert.equal(refills_taken.valueOf(), 0, "Refills taken not initialized to 0");
    });
  });

  it("should be able to increment refills taken by 1", function() {
    var meta = ARX_Prescription.deployed();

    return meta.incRefillsTaken.call().then(function(done) {
      assert.equal(done, true, "Refills taken increment error");
    });
    return meta.getRefillsTaken.call().then(function(refills_taken) {
      assert.equal(refills_taken.valueOf(), 1, "Refills taken not incremented by 1");
    });
  });

// Test Stakeholders


  it("should be able to set stakeholder address", function() {
    var meta = ARX_Prescription.deployed();
    var patient = 0x42;

    return meta.setPatientAddress.call(patient, {from: accounts[1]}).then(function(done) {
      assert.equal(done, true, "Error: Patient address set failed");
    });
    return meta.getPatientAddress.call().then(function(patient_address) {
      assert.equal(patient_address, patient, "Error: Patient address not set to expected value");
    });
  });


});
