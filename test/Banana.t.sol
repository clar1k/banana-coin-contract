// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Banana} from "@/src/Banana.sol";

contract BananaTest is Test {
    Banana public banana;
    address alice = vm.addr(0x1323);
    address bob = vm.addr(0x2);

    function setUp() public {
        banana = new Banana();
    }

    function _mintAlice() private {
        vm.prank(alice);
        banana.mint(alice, 2e18);
    }

    function test_mintTokensAndTotalSupply() public {
        vm.startPrank(alice);
        /* 
            In this code block the 
            address will be that is in args,
            also tx.origin 
        */

        bool success = banana.mint(alice, 2e18);
        uint balance = banana.balanceOf(alice);
        uint totalSupply = banana.totalSupply();

        assertEq(success, true);
        assertEq(balance, 2e18);
        assertEq(totalSupply, 2e18);
        vm.stopPrank();
    }

    function test_transactionBetweenUsers() public {
        _mintAlice();
        vm.startPrank(alice);
        banana.transfer(bob, 2e18);
        assertEq(banana.balanceOf(alice), 0);
        assertEq(banana.balanceOf(bob), 2e18);
        vm.stopPrank();
    }

    function test_allowance_transferFrom() public {
        _mintAlice();

        vm.startPrank(alice);
        banana.approve(bob, 1e18);
        vm.stopPrank();

        vm.startPrank(bob);
        bool success = banana.transferFrom(alice, bob, 1e18);

        assertEq(success, true);
        assertEq(banana.balanceOf(bob), 1e18);
        assertEq(banana.allowance(alice, bob), 0);

        vm.stopPrank();
    }
}
