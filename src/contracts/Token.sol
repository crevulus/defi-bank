// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    //add minter variable
    address minter; // address is a type in sol

    //add minter changed event
    event MinterChanged(address from, address to); // smart contracts have events that create logs. You can subscribe to these events from FE

    // needs to be public in order to deploy contract
    constructor() public payable ERC20("My Currency", "MC") {
        //asign initial minter
        minter = msg.sender; // msg is a global property in sol
    }

    //Add pass minter role function
    function passMinterRole(address dBank) public returns (bool) {
        require(msg.sender == minter, "Error: Minter is not the sender"); // require = "only continue if x = true, else err msg"
        minter = dBank;

        emit MinterChanged(msg.sender, minter);
        return true;
    }

    function mint(address account, uint256 amount) public {
        //check if msg.sender have minter role
        require(msg.sender == minter, "Error: Minter is not the sender");
        _mint(account, amount); // _mint() supplied by ERC20 standard
    }
}
