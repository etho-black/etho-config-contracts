// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EthoConfig {
    address public owner;
    address public operator;
    
    mapping(uint => string) public addressMapDescriptions;
    mapping(uint => address) public addressMap;
    uint public addressMapCounter;
    
    mapping(uint => string) public stringMapDescriptions;
    mapping(uint => string) public stringMap;
    uint public stringMapCounter;
    
    mapping(uint => string) public uintMapDescriptions;
    mapping(uint => uint) public uintMap;
    uint public uintMapCounter;
    
    
    
    modifier restricted {
        require(msg.sender == owner, "This function is restricted to owner");
        _;
    }
    
    modifier restrictedOperator {
        require(msg.sender == operator || msg.sender == owner, "This function is restricted to owner or operator");
        _;
    }
    
    event AddAddressEntry(address indexed addressAdded, string addressDescription, uint addressCounter);
    event AddStringEntry(string indexed stringAdded, string stringDescription, uint stringCounter);
    event AddUintEntry(uint indexed uintAdded, string uintDescription, uint uintCounter);
    event TransferOwnership(address indexed previousOwner, address indexed newOwner);
    event TransferOperator(address indexed previousOperator, address indexed newOperator);
    
    function addAddressEntry(address _address, string memory _description) public restrictedOperator {
        addressMap[addressMapCounter] = _address;
        addressMapDescriptions[addressMapCounter] = _description;
        addressMapCounter++;
        emit AddAddressEntry(_address, _description, addressMapCounter);
    }
    
    function addStringEntry(string memory _string, string memory _description) public restrictedOperator {
        stringMap[stringMapCounter] = _string;
        stringMapDescriptions[stringMapCounter] = _description;
        stringMapCounter++;
        emit AddStringEntry(_string, _description, stringMapCounter);
    }
    
    function addUintEntry(uint _uint, string memory _description) public restrictedOperator {
        uintMap[uintMapCounter] = _uint;
        uintMapDescriptions[uintMapCounter] = _description;
        uintMapCounter++;
        emit AddUintEntry(_uint, _description, uintMapCounter);
    }
    
    function transferOwnership(address _newOwner) public restricted {
        owner = _newOwner;
        emit TransferOwnership(owner, _newOwner);
    }
    
    function transferOperator(address _newOperator) public restricted {
        operator = _newOperator;
        emit TransferOperator(operator, _newOperator);
    }

    constructor() {
        owner = msg.sender;
        operator = msg.sender;
        addressMapCounter = 0;
        uintMapCounter = 0;
        uintMapCounter = 0;
    }
}
