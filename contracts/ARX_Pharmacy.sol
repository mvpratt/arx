
pragma solidity ^0.4.2;

import "ConvertLib.sol";


/* Other contracts / data structures

	Pharmacy - 
		name, 
		address, 
		inventory of medications, (internal array of strings)
		active prescriptions (links to contract addresses)

	Doctor - 
   		name, 
   		address, 
   		prescriptions signed

	Prescription - 
		doctor, 
		patient, 
		pharmacy, 
		medication, 
		refills allowed, 
		refills taken

	Patient - 
   		name, 
   		address, 
   		prescriptions owned
*/

/* Assumptions
	Inventory is binary - if a medication is in the inventory list, it's always in stock.  If its not in the list, it's never in stock
*/


/* TODO:

Create doctor contract
Doxygen - standard documentation.

Deploy on TestRPC
Deploy on GETH local net
Store patient data off chain (for privacy)
Restrict access to prescriptions:
     http://solidity.readthedocs.io/en/latest/common-patterns.html#restricting-access

Update website for new contract names
Add website static data
Add website interaction - separate tabs for pharmacy, patient, doctor

*/

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

