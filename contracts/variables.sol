// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4; 

contract Variables {
    string public name = "CryptoPunks";
    uint256 public numberOfNfts = 100;

    function setName(string memory newName) public view returns ( string memory ) {
        
    }

    event Log (bytes data);

    function getData() public {
        // emit Log(block);
        // emit Log(msg);
    }

    function getBlockDetails() public view returns (uint, address, uint, uint){
         return (block.number, block.coinbase, block.timestamp, block.gaslimit);
    }
    
    
}