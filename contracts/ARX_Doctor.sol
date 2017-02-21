pragma solidity ^0.4.2;

import "ConvertLib.sol";

/*
	Doctor - 
   		name, 
   		address, 
   		prescriptions signed
*/


contract ARX_Doctor {

// -------- Old stuff -------------------------------------------------------//
	mapping (address => uint) balances;
// -------- Old stuff -------------------------------------------------------//


// Contract state 
	enum PrescriptionState { Created, Signed, Submitted, Filled, Expired, Error }

	PrescriptionState rxstate;
	PrescriptionState constant default_rxstate = PrescriptionState.Created;


// Constructor function
	function ARX_Doctor() {
		balances[tx.origin] = 10000;

	}


// Contract state functions

	function setPrescriptionState(PrescriptionState state) returns(bool) {
		rxstate = state;
        return true;
	}
	
	function getPrescriptionState() returns(PrescriptionState) {
		return rxstate;
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

