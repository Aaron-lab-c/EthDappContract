// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Profile{
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    struct profile{
        string username;
        string introduce;
        address useraddress; 
    }
    mapping(address => profile) public mapProfiles;
    function setUsername(string memory _Username) external returns(bool){
        mapProfiles[msg.sender].username = _Username;
        return true;
    }
    function setIntroduce(string memory _Introduce) external returns(bool){
        mapProfiles[msg.sender].introduce = _Introduce;
        return true;
    }
    function setUseraddress() external returns(bool){
        mapProfiles[msg.sender].useraddress = msg.sender;
        return true;
    }
}