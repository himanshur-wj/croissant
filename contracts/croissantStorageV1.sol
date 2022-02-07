// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract CroissantStorageV1 is ERC20Upgradeable, OwnableUpgradeable {

    uint256 public hourlyRate;

    uint256 public spaceIdCounter;

    uint256 public numSeats;

    address[] public Manager;

    uint256 public numActiveCheckins;

    string public dataURI;

    bool public available;

    struct spaceTupple {
        uint256 spaceId;
        address spaceAssignedTo;
        uint256 startTime;
        uint256 totalMeetHours;
        address[] guestList;
        uint256 totalRate;
    }

    struct userInfo {
        uint entryTime;
        uint depositToken;
        uint[] guest;
    }

    mapping (uint256 => spaceTupple) public spaceInfo; 

    mapping(address => userInfo) users;

    event CheckedIn(address indexed _who, uint256 _spaceId);
    event TokenReturned(address indexed _to, uint256 _amountReturn);
    event GuestAdded(address indexed _who, uint _amountPaid)



    modifier onlyHourlyRate(uint256 _rate){
        require((hourlyRate*8) == _rate, "Rate is incorrect");
        _;
    }

    modifier onlyManager(){
        bool status;
        for(uint i = 0; i < Manager.length; i++ ){
            if(Manager[i] == msg.sender){
                status = true;
            }
        }
        require(status == true, "You are not Manager");
        _;
    }



    function checkIn(spaceTupple memory info) external onlyHourlyRate(info.totalRate) returns(uint256){
        spaceIdCounter = spaceIdCounter + 1;
        require(msg.value == (hourlyRate*8), "Please send accurate Token");
        users[msg.sender].entryTime = block.timestamp;
        users[msg.sender].depositToken = 8;
        emit CheckedIn(msg.sender , spaceIdCounter);
        numActiveCheckins++;
        available = (numSeats > numActiveCheckins ? true : false);
        returns spaceIdCounter;
    }

    function spaceUsedTimeCalculator(uint256 entryTime) private view returns(uint256){
        return (block.timestamp-entryTime)/(3600);
    }

    function checkOut(spaceTupple memory info) external returns(bool){
        spaceIdCounter = spaceIdCounter - 1;
        uint256 spaceUsedTime =spaceUsedTimeCalculator(users[msg.sender].entryTime);
        for(uint i = 0; i < users[msg.sender].guest.length; i++ ){
            if(users[msg.sender].guest[i] != 0){
                spaceUsedTime += spaceUsedTimeCalculator(users[msg.sender].guest[i]);
            }
        }
        uint256 returnValue = (users[msg.sender].depositToken - spaceUsedTime)*hourlyRate
        payable(msg.sender).transfer(returnValue);
        numActiveCheckins -= users[msg.sender].guest.length + 1;
        delete users[msg.sender];
        available = true;
        emit TokenReturned(msg.sender , returnValue); 
        return true;
    }

    function addGuest() external returns(bool){
        // we should also add many guests at a single call...
        uint256 spaceUsedTime = spaceUsedTimeCalculator(users[msg.sender].entryTime);
        require(msg.value == (hourlyRate*(8-spaceUsedTime)), "Please send accurate Token");
        numActiveCheckins++;
        available = (numSeats > numActiveCheckins ? true : false);
        emit GuestAdded(msg.sender, block.timestamp);
    }

    function removeGuest(uint256 index) external returns(bool){
        uint256 entryTime = spaceUsedTimeCalculator(users[msg.sender].guest[index]);
        uint256 exitTime = spaceUsedTimeCalculator(users[msg.sender].entryTime);
        payable(msg.sender).transfer((8-(exitTime-entryTime))*hourlyRate);
        delete users[msg.sender].guest[index];
        numActiveCheckins--;
        active = true;
        return true;
    }

    function holdSeat(uint256 _spaceId) external returns(bool){
        // check the msg.sender in guestlist
        // hold for 1 hour and update mapping address with 
        // returns true
    }

    function cancelHold(uint256 _spaceId) external returns(bool){
        // check the msg.sender in guestlist and see if the person is already set on hold or not
        // returns true
    }

    function activeCheckIns() external returns(uint256[] memory){
        // checks the space Id are active and return the array
    }

}
