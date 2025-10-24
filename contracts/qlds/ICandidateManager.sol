// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICandidateManager {
    function isCandidateExist(string memory _name) external view returns (bool);
    function vote(string memory _name) external;
}
contract UserManager{
    struct User{
        uint id;
        string name;
        string nameCandidate;
        address userAddress;
        bool isVote;
    }

    mapping(uint => User) public users;
    uint public userCount = 0;
    ICandidateManager public candidateContract;

    constructor(address _candidateContractAddress) {
        candidateContract = ICandidateManager(_candidateContractAddress);
    }

    function addVoter(uint _id, string memory _name, string memory _nameCandidate) public {
        require(users[_id].userAddress == address(0), "User id already exists");
        require(candidateContract.isCandidateExist(_nameCandidate), "Candidate does not exist");
        users[_id] = User(_id, _name, _nameCandidate, msg.sender, true);
        candidateContract.vote(_nameCandidate);
        userCount++;
    }

    function getUserCount() public view returns (uint) {
        return userCount;
    }

    function getUserById(uint _id) public view returns (User memory) {
        return users[_id];
    }

    function getUserVote(uint _id) public view returns(string memory) {
        require(bytes(users[_id].nameCandidate).length != 0, "User has not voted yet");
        return users[_id].nameCandidate;
    }
    

}