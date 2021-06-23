// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Testament {
    mapping(address => uint256) private _balances;
    address private _owner;
    address private _doctor;
    bool private _died;

    event Donation(address indexed receiver, uint256 amount);
    event SetDoctor(address lastDoctor, address newDoctor);
    event SetDied(address owner, uint256 bequeath);
    event Withdrew(address indexed sender, uint256 amount);

    constructor(address owner_, address doctor_) {
        _owner = owner_;
        _doctor = doctor_;
        emit SetDoctor(address(0), doctor_);
    }

    modifier ownerOnly {
        require(msg.sender == _owner, "Testament: reserved to testament owner");
        _;
    }

    function donate(address to) public payable ownerOnly returns (bool) {
        require(to != msg.sender, "Testament: cannot donate to yourself");
        _balances[to] += msg.value;
        emit Donation(to, msg.value);
        return true;
    }

    function setDoctor(address doctor_) public ownerOnly returns (bool) {
        require(doctor_ != _owner, "Testament: cannot set yourself as doctor");
        emit SetDoctor(_doctor, doctor_);
        _doctor = doctor_;
        return true;
    }

    function setDied() public returns (bool) {
        require(msg.sender == _doctor, "Testament: reserved to testament doctor");
        _died = true;
        emit SetDied(_owner, address(this).balance);
        return true;
    }

    function withdraw() public returns (bool) {
        require(_died, "Testament: testament owner actually alive");
        uint256 amount = _balances[msg.sender];
        _balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit Withdrew(msg.sender, amount);
        return true;
    }

    function balance() public view returns (uint256) {
        return _balances[msg.sender];
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function doctor() public view ownerOnly returns (address) {
        return _doctor;
    }

    function died() public view returns (bool) {
        return _died;
    }
}
