contract('MetaCoin', function(accounts) {
  it("should put 10000 MetaCoin in the first account", function() {
    var meta = MetaCoin.deployed();

    return meta.getBalance.call(accounts[0]).then(function(balance) {
      assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
    });
  });
  it("should call a function that depends on a linked library", function() {
    var meta = MetaCoin.deployed();
    var metaCoinBalance;
    var metaCoinEthBalance;

    return meta.getBalance.call(accounts[0]).then(function(outCoinBalance) {
      metaCoinBalance = outCoinBalance.toNumber();
      return meta.getBalanceInEth.call(accounts[0]);
    }).then(function(outCoinBalanceEth) {
      metaCoinEthBalance = outCoinBalanceEth.toNumber();
    }).then(function() {
      assert.equal(metaCoinEthBalance, 2 * metaCoinBalance, "Library function returned unexpeced function, linkage may be broken");
    });
  });
  it("should send coin correctly", function() {
    var meta = MetaCoin.deployed();

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

  it("should initialize to 0 refills allowed", function() {
    var meta = MetaCoin.deployed();

    return meta.getRefillsAllowed.call().then(function(refills_allowed) {
      assert.equal(refills_allowed.valueOf(), 0, "Refills allowed not initialized to 0");
    });
  });


  it("should be able to set refills allowed to 3", function() {
    var meta = MetaCoin.deployed();
    var refills = 3;

    return meta.setRefillsAllowed.call(refills, {from: accounts[1]}).then(function(done) {
      assert.equal(done, true, "Refills allowed set error");

    });

    return meta.getRefillsAllowed.call().then(function(refills_allowed) {
      assert.equal(refills_allowed.valueOf(), 3, "Refills allowed not set to 3");
    });

  });


  it("should initialize to 0 refills taken", function() {
    var meta = MetaCoin.deployed();

    return meta.getRefillsTaken.call().then(function(refills_taken) {
      assert.equal(refills_taken.valueOf(), 0, "Refills taken not initialized to 0");
    });
  });


  it("should be able to increment refills taken by 1", function() {
    var meta = MetaCoin.deployed();

    return meta.incRefillsTaken.call().then(function(done) {
      assert.equal(done, true, "Refills taken increment error");
    });
    return meta.getRefillsTaken.call().then(function(refills_taken) {
      assert.equal(refills_taken.valueOf(), 1, "Refills taken not incremented by 1");
    });
  });



});
