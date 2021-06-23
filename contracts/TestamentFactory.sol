// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Testament.sol";

contract TestamentFactory {
    mapping(address => address) private _testamentAddress;
    event DeployTestament(address indexed deployer, address doctor);

    function testamentOf(address account) public view returns (address) {
        return _testamentAddress[account];
    }

    function deployTestament(address doctor) public returns (bool) {
        require(_testamentAddress[msg.sender] == address(0), "TestamentFactory: Sender already have a testament");
        require(msg.sender != doctor, "TestamentFactory: Sender cannot be also doctor");
        Testament testament = new Testament(msg.sender, doctor);
        _testamentAddress[msg.sender] = address(testament);
        emit DeployTestament(msg.sender, doctor);
        return true;
    }
}
