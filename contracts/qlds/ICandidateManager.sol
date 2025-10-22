// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICandidateManager {
    function isCandidateExit(string memory _name) external view returns (bool);
    function vote(string memory _name) external;
    function unVote(string memory _name) external;

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
    uint8 public userCount = 0;
    ICandidateManager public candidateContract;

    constructor(address _candidateContractAddress) {
        candidateContract = ICandidateManager(_candidateContractAddress);
    }

    function addUser(uint _id, string memory _name, string memory _nameCandidate) public {
        require(users[_id].userAddress == address(0), "User id already exists");
        require(candidateContract.isCandidateExit(_nameCandidate), "Candidate does not exist");
        users[_id] = User(_id, _name, _nameCandidate, msg.sender, false);

        voteCadidate(_id,_nameCandidate);
        userCount++;
    }
    function getUserCount() public view returns (uint8) {
        return userCount;
    }
    function getUserById(uint _id) public view returns (User memory) {
        return users[_id];
    }
    function voteCadidate(uint _id,string memory _nameCandidate) public {
        require(users[_id].isVote == false, "User has voted");
        users[_id].isVote = true;
        users[_id].nameCandidate = _nameCandidate;
        candidateContract.vote(_nameCandidate);
    }
    function unVoteCadidate(uint _id,string memory _nameCandidate) public {
        require(users[_id].isVote == true, "User has not voted yet");
        delete users[_id].nameCandidate;
        users[_id].isVote = false;
        candidateContract.unVote(_nameCandidate);
    }
    
    function getUserVote(uint _id) public view returns(string memory) {
        require(bytes(users[_id].nameCandidate).length != 0, "User has not voted yet");
        return users[_id].nameCandidate;
    }

}