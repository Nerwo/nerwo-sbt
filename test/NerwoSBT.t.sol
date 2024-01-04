// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console2} from "forge-std/Test.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {NerwoSBT} from "../src/NerwoSBT.sol";

contract NerwoSBTTest is Test {
    string private constant IPFS_URL =
        "ipfs://bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/wiki/Vincent_van_Gogh.html";

    NerwoSBT public sbt;

    function setUp() public {
        sbt = new NerwoSBT();
    }

    function test_Mint() public {
        address freelancer = makeAddr("freelancer");
        sbt.safeMint(freelancer, 42, IPFS_URL);
        assertEq(sbt.tokenURI(42), IPFS_URL);
    }

    function test_AlreadyMinted() public {
        address freelancer = makeAddr("freelancer");
        sbt.safeMint(freelancer, 42, IPFS_URL);

        // Transfer from address 0
        vm.expectRevert(NerwoSBT.SoulBoundToken.selector);
        sbt.safeMint(freelancer, 42, IPFS_URL);
    }

    function test_SoulBound() public {
        address freelancer = makeAddr("freelancer");
        sbt.safeMint(freelancer, 42, IPFS_URL);

        address buyer = makeAddr("buyer");
        vm.startPrank(freelancer);
        vm.expectRevert(NerwoSBT.SoulBoundToken.selector);
        sbt.safeTransferFrom(freelancer, buyer, 42);
        vm.stopPrank();
    }

    function test_MintNotOwner() public {
        address freelancer = makeAddr("freelancer");
        vm.startPrank(freelancer);
        vm.expectRevert(
            abi.encodeWithSelector(
                Ownable.OwnableUnauthorizedAccount.selector,
                freelancer
            )
        );
        sbt.safeMint(freelancer, 42, IPFS_URL);
        vm.stopPrank();
    }
}
