// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract StudentManager {
    string public className = "CT3";
    struct Student {
        uint id;
        string name;
        uint age;
        address studentAddress;
        bool is_active;
    }
    mapping(uint => Student) public students;
    uint8 public CountStudent;
    function addStudent(uint _id, string memory _name, uint _age) public {
        require(students[_id].studentAddress == address(0), "Student id already exists");
        require(Older19(_age), "Ai em sorry!");
        students[_id] = Student(_id, _name, _age, msg.sender, true);
        CountStudent++;
    }
    function getStudent(uint _id) public view returns (string memory, uint, address) {
        Student memory s = students[_id];
        require(s.studentAddress != address(0), "Student id does not exist");
        require(s.is_active,"Student has ben Locked!!!");
        return (s.name, s.age, s.studentAddress);
    }

    function activeStudent(uint _id) public {
        Student memory s = students[_id];
        if (s.is_active == false){
            s.is_active = true;
        }
        else {
            s.is_active = false;
        }
        students[_id] = s;
    }

    function exists(uint _id) public view returns (bool) {
        return students[_id].studentAddress != address(0);
    }
    function removeStudent(uint _id) public {
        require(students[_id].studentAddress != address(0), "Student id does not exist");
        delete students[_id];
        CountStudent--;
    }
    function updateStudentAge(uint _id, uint _newAge) public {
        require(students[_id].studentAddress != address(0), "Student id does not exist");
        require(Older19(_newAge), "Sorry be bi");
        students[_id].age = _newAge;
    }
    function Older19(uint _age) public pure returns (bool) {
        return _age >= 19;
    }
    function ReturnTotal() public  view  returns (uint8){
        return CountStudent;
    }
    function CheckGas() public pure returns (bool)
    {
        if(5+5+5+5+5+5 > 30) {return true;}
        else {return false;}
    }
    function CheckGas2() public pure returns (bool)
    {
        if(5*6 > 30) {return true;}
        else {return false;}
    }
}