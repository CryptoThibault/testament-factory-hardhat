// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Testament.sol";

contract TestamentFactory {
    mapping(address => bool) private _testamentOn;
    event DeployTestament(address indexed deployer, address doctor);

    function deployTestament(address doctor) public returns (bool) {
        require(!_testamentOn[msg.sender], "Sender have already a testament");
        _testamentOn[msg.sender] = true;
        new Testament(msg.sender, doctor);
        emit DeployTestament(msg.sender, doctor);
        return true;
    }
}
