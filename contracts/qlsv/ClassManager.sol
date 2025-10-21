// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClassManager {
    struct Class {
        string name;
        string level; // 1st, 2nd, 3th
        uint maxStudents;
        uint currentStudents;
    }

    mapping(string => Class) public classes;

    function addClass(string memory _name, string memory _level, uint _maxStudents) public {
        classes[_name] = Class(_name, _level, _maxStudents, 0);
    }

    function isClassExist(string memory _name) public view returns (bool) {
        return bytes(classes[_name].name).length != 0;
    }
    
    function getClassLevel(string memory _name) public view returns (string memory) {
        return classes[_name].level;
    }

    function getStudentLimit(string memory _name) public view returns (uint, uint) {
        return (classes[_name].currentStudents, classes[_name].maxStudents);
    }

    function incrementStudent(string memory _name) public {
        classes[_name].currentStudents++;
    }
    function decrementStudent(string memory _name) public {
        classes[_name].currentStudents--;
    }

   
}