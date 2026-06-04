// SPDX-License-Identifier: MIT

pragma solidity 0.8.35;

import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract StakingAppv1 is Ownable{
    address public stakingToken;
    address public admin;

    constructor(address stakingToken_, address admin_) Ownable(admin_) {
        stakingToken = stakingToken_;
        admin = admin_;
    }

}