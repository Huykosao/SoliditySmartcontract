// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Quản lý danh sách ứng cử viên và người dùng tham gia bỏ phiếu, mỗi người chỉ được bầu 1 lần.
contract CandidateManager{
    struct Candidate {
        string name;
        uint voteCount;
    }
    mapping(string => Candidate) public candidates;
    uint8 public totalVotes = 0;
    uint public maxValue;
    string public nameTop;
    function addCandidate(string memory _name) public {
        require(!isCandidateExit(_name), "Candidate already exists");
        
        candidates[_name] = Candidate(_name,0);
    }
    function isCandidateExit(string memory _name) public view returns(bool) {
        return bytes(candidates[_name].name).length != 0;
    }
    function getCandidateInfo(string memory _name) public view returns(string memory,uint) {
        return (candidates[_name].name,candidates[_name].voteCount);
    }
    function vote(string memory _name) public {
        candidates[_name].voteCount++;
        addValue(_name);
        totalVotes++;
    }
    function getTotalVotes() public view returns(uint8){
        return totalVotes;
    }
    // lay maxValue so sanh voi voteCount neu be hon thi maxValue =  voteCount
    //Trả về danh sách ứng viên có nhiều phiếu nhất.
    function addValue(string memory _name) public {
        if(maxValue < candidates[_name].voteCount){
            maxValue = candidates[_name].voteCount;
            nameTop = _name;
        }

    }
    function getMaxValue() public view returns(string memory,uint){
        require(bytes(nameTop).length != 0, "No votes yet");
        return (nameTop,maxValue);
    }

    
}