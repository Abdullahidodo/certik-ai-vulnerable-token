// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
    TEST CONTRACT ONLY
    Intentionally contains security weaknesses
    for AI audit demonstrations.
*/

contract VulnerableToken {

    string public name = "CertiK Demo Token";
    string public symbol = "CDT";
    uint8 public decimals = 18;

    uint256 public totalSupply = 1000000 * 10**18;

    mapping(address => uint256) public balanceOf;

    address public owner;

    constructor() {
        owner = msg.sender;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to,uint256 amount) public returns(bool){

        require(balanceOf[msg.sender] >= amount);

        balanceOf[msg.sender] -= amount;

        balanceOf[to] += amount;

        return true;
    }

    // Missing access control
    function mint(uint256 amount) public {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
    }

    // Anyone can burn anyone's tokens
    function burn(address user,uint256 amount) public {
        balanceOf[user] -= amount;
        totalSupply -= amount;
    }

    // Dangerous ownership transfer
    function changeOwner(address newOwner) public {
        owner = newOwner;
    }

    // Unsafe withdrawal
    function withdrawAll() public {

        payable(msg.sender).call{
            value: address(this).balance
        }("");

    }

    receive() external payable {}
}
