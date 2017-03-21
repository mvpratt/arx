// truffle console script

module.exports = function(callback) {

// deploy prescription
var rxaddr;
var arx;

ARX_Prescription.new().then(function(instance){
	console.log("new Rx deployed at: " + instance.address); 
	arx = ARX_Prescription.at(instance.address);

	// set medicatino id
	arx.setMedicationID(42);
	arx.getMedicationID.call().then(function(id){
		console.log("set medication id to: " + id.toNumber());
	});
});


ARX_Prescription.new().then(function(instance){ 
	arx = ARX_Prescription.at(instance.address);
});
	arx.setMedicationID(42);




	// transfer ownership
//	arx.getOwner.call().then(function(own){console.log("Rx owner:" + own);});

arx.transferOwner(web3.eth.accounts[1], {from: web3.eth.coinbase}).then(function(success){
		if (success != true){
			console.log("failed to xfer");
		}
		else {console.log ("success!");}

		arx.getOwner.call().then(function(own){
			console.log("New owner:" + own);
		})

	arx.transferOwner(web3.eth.coinbase, {from: web3.eth.accounts[1]}).then(function(success2){
		if (success != true){
			console.log("failed to xfer");
		}
		else {console.log ("success!");};	

		arx.getOwner.call().then(function(own){
			console.log("new owner:" + own);
		})
	});
});
}
/*

ARX_Doctor.deployed().createPrescription().then(function(addr){console.log(addr);})
*/

