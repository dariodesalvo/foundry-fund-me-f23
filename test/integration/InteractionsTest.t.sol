// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {console} from "forge-std/console.sol";
import {FundFundMe, WhitdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {

    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe  = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {

        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WhitdrawFundMe whitdrawFundMe = new WhitdrawFundMe();
        whitdrawFundMe.whitdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }

}