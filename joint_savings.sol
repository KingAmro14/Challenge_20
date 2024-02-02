/*
Joint Savings Account
---------------------

To automate the creation of joint savings accounts, you will create a solidity smart contract that accepts two user addresses that are then able to control a joint savings account. Your smart contract will use ether management functions to implement various requirements from the financial institution to provide the features of the joint savings account.

The Starting file provided for this challenge contains a `pragma` for solidity version `5.0.0`.
You will do the following:

1. Create and work within a local blockchain development environment using the JavaScript VM provided by the Remix IDE.

2. Script and deploy a **JointSavings** smart contract.

3. Interact with your deployed smart contract to transfer and withdraw funds.

*/

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {
    // Define two variables of type `address payable` for the two accounts
    address payable public accountOne;
    address payable public accountTwo;

    // Define a variable of type `address public` for the last account to withdraw
    address public lastToWithdraw;

    // Define two variables of type `uint public` for the last withdraw amount and contract balance
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Define the withdraw function with amount and recipient as arguments
    function withdraw(uint amount, address payable recipient) public {
        // Check if recipient is one of the account holders
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // Check if there are sufficient funds in the contract
        require(address(this).balance >= amount, "Insufficient funds!");

        // Update lastToWithdraw if it's a different recipient
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer the amount to the recipient
        recipient.transfer(amount);

        // Update lastWithdrawAmount and contractBalance
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }

    // Define the deposit function as public and payable
    function deposit() public payable {
        // Update contractBalance to reflect the new balance after the deposit
        contractBalance = address(this).balance;
    }

    // Define setAccounts function to accept two address payable arguments
    function setAccounts(address payable account1, address payable account2) public {
        // Set the accountOne and accountTwo addresses
        accountOne = account1;
        accountTwo = account2;
    }

    // Define the fallback function to enable the contract to receive ether
    function() external payable {
        // Call the deposit function to handle the fallback deposit
        deposit();
    }
}

