# StakingApp

[![GitHub Repository](https://img.shields.io/badge/github-noelialuz%2FStakingApp-blue?logo=github)](https://github.com/noelialuz/StakingApp)
[![Solidity](https://img.shields.io/badge/solidity-0.8.35-363636?logo=solidity&logoColor=white)](https://soliditylang.org/)
[![Foundry](https://img.shields.io/badge/foundry-forge-000000?logo=ethereum&logoColor=white)](https://getfoundry.sh/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)

**A Foundry-based ERC-20 staking application.** Users deposit a fixed amount of tokens, wait for a configurable period, and claim ETH rewards funded by the contract owner.

* Fixed-amount ERC-20 deposits with a single active stake per user.
* ETH reward claims after a configurable staking period.
* Owner-controlled funding via `receive()` and staking period updates via `Ownable`.
* [`SafeERC20`](https://docs.openzeppelin.com/contracts/api/token/erc20#SafeERC20) transfers and CEI pattern on withdrawals.
* Unit test suite covering deposit, withdraw, rewards, and access control flows.

## Overview

### Dependencies

| Dependency | Version | Purpose |
| :-- | :-- | :-- |
| [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) | `v5.6.1` | `ERC20`, `Ownable`, `SafeERC20` |
| [forge-std](https://github.com/foundry-rs/forge-std) | `v1.16.1` | Foundry testing utilities and cheatcodes |

Pinned versions are recorded in [`foundry.lock`](./foundry.lock).

### Installation

#### Prerequisites

Install [Foundry](https://book.getfoundry.sh/getting-started/installation):

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

#### Clone and install dependencies

```bash
git clone https://github.com/noelialuz/StakingApp.git
cd StakingApp
forge install
```

> [!WARNING]
> When installing OpenZeppelin via git, avoid tracking the `master` branch. Use tagged releases (for example `@v5.6.1`) so builds stay reproducible. See the [OpenZeppelin Foundry installation notes](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/README.md#foundry-git).

To install or update dependencies explicitly:

```bash
forge install foundry-rs/forge-std@v1.16.1
forge install OpenZeppelin/openzeppelin-contracts@v5.6.1
```

### Build and test

```bash
forge build
forge test
```

Format check (also enforced in CI when configured):

```bash
forge fmt --check
```

### Usage

Deploy `StakingToken` and `StakingApp`, then interact with the staking contract:

```solidity
pragma solidity 0.8.35;

import {StakingApp} from "./StakingApp.sol";
import {StakingToken} from "./StakingToken.sol";

// 1. Deploy StakingToken and StakingApp with constructor parameters.
// 2. Owner funds StakingApp with ETH (receive is restricted to owner).
// 3. User approves and deposits the fixed staking amount.
// 4. After stakingPeriod elapses, user calls claimRewards().
```

Example test flow with Foundry cheatcodes:

```solidity
stakingToken.mint(tokenAmount);
IERC20(stakingToken).approve(address(stakingApp), tokenAmount);
stakingApp.depositTokens(tokenAmount);

vm.warp(block.timestamp + stakingPeriod);
stakingApp.claimRewards();
```

## Repository structure

```bash
├── src/
│   ├── StakingApp.sol       # Staking logic: deposit, withdraw, claim rewards
│   ├── StakingAppv1.sol     # Draft / alternate implementation
│   └── StakingToken.sol     # Mintable ERC-20 used for staking
├── test/
│   ├── StakingAppTest.t.sol # StakingApp unit tests
│   └── StakingTokenTest.t.sol
├── lib/
│   ├── forge-std/           # Foundry standard library (submodule)
│   └── openzeppelin-contracts/
├── foundry.toml
└── foundry.lock
```

## Learn more

* [Foundry Book](https://book.getfoundry.sh/) — compilation, testing, and cheatcodes.
* [OpenZeppelin Contracts documentation](https://docs.openzeppelin.com/contracts) — ERC-20, access control, and `SafeERC20`.
* [OpenZeppelin Contracts repository](https://github.com/OpenZeppelin/openzeppelin-contracts) — dependency source and release tags.

## Security

This project is intended for learning and demonstration. It has not undergone a professional security audit.

Before using any code in production:

* Review staking, withdrawal, and reward logic in [`src/StakingApp.sol`](./src/StakingApp.sol).
* Run the full test suite with `forge test`.
* Keep dependencies on tagged releases and aligned with `foundry.lock`.

Smart contracts carry technical risk. Use this repository at your own responsibility.

## License

StakingApp is released under the [MIT License](https://opensource.org/licenses/MIT). See SPDX identifiers in the source files.
