pragma solidity ^0.5.0;

// lvl 1: equal split
contract AssociateProfitSplitter {

    address public owner;

    // Three payable addresses representing `employee_one`, `employee_two` and `employee_three`.
    address payable public employee_one;
    address payable public employee_two;
    address payable public employee_three;

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;

        owner = msg.sender;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        require(msg.sender == owner);

        // Split `msg.value` into three
        uint amount = msg.value/3; // Your code here!

        // Transfer the amount to each employee
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);

        // take care of a potential remainder by sending back to HR (`msg.sender`)
        msg.sender.transfer(msg.value - amount * 3);
    }

    function() external payable {
        // Enforce that the `deposit` function is called in the fallback function!
        deposit();
    }
}