// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//Quản lý danh sách ứng cử viên và người dùng tham gia bỏ phiếu, mỗi người chỉ được bầu 1 lần.

contract UserManager{
    struct User{
        uint id;
        string name;
        // uint idCandidate;
        address userAddress;
        bool isVote;
    }
    mapping(uint => User) public users;
    uint8 public userCount = 0;
    function addUser(uint _id, string memory _name, bool isVote) public {
        require(users[_id].userAddress == address(0), "User id already exists");
        users[_id] = User(_id, _name, msg.sender, false);
        userCount++;
    }
    function getUserCount() public view returns (uint8) {
        return userCount;
    }
    function getUserById(uint _id) public view returns (User memory) {
        return users[_id];
    }
    //Bỏ phiếu cho ứng viên.
    function voteCandidate(uint _idCandidate) public {
        require(users[_idCandidate].isVote == true, "User has voted");
        users[_idCandidate].isVote = false;
    }
    //Kiểm tra user đã chọn ai.
    

}