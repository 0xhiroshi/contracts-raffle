// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Scripting tool
import {Script} from "../../lib/forge-std/src/Script.sol";
import "forge-std/console2.sol";
import {SimulationBase} from "./SimulationBase.sol";

// Core contracts
import {Raffle} from "../../contracts/Raffle.sol";
import {IRaffle} from "../../contracts/interfaces/IRaffle.sol";

import "forge-std/console2.sol";

contract CreateRaffleMainnet is Script, SimulationBase {
    function run() external view {
        IRaffle.PricingOption[5] memory pricingOptions;
        pricingOptions[0] = IRaffle.PricingOption({entriesCount: 1, price: 0.00125 ether});
        pricingOptions[1] = IRaffle.PricingOption({entriesCount: 20, price: 0.024 ether});
        pricingOptions[2] = IRaffle.PricingOption({entriesCount: 100, price: 0.11 ether});
        pricingOptions[3] = IRaffle.PricingOption({entriesCount: 500, price: 0.525 ether});
        pricingOptions[4] = IRaffle.PricingOption({entriesCount: 1_000, price: 0.98 ether});

        address punks = 0xb7F7F6C52F2e2fdb1963Eab30438024864c313F6;
        address kubz = 0xEb2dFC54EbaFcA8F50eFcc1e21A9D100b5AEb349;

        IRaffle.Prize[] memory prizes = new IRaffle.Prize[](12);

        prizes[0].prizeTier = 0;
        prizes[0].prizeType = IRaffle.TokenType.ERC721;
        prizes[0].prizeAddress = punks;
        prizes[0].prizeId = 7941;
        prizes[0].prizeAmount = 1;
        prizes[0].winnersCount = 1;

        for (uint256 i = 1; i < 11; i++) {
            prizes[i].prizeTier = 1;
            prizes[i].prizeType = IRaffle.TokenType.ERC721;
            prizes[i].prizeAddress = kubz;
            prizes[i].prizeAmount = 1;
            prizes[i].winnersCount = 1;
        }
        prizes[1].prizeId = 1971;
        prizes[2].prizeId = 2707;
        prizes[3].prizeId = 4094;
        prizes[4].prizeId = 5799;
        prizes[5].prizeId = 5994;
        prizes[6].prizeId = 6812;
        prizes[7].prizeId = 7617;
        prizes[8].prizeId = 7827;
        prizes[9].prizeId = 8104;
        prizes[10].prizeId = 8148;

        prizes[11].prizeTier = 2;
        prizes[11].prizeType = IRaffle.TokenType.ERC20;
        prizes[11].prizeAddress = 0xf4d2888d29D722226FafA5d9B24F9164c092421E;
        prizes[11].prizeId = 0;
        prizes[11].prizeAmount = 1_000e18;
        prizes[11].winnersCount = 99;

        console2.logBytes(
            abi.encodeCall(
                IRaffle.createRaffle,
                (
                    IRaffle.CreateRaffleCalldata({
                        cutoffTime: uint40(block.timestamp + 3 days + 2 hours + 10 minutes),
                        isMinimumEntriesFixed: true,
                        minimumEntries: 69_000,
                        maximumEntriesPerParticipant: 14_000,
                        protocolFeeBp: 0,
                        feeTokenAddress: address(0),
                        prizes: prizes,
                        pricingOptions: pricingOptions
                    })
                )
            )
        );
    }
}
