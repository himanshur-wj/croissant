// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./croissantStorageV2.sol";

contract CroissantV1 is CroissantStorageV2{


    function setHourlyRate(uint256 _rate) external returns(bool){
        hourlyRate = _rate;
        return true;
    }

    function addSeat(uint256 _numSeats) external onlyManager returns(bool) {
        // add the seats
        //return true
    }

    function removeSeat(uint256 _numSeats) external onlyManager returns(bool) {
        // remove the seats
        //return true
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

    function update() external onlyOwner returns(bool){
        // updates the checkins and checkouts
        // return true
    }

    function setDataURI(string memory _uri) external onlyOwner returns(bool){
        // set new uri and return true
    }

    function withdraw() external onlyOwner returns(bool){
        // transfer all smart contract tokens to owner
        // return true
    }

}
