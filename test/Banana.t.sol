// // SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Banana} from "../src/Banana.sol";

contract CounterTest is Test {
    Banana public banana;

    function setUp() public {
        banana = new Banana();
    }

    function test_Increment() public {}

    function test_Fuzz_SetNumber(uint256 x) public {}
}
