var accounts;


/*
var arx = ARX_Prescription.deployed();
var refill_event = arx.changedRefillsLeft();

// watch for changes
refill_event.watch(function(error, result){
    // result will contain various information
    // including the argumets given to the Deposit
    // call.
    refreshRefills();
    
    if (!error){
        console.log("refill event: " + result);
    }
});
*/

function setStatus(message) {
  var status = document.getElementById("status");
  status.innerHTML = message;
};


function refreshWindow() {
  var arx = ARX_Prescription.deployed();

  arx.getRefillsLeft.call({from: accounts[0]}).then(function(value) {
    var refill_element = document.getElementById("refills");
    refill_element.innerHTML = value.valueOf();
  }).catch(function(e) {
    console.log(e);
    setStatus("Error getting state; see log.");
  });

  arx.getPrescriptionState.call({from: accounts[0]}).then(function(value) {
    /*var state = "test";
    switch(value.valueOf()) {
      case 0:
        state = "Created";
        break;
      case 1:
        state = "Signed";
        break;
      case 2:
        state = "Submitted";
        break;
      case 3:
        state = "Refill Requested";
        break;
      case 4:
        state = "Filled";
        break;
      case 5:
        state = "Expired";
        break;
      case 6:
        state = "Error";
        break;
      default:
        state = "huh?";
    }*/

    var balance_element = document.getElementById("balance");
    balance_element.innerHTML = value.valueOf();
  }).catch(function(e) {
    console.log(e);
    setStatus("Error getting state; see log.");
  });
};


function init(){
  var arx = ARX_Prescription.deployed();

  arx.setMedicationID(42, {from: accounts[0]}).then(function(){
    arx.setPatient(accounts[1], {from: accounts[0]}).then(function(){
      arx.signRx({from: accounts[0]}).then(function(){
        arx.setPharmacy(accounts[2], {from: accounts[1]}).then(function(){
          arx.submitRx({from: accounts[1]});
        });
      });
    });
  });
}


function requestRefill() {
  var arx = ARX_Prescription.deployed();

  arx.reqRefillRx({from: accounts[1]}).then(function(){
    setStatus("Refill requested!");
  }).catch(function(e) {
    console.log(e);
    setStatus("Error requesting refill; see log.");
  });
}


function fillRx() {
  var arx = ARX_Prescription.deployed();

  arx.fillRx({from: accounts[2]}).then(function(){
    setStatus("Filled Rx!");
  }).catch(function(e) {
    console.log(e);
    setStatus("Error filling Rx; see log.");
  });
}


window.onload = function() {
  web3.eth.getAccounts(function(err, accs) {
    if (err != null) {
      alert("There was an error fetching your accounts.");
      return;
    }

    if (accs.length == 0) {
      alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
      return;
    }

    accounts = accs;
  });
}
