// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ChainBattles.sol";

contract ChainBattlesFactory {
    event ChainBattlesCreated(address indexed chainBattlesAddress);

    function createChainBattles() external {
        ChainBattles newChainBattles = new ChainBattles();
        emit ChainBattlesCreated(address(newChainBattles));
    }
}
