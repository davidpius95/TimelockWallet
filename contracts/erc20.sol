
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor() ERC20("CakeToken", "CKT") {
        _mint(msg.sender, 10000*10**18);
    }
}