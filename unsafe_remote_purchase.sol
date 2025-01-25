// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Purchase {
    address payable public seller;

    // Saves the address of the seller.
    constructor() payable {
        seller = payable(msg.sender);
    }

    // Purchases an item as a buyer.
    function purchase() external payable {
        seller.transfer(msg.value);
    }
}
