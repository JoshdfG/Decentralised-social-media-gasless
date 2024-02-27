// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ChainBattles.sol";
import "./Authentication.sol";

contract SocialMedia is ERC721, Ownable {
    address public contractOwner;

    // Define events for tracking actions
    event NFTCreated(uint256 tokenId, address owner);
    event CommentAdded(uint256 tokenId, address commenter, string comment);

    // Define data structures for storing user profiles, groups, and NFTs
    struct UserProfile {
        string username;
        string email;
    }

    struct Group {
        string groupName;
        string details;
    }

    // Mapping from token ID to NFT metadata
    mapping(uint256 => string) private _tokenURIs;

    // Mapping from user address to user profile
    mapping(address => UserProfile) private _userProfiles;

    // Mapping from group ID to group information
    mapping(uint256 => Group) private _groups;

    // Counter for generating unique token IDs
    uint256 private _tokenIdCounter;

    // Create an instance of the ChainBattles contract
    ChainBattles private _chainBattles;

    constructor() ERC721("SocialMediaNFT", "SMNFT") {
        // Initialize token ID counter
        _tokenIdCounter = 1;
        _chainBattles = new ChainBattles();
    }

    // Create a new NFT with a given token URI using ChainBattles
    function createNFT() external {
        // Mint a new token using ChainBattles
        _chainBattles.mint();

        emit NFTCreated(_tokenIdCounter, msg.sender);

        // Increment the token ID counter for uniqueness
        _tokenIdCounter++;
    }

    // Get the token URI for a given token ID using ChainBattles
    function getNFTTokenURI(
        uint256 _tokenId
    ) external view returns (string memory) {
        return _chainBattles.getTokenURI(_tokenId);
    }

    // Implement functions for creating and managing user profiles

    function setUserProfile(
        string memory _username,
        string memory _email
    ) external {
        _userProfiles[msg.sender].username = _username;
        _userProfiles[msg.sender].email = _email;
    }

    function getUserProfile()
        external
        view
        returns (string memory, string memory)
    {
        return (
            _userProfiles[msg.sender].username,
            _userProfiles[msg.sender].email
        );
    }

    function createGroup(
        uint256 _groupId,
        string memory _groupName,
        string memory _groupDetails
    ) external onlyOwner {
        _groups[_groupId] = Group(_groupName, _groupDetails);
    }

    function getGroup(
        uint256 _groupId
    ) external view returns (string memory, string memory) {
        return (_groups[_groupId].groupName, _groups[_groupId].details);
    }

    function commentOnNFT(uint256 _tokenId, string memory _comment) external {
        emit CommentAdded(_tokenId, msg.sender, _comment);
    }

    function transferChainBattlesOwnership(
        address _newOwner
    ) external onlyOwner {
        _chainBattles.transferOwnership(_newOwner);
    }
}
