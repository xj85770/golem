// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reputation {
    // Define an admin role for access control
    address public admin;

    // Mapping for user reputations
    mapping(address => uint256) public reputationScores;

    // Struct for feedback
    struct Feedback {
        uint256 score;
        string comment;
        address reviewer;
    }

    // Mapping to hold feedbacks for each user
    mapping(address => Feedback[]) public feedbacks;

    // Event logs for changes in reputation
    event ReputationUpdated(address indexed user, uint256 newScore, address indexed updater);
    event FeedbackAdded(address indexed user, uint256 score, string comment, address indexed reviewer);

    constructor() {
        // Set the deployer as the admin
        admin = msg.sender;
    }

    // Modifier to restrict actions to only admin
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    // Function to set reputation score
    function setReputation(address user, uint256 score) public onlyAdmin {
        require(score <= 100, "Score must be between 0 and 100");
        reputationScores[user] = score;
        emit ReputationUpdated(user, score, msg.sender);
    }

    // Function to add feedback
    function addFeedback(address user, uint256 score, string memory comment) public {
        require(score <= 100, "Score must be between 0 and 100");
        Feedback memory newFeedback = Feedback(score, comment, msg.sender);
        feedbacks[user].push(newFeedback);
        emit FeedbackAdded(user, score, comment, msg.sender);
    }

    // Function to get reputation score
    function getReputation(address user) public view returns (uint256) {
        return reputationScores[user];
    }

    // Function to get all feedback for a user
    function getFeedbacks(address user) public view returns (Feedback[] memory) {
        return feedbacks[user];
    }

    // Admin can update the contract admin
    function changeAdmin(address newAdmin) public onlyAdmin {
        admin = newAdmin;
    }

    // Function to handle disputes (placeholder for simplicity)
    function resolveDispute(address user, string memory reason) public onlyAdmin {
        // Dispute resolution logic here
    }
}
