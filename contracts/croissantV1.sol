// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./croissantStorageV1.sol";

contract CroissantV1 is CroissantStorageV1{

    function initialize() public initializer {
        __ERC20_init("Croissants", "CRS");
        __Ownable_init();
        _totalSupply = 200000000000000000000000;
        _balances[msg.sender] = _totalSupply;
        hourlyRate = 1000000000000000000;
        spaceIdCounter = 0;
        numSeats = 8;
        dataURI = "";
    }


    function setHourlyRate(uint256 _rate) external returns(bool){
        hourlyRate = _rate;
        return true;
    }

    function addSeat(uint256 _numSeats) external onlyManager returns(bool) {
        numSeats += _numSeats;
        return true;
    }

    function removeSeat(uint256 _numSeats) external onlyManager returns(bool) {
        assert(numSeats -= _numSeats < numSeats,"remove less seats");
        numSeats -= _numSeats;
        return true;
    }


    function addManager(address _manager) external onlyOwner returns(bool){
        Manager.push(_manager);
        return true;
    }

    function removeManager(address _manager) external onlyOwner returns(bool){
        for(uint i = 0; i < Manager.length; i++ ){
            if(Manager[i] == _manager){
                delete Manager[i];
            }
        }
        return true;
    }

    function toggleAvailable() external onlyManager returns(bool){
        available = !available;
    }
    
    function update() external onlyOwner returns(bool){
        // updates the checkins and checkouts
        // return true
    }

    function setDataURI(string memory _uri) external onlyOwner returns(bool){
        dataURI=_uri;// set new uri and return true
        return true;
    }

    function withdraw() external onlyOwner returns(bool){
        // transfer all smart contract tokens to owner
        // return true
    }

}
