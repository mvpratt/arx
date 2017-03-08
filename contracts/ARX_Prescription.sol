pragma solidity ^0.4.2;

import "ConvertLib.sol";


contract Test {

	uint num;
	function Test(){
		num = 1;
	}
}

contract ARX_Prescription {

	// Stakeholders
    address creator;
    address owner;
	address doctor;
	address patient; 
	address pharmacy;

	// Medication info
	uint medication_id;   // ID in a shared registry of medications
	uint refills_taken;

	// Prescription state
	uint constant CREATED = 0;   // doctor
	uint constant SIGNED = 1;    // doctor
	uint constant SUBMITTED = 2; // patient
	uint constant FILLED = 3;    // pharmacy
	uint constant EXPIRED = 4;   // pharmacy
	uint constant ERROR = 4;     // self
	uint rxstate;

	uint constant MAX_REFILLS = 3;


    // Define events
    event OnDeployed(address indexed deployed);

    event maxRefillsReached();


	// Constructor function
	function ARX_Prescription() {

        creator 		= msg.sender;
        owner 			= msg.sender;
        doctor 			= 0;
        patient 		= 0;
        pharmacy 		= 0;
		medication_id 	= 0;
		refills_taken 	= 0;
		rxstate 		= CREATED;
	}

	function testDeploy() {
		address deployed = new Test();
		OnDeployed(deployed);
		return;
	}


// Prescription state functions

	function setPrescriptionState(uint state) {
		rxstate = state;
	}
	
	function getPrescriptionState() returns(uint) {
		return rxstate;
	}

// Medication functions

	function setMedicationID(uint num) {
		medication_id = num;
	}
	
	function getMedicationID() returns(uint) {
		return medication_id;
	}
	
	function getRefillsLeft() returns(uint) {
		return MAX_REFILLS - refills_taken;
	}
	
	function incRefillsTaken() {
		if (refills_taken == MAX_REFILLS-1) {
		    refills_taken = MAX_REFILLS;
		    rxstate = EXPIRED;
        	maxRefillsReached();
        }
        else if (refills_taken < MAX_REFILLS) {
        	refills_taken = refills_taken + 1;
        }
	}
	


// Stakeholder functions

	function setPatient(address addr) {
		patient = addr;
	}
	
	function getPatient() returns(address) {
		return patient;
	}

	function setDoctor(address addr) {
		doctor = addr;
	}
	
	function getDoctor() returns(address) {
		return doctor;
	}

	function setPharmacy(address addr) {
		pharmacy = addr;
	}
	
	function getPharmacy() returns(address) {
		return pharmacy;
	}

	function getCreator() returns(address) {
		return creator;
	}
	
    function transferOwner(address newOwner) returns (bool) {
        // Only the current owner can transfer the token.
        if (msg.sender != owner) {
        	return false;
        }
        else {
        	owner = newOwner;
        	return true;
        }
    }

	function getOwner() returns(address) {
		return owner;
	}
}




