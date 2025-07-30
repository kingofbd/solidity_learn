// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract HelloWorld {
    string private hello = "hello";

    function setHello(string memory str) external {
        hello = str;
    }

    function sayHello () external view returns (string memory){
        return hello;
    }
}