pragma solidity ^0.4.2;

contract ARX_Prescription {


 // Pointers to Stakeholders Accounts / Contracts
    struct Stakeholders {
		address doctor;
		address patient; 
		address pharmacy;
    }
	
	Stakeholders my_stakeholders; 

// Contract state 
	enum PrescriptionState { Created, Signed, Submitted, Filled, Expired, Error }

	PrescriptionState rxstate;
	PrescriptionState constant default_rxstate = PrescriptionState.Created;

// Medication	
	uint medication_id;   // ID in a shared registry of medications
	uint refills_allowed;
	uint refills_taken;

// Constructor function
	function ARX_Prescription() {

		medication_id = 0;
		refills_allowed = 0;
		refills_taken = 0;
	}

// Contract state functions

	function setPrescriptionState(PrescriptionState state) returns(bool) {
		rxstate = state;
        return true;
	}
	
	function getPrescriptionState() returns(PrescriptionState) {
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
	function setPatientAddress(address addr) returns(bool) {
		my_stakeholders.patient = addr;
        return true;
	}
	
	function getPatientAddress() returns(address) {
		return my_stakeholders.patient;
	}

	function setDoctorAddress(address addr) returns(bool) {
		my_stakeholders.doctor = addr;
        return true;
	}
	
	function getDoctorAddress() returns(address) {
		return my_stakeholders.doctor;
	}

	function setPharmacyAddress(address addr) returns(bool) {
		my_stakeholders.pharmacy = addr;
        return true;
	}
	
	function getPharmacyAddress() returns(address) {
		return my_stakeholders.pharmacy;
	}
	
}

