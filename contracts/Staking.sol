// stake: Lock tokens into our smart contract
// withdraw: unlock tokens and pull out of contract
// claimReward: users get their reward tokens
// What's some good reward math

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

error Staking__TransferFailed();

contract Staking {
    IERC20 public s_stakingToken;

    // address mapped to how much they staked
    mapping(address => uint256) public s_balances;

    uint256 public s_totalSupply;

    constructor(address stakingToken) {
        s_stakingToken = IERC20(stakingToken);
    }
    //do we allow any tokens? - not allow any token.
    //        Chainlink stuff to convert prices between tokens
    //or just a specific token? ✅
    function stake(uint256 amount) external {
        // keep track of how much this user has stakes
        // keep track of how much token we have total
        // transfer the tokens to this contract
        s_balances[msg.sender] = s_balances[msg.sender] + amount;
        s_totalSupply = s_totalSupply + amount;
        // emit event
        bool success = s_stakingToken.transferFrom(msg.sender, address(this), amount);
        // require(success, "Failed");
        // error handling
        if(!success) {
            revert Staking__TransferFailed();
        }
    }
}