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
	address doctor;
	address patient; 
	address pharmacy;

	// Medication info
	uint medication_id;   // ID in a shared registry of medications
	uint refills_taken;

	// Prescription state
	uint constant CREATED          = 0;   
	uint constant SIGNED           = 1;    
	uint constant SUBMITTED        = 2; 
	uint constant REFILL_REQUESTED = 3;
	uint constant FILLED           = 4;    
	uint constant EXPIRED          = 5;   
	uint constant ERROR            = 6;     
	uint rxstate;

	uint constant MAX_REFILLS = 3;


    // Define events
    event OnDeployed(address indexed deployed);

    event maxRefillsReached();


	// Constructor function
	function ARX_Prescription() {

        creator 		= msg.sender;
        doctor 			= msg.sender;
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


// Prescription state 

	function signRx() {
		if (msg.sender == doctor) {
			rxstate = SIGNED;
		}
	}

	function submitRx() {
		if (msg.sender == patient) {
			rxstate = SUBMITTED;
		}
	}

	function reqRefillRx() {
		if (msg.sender == patient) {
			rxstate = REFILL_REQUESTED;
		}
	}

	function fillRx() {
		if (msg.sender == pharmacy) {

			if (refills_taken == MAX_REFILLS-1) {
		    	refills_taken = MAX_REFILLS;
		    	rxstate = EXPIRED;
        		maxRefillsReached();
        	}
        	else if (refills_taken < MAX_REFILLS) {
        		refills_taken = refills_taken + 1;
        		rxstate = FILLED;
        	}
		}
	}

	function getPrescriptionState() returns(uint) {
		return rxstate;
	}



// Medication 

	function setMedicationID(uint num) {
		if (msg.sender == doctor) {
			medication_id = num;
		}
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
	


// Stakeholders

	function setPatient(address addr) {
		if (msg.sender == doctor) {
			patient = addr;
		}
	}
	
	function getPatient() returns(address) {
		return patient;
	}

	function setDoctor(address addr) {
		if (msg.sender == doctor) {
			doctor = addr;
		}
	}
	
	function getDoctor() returns(address) {
		return doctor;
	}

	function setPharmacy(address addr) {
		if (msg.sender == patient) {
			pharmacy = addr;
		}
	}
	
	function getPharmacy() returns(address) {
		return pharmacy;
	}

	function getCreator() returns(address) {
		return creator;
	}
	
}




