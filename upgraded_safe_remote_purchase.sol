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
        Released,
        Finished,
        Inactive
    }

    State public state; // The state variable has a default value of the first member, `State.created`

    modifier condition(bool condition_) {
        require(condition_);
        _;
    }

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

    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();
    event SellerReset();
    event SellerReleased();

    // Saves the address of the seller.
    constructor() payable {
        seller = payable(msg.sender);
    }

    // Establishes the cost of the product being sold.
    // Ensure that `msg.value` is an even number.
    // Division will truncate if it is an odd number.
    // Check via multiplication that it wasn't an odd number.
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
        state = State.Ready;
    }

    // Confirm the purchase as buyer.
    // Transaction has to include `2 * value` ether.
    // The ether will be locked until confirmReceived
    // is called.
    function confirmPurchase()
        external
        payable
        inState(State.Created)
        condition(msg.value == (2 * value))
    {
        // State Change.
        emit PurchaseConfirmed();
        buyer = payable(msg.sender);
        lockTimeStamp = block.timestamp + 7 days;
        state = State.Locked;
    }

    // Confirm that you (the buyer) received the item.
    // This will release the locked ether.
    function confirmReceived() external onlyBuyer {
        // Conditions.
        if (!((state == State.Locked) || (state == State.Released)))
            revert InvalidState();

        // State Change.
        emit ItemReceived();
        state = State.Finished;

        // Actions.
        buyer.transfer(value);
    }

    // Releases escrow if customer does not
    // confirm goods' receipt.
    function releaseEscrow()
        external
        onlySeller
        inState(State.Locked)
        condition(block.timestamp > lockTimeStamp)
    {
        // State Change.
        emit SellerReleased();
        state = State.Released;

        // Actions.
        seller.transfer(2 * value);
    }

    // Resets the contract and reclaims the ether.
    // Can only be called by the seller before
    // the contract is locked or after it has
    // been unlocked.
    function resetContract() external onlySeller {
        // Conditions.
        if (!((state == State.Ready) || (state == State.Finished)))
            revert InvalidState();

        // State Change.
        emit SellerReset();
        state = State.Created;

        // Actions.
        seller.transfer(address(this).balance);
    }

    // Makes the contract inactive.
    function abortContract() external onlySeller inState(State.Created) {
        // State Change.
        emit Aborted();
        state = State.Inactive;
    }
}
