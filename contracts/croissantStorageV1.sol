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
        uint usedToken;
        uint numGuest;
    }

    mapping (uint256 => spaceTupple) public spaceInfo; 

    mapping(address => userInfo) users;

    event checkedIn(address indexed _who, uint _spaceId);

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
        UserInfo user = UserInfo(block.timestamp,8,0,0);
        users[msg.sender] = user;
        emit checkedIn(msg.sender , spaceIdCounter);
        numActiveCheckins++;
        available = (numSeats > numActiveCheckins ? true : false);
        returns spaceIdCounter;
    }

    function spaceUsedTimeCalculator(uint256 entryTime) private view returns(uint256){
        return (block.timestamp-entryTime)/(3600);
    }

    function checkOut(spaceTupple memory info) external returns(bool){
        spaceIdCounter = spaceIdCounter - 1;
        // calculate tokens fees
        spaceUsedTime =spaceUsedTimeCalculator(users[msg.sender].entryTime);
        // transfer remaining into info.spaceAssignedTo address
        // emit event 
        // delete space id then return true
    }

    function addGuest(uint256 _spaceId, address _guestAddress) external returns(bool){
        // add guest address into info.guestlist array.
        // emit event and return true
    }

    function removeGuest(uint256 _spaceId, address _guestAddress) external returns(bool){
        // remove guest address into info.guestlist array.
        // emit event and return true
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
