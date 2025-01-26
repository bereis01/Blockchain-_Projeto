// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Purchase {
    uint256 public value;
    address payable public seller;
    address payable public buyer;

    uint256 public lockTimeStamp;

    enum State {
        Created,
        Ready,
        Locked,
        Finished,
        Inactive
    }
    State public state; // The state variable has a default value of the first member, `State.created`.

    error OnlyBuyer(); // Only the buyer can call this function.
    error OnlySeller(); // Only the seller can call this function.
    error InvalidState(); // The function cannot be called at the current state.
    error ValueNotEven(); // The provided value has to be even.

    modifier onlyBuyer() {
        if (msg.sender != buyer) revert OnlyBuyer();
        _;
    }

    modifier onlySeller() {
        if (msg.sender != seller) revert OnlySeller();
        _;
    }

    modifier inState(State state_) {
        if (state != state_) revert InvalidState();
        _;
    }

    event ContractReady();
    event PurchaseConfirmed();
    event ItemReceived();
    event ContractReset();
    event ContractInactivated();

    // Saves the address of the seller.
    constructor() payable {
        seller = payable(msg.sender);
    }

    // Establishes the cost of the product being sold.
    function prepareContract()
        external
        payable
        onlySeller
        inState(State.Created)
    {
        // Conditions.
        value = msg.value / 2;
        if ((2 * value) != msg.value) revert ValueNotEven();

        // State Change.
        emit ContractReady();
        state = State.Ready;
    }

    // Confirm the purchase as buyer.
    function confirmPurchase() external payable inState(State.Ready) {
        // Conditions
        require(msg.value == (2 * value));

        // State Change.
        emit PurchaseConfirmed();
        buyer = payable(msg.sender);
        lockTimeStamp = block.timestamp + 7 days;
        state = State.Locked;
    }

    // Confirm that the buyer received the item.
    function confirmReceived() external onlyBuyer inState(State.Locked) {
        // State Change.
        emit ItemReceived();
        state = State.Finished;

        // Actions.
        buyer.transfer(value);
    }

    // Releases escrow if customer does not confirm goods' receipt.
    // Makes the contract inactive.
    function abortContract() external onlySeller inState(State.Locked) {
        // Conditions.
        require(block.timestamp > lockTimeStamp);

        // State Change.
        emit ContractInactivated();
        state = State.Inactive;

        // Actions.
        buyer.transfer(value);
        seller.transfer(value);
    }

    // Resets the contract and reclaims the ether.
    function resetContract() external onlySeller {
        // Conditions.
        if (!((state == State.Ready) || (state == State.Finished)))
            revert InvalidState();

        // State Change.
        emit ContractReset();
        state = State.Created;
        buyer = payable(0);
        value = uint256(0);
        lockTimeStamp = uint256(0);

        // Actions.
        seller.transfer(address(this).balance);
    }

    // Makes the contract inactive.
    function inactivateContract() external onlySeller inState(State.Created) {
        // State Change.
        emit ContractInactivated();
        state = State.Inactive;
    }
}
