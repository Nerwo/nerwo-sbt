// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script, console2} from "forge-std/Script.sol";
import {NerwoSBT} from "../src/NerwoSBT.sol";

contract NerwoSBTScript is Script {
    function setUp() public {}

    function run() public {
        console2.log(msg.sender);
        vm.startBroadcast();
        NerwoSBT sbt = new NerwoSBT();
        console2.log("NerwoSBT deployed to %s", address(sbt));
        vm.stopBroadcast();
    }
}
