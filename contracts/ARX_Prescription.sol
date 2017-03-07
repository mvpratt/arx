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
	uint refills_allowed;
	uint refills_taken;

	// Prescription state
	uint constant CREATED = 0;
	uint constant SIGNED = 1;
	uint constant SUBMITTED = 2;
	uint constant FILLED = 3;
	uint constant EXPIRED = 4;
	uint constant ERROR = 4;

	uint rxstate;

	// Constructor function
	function ARX_Prescription() {

        creator 		= msg.sender;
        owner 			= msg.sender;

		medication_id 	= 0;
		refills_allowed = 0;
		refills_taken 	= 0;

		rxstate 		= CREATED;
	}

	function testDeploy() returns (address a){
		a = new Test();
		return a;
	}


// Prescription state functions

	function setPrescriptionState(uint state) returns(bool) {
		rxstate = state;
        return true;
	}
	
	function getPrescriptionState() returns(uint) {
		return rxstate;
	}

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

	function setPatient(address addr) returns(bool) {
		patient = addr;
        return true;
	}
	
	function getPatient() returns(address) {
		return patient;
	}

	function setDoctor(address addr) returns(bool) {
		doctor = addr;
        return true;
	}
	
	function getDoctor() returns(address) {
		return doctor;
	}

	function setPharmacy(address addr) returns(bool) {
		pharmacy = addr;
        return true;
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




