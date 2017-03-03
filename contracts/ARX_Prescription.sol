pragma solidity ^0.4.2;

import "ConvertLib.sol";


/* TODO:

Doctor - deploy a prescription
Doctor - send to the patient


Store patient data off chain (for privacy)
Restrict access to prescriptions:
     http://solidity.readthedocs.io/en/latest/common-patterns.html#restricting-access

Add website static data (developer interface)

Add website interaction - separate tabs for pharmacy, patient, doctor
http://getbootstrap.com/
http://getskeleton.com/

Doxygen - standard documentation.
Deploy on GETH local net

*/

/* Other contracts / data structures

	Pharmacy - smart contract
		name, 
		address, 
		inventory of medications, (internal array of strings)
		active prescriptions (links to contract addresses)

	Doctor - user account
   		name, 
   		address, 
   		prescriptions signed

	Prescription - smart contract TOKEN
		doctor, 
		patient, 
		pharmacy, 
		medication, 
		refills allowed, 
		refills taken

	Patient - user account
   		name, 
   		address, 
   		prescriptions owned
*/

/* Assumptions
	Inventory is binary - if a medication is in the inventory list, it's always in stock.  If its not in the list, it's never in stock
*/

/* Web Interface

Pharmacy View
	My patients
		Patient prescriptions

Doctor View
	My patients
		Patient prescriptions

Patient View
	My prescriptions
	My doctors
	My pharmacies

Developer Mode
	All data is readable
	Can request transactions from any account
*/



contract ARX_Prescription {

	// Stakeholders
    address creator;
    address owner;

	address doctor;
	address patient; 
	address pharmacy;

	// Medication	
	uint medication_id;   // ID in a shared registry of medications
	uint refills_allowed;
	uint refills_taken;


// Contract state 
//	enum PrescriptionState { Created, Signed, Submitted, Filled, Expired, Error }

//	PrescriptionState rxstate;
//	PrescriptionState constant default_rxstate = PrescriptionState.Created;


	// Constructor function
	function ARX_Prescription() {

		medication_id = 0;
		refills_allowed = 0;
		refills_taken = 0;

		// State variables are accessed via their name
        // and not via e.g. this.owner. This also applies
        // to functions and especially in the constructors,
        // you can only call them like that ("internall"),
        // because the contract itself does not exist yet.
        owner = msg.sender;
        // We do an explicit type conversion from `address`
        // to `TokenCreator` and assume that the type of
        // the calling contract is TokenCreator, there is
        // no real way to check that.
        //creator = ARX_Doctor(msg.sender);
	}

    function transferOwner(address newOwner) returns (bool) {
        // Only the current owner can transfer the token.
        if (msg.sender != owner) {
        	return false;
        }
        // We also want to ask the creator if the transfer
        // is fine. Note that this calls a function of the
        // contract defined below. If the call fails (e.g.
        // due to out-of-gas), the execution here stops
        // immediately.
        //if (creator.isTokenTransferOK(owner, newOwner))
        //    owner = newOwner;

        else {
        	owner = newOwner;
        	return true;
        }
    }

	function getCreator() returns(address) {
		return creator;
	}
	function getOwner() returns(address) {
		return owner;
	}

// Contract state functions
/*
	function setPrescriptionState(PrescriptionState state) returns(bool) {
		rxstate = state;
        return true;
	}
	
	function getPrescriptionState() returns(PrescriptionState) {
		return rxstate;
	}
*/
// Medication functions

	function setMedicationID(uint num) returns(bool) {
		medication_id = num;
        return true;
	}
	
	function getMedicationID() returns(uint) {
		return medication_id;
	}

	function setRefillsAllowed(uint num) returns(bool) {
		refills_allowed = num;
        return true;
	}
	
	function getRefillsAllowed() returns(uint) {
		return refills_allowed;
	}
	
	function incRefillsTaken() returns (bool) {
		refills_taken = refills_taken + 1;
        return true;
	}
	
	function getRefillsTaken() returns(uint) {
		return refills_taken;
	}	


// Stakeholder functions


	function setPatientAddress(address addr) returns(bool) {
		patient = addr;
        return true;
	}
	
	function getPatientAddress() returns(address) {
		return patient;
	}

	function setDoctorAddress(address addr) returns(bool) {
		doctor = addr;
        return true;
	}
	
	function getDoctorAddress() returns(address) {
		return doctor;
	}

	function setPharmacyAddress(address addr) returns(bool) {
		pharmacy = addr;
        return true;
	}
	
	function getPharmacyAddress() returns(address) {
		return pharmacy;
	}
	
}




/*
	Doctor - 
   		name, 
   		address, 
   		prescriptions list
*/

