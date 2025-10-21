// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IClassManager {
    function isClassExist(string memory _name) external view returns (bool);
    function getClassLevel(string memory _name) external view returns (string memory);
    function getStudentLimit(string memory _name) external view returns (uint, uint);
    function incrementStudent(string memory _name) external;
    function decrementStudent(string memory _name) external;
}

contract StudentManager {
    struct Student {
        uint id;
        string name;
        string className;
        string level;
        uint age;
        uint totalGirlFriends;
    }
    IClassManager public classContract;
    mapping(uint => Student) public students;
    uint public studentCount;

    constructor(address _classContractAddress) {
        classContract = IClassManager(_classContractAddress);
    }

    function addStudent(string memory _name, string memory _className, uint _age,uint _totalGirlFriends) public {
        require(classContract.isClassExist(_className), "Class does not exist");

        (uint current, uint limit) = classContract.getStudentLimit(_className);
        require(current < limit, "Class is full");

        string memory level = classContract.getClassLevel(_className);

        students[studentCount] = Student(studentCount, _name, _className, level, _age,_totalGirlFriends);
        classContract.incrementStudent(_className);
        studentCount++;
    }
    function getStudent(uint _id) public view returns (Student memory) {
        return students[_id];
    }

    function countCurLimit(string memory _className) public view returns (uint,uint){
        return classContract.getStudentLimit(_className);
    }
    function removeStudent(string memory _className,uint _id) public {
        require(classContract.isClassExist(_className), "Class does not exist"); 
        require(bytes(students[_id].name).length !=0, "Student does not exist");
        delete students[_id];
        studentCount--;
        classContract.decrementStudent(_className);
    }
    
}