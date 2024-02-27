// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract Authentication {
    using ECDSA for bytes32;

    address public admin;
    mapping(address => bool) public isAuthenticated;

    event UserAuthenticated(address indexed user);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    modifier onlyAuthenticated() {
        require(isAuthenticated[msg.sender], "Not authenticated");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    // Simulate user authentication by verifying a signed message
    function authenticateUser(
        bytes32 messageHash,
        bytes memory signature
    ) external {
        require(
            msg.sender == messageHash.recover(signature),
            "Invalid signature"
        );

        // Perform additional authentication checks if needed

        // Mark the user as authenticated
        isAuthenticated[msg.sender] = true;

        emit UserAuthenticated(msg.sender);
    }

    function deauthenticateUser(address userAddress) external onlyAdmin {
        // Perform user deauthentication logic here
        isAuthenticated[userAddress] = false;
    }
}