/*
contract ARX_Doctor {

	ARX_Prescription myPrescription;



	function ARX_Doctor() {
	}
*/
// Prescription functions
// new prescription (deploy contract, add address to list)
// sign prescription (prescription address)
// send prescription (patient address)
// list prescriptions ()

/*
	mapping(uint => ARX_Prescription) deployedContracts;
	uint numContracts;

	ARX_Prescription deployedContract;
*/

/*	function createPrescription() returns(address rx) {
        // Create a new Token contract and return its address.
        // From the JavaScript side, the return type is simply
        // "address", as this is the closest type available in
        // the ABI.
        //deployedContracts[numContracts] = new ARX_Prescription();
		//numContracts++;
		//return deployedContracts[numContracts];
		deployedContract = new ARX_Prescription();
		return deployedContract;
        //return new ARX_Prescription();
	}

*/

/*
	function setPrescriptionState(ARX_Prescription rxaddr, ARX_Prescription.PrescriptionState state) returns(bool) {
		rxaddr.setPrescriptionState(state);
        return true;
	}
	
	function getPrescriptionState(ARX_Prescription rxaddr) returns(ARX_Prescription.PrescriptionState) {
		return rxaddr.getPrescriptionState();
	}
*/
    /**@dev Adds prescription to my list
     * @param rxaddr Deployed prescription contract

     *//*
	function addPrescription(ARX_Prescription rxaddr) returns (bool){
		myPrescription = rxaddr;
	}

	function getPrescription() returns (address){
		return myPrescription;
	}
*/
/*	function transferPrescription(ARX_Prescription rxaddr, ARX_Patient pxaddr) returns(bool) {
		rxaddr.transfer(pxaddr);
	}

    function isTokenTransferOK(
        address currentOwner,
        address newOwner
    ) returns (bool ok) {
        // Check some arbitrary condition.
        address tokenAddress = msg.sender;
        return (keccak256(newOwner) & 0xff) == (bytes20(tokenAddress) & 0xff);
    }
*/
/*}

contract ARX_Patient {

	//mapping(uint => ARX_Prescription) myPrescriptions;
	//uint numPrescriptions;

	ARX_Prescription myPrescription;

	// Constructor function
	function ARX_Patient() {
	}

	function addPrescription(ARX_Prescription rxaddr) returns (bool){
		myPrescription = rxaddr;
	}

	function getPrescription() returns (address){
		return myPrescription;
	}*/
/*
	function transferPrescription(ARX_Prescription rxaddr, ARX_Patient pxaddr) returns(bool) {
		rxaddr.transfer(pxaddr);
	}
*//*
    function isTokenTransferOK(
        address currentOwner,
        address newOwner
    ) returns (bool ok) {
        // Check some arbitrary condition.
        address tokenAddress = msg.sender;
        return (keccak256(newOwner) & 0xff) == (bytes20(tokenAddress) & 0xff);
    }

}

contract ARX_Pharmacy {

// -------- Old stuff -------------------------------------------------------//
	mapping (address => uint) balances;
// -------- Old stuff -------------------------------------------------------//


    struct PharmacyInfo {
		string business_name;
		string business_address; 
    }

	PharmacyInfo public my_pharmacy; 


// Inventory of medications  (Array of strings)
	string [10] inventory;

// List Prescriptions (Array of addresses)
	address [10] prescriptions;
	uint prescriptions_append_loc;


// Constructor function
	function ARX_Pharmacy() {

		balances[tx.origin] = 10000;

		my_pharmacy.business_name = "Zaphod's Pharmacy";
		my_pharmacy.business_address = "4200 Infinity Dr";

		// Initialize medication inventory
		for (uint id = 1; id < 10; id++) {
			inventory[id] = "test rx";
        }
	}


// Inventory functions

	function setMedicationName(uint id, string name) returns(bool) {
		inventory[id] = name;
        return true;
	}
	
	function getMedicationName(uint id) returns(string) {
		return inventory[id];
	}
		
// Prescriptions

	function addPrescriptionAddress(address rx) returns(bool) {
		prescriptions[prescriptions_append_loc] = rx;
		prescriptions_append_loc += 1;
        return true;
	}
	
	function getPrescriptionAddress(uint num) returns(address) {
		return prescriptions[num];
	}


// Pharamcy Info

	function setBusinessName(string name) returns(bool) {
		my_pharmacy.business_name = name;
        return true;
	}
	
	function getBusinessName() returns(string) {
		return my_pharmacy.business_name;
	}

	function setBusinessAddress(string addr) returns(bool) {
		my_pharmacy.business_address = addr;
        return true;
	}
	
	function getBusinessAddress() returns(string) {
		return my_pharmacy.business_address;
	}

// -------- Old stuff -------------------------------------------------------//
	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	function sendCoin(address receiver, uint amount) returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) returns(uint) {
		return balances[addr];
	}
// -------- Old stuff -------------------------------------------------------//

}
*/


