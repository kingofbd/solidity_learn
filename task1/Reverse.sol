// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Reverse {

    // 反转一个字符串
    function reverseStr(string memory str) external pure returns (string memory) {
        // 将字符串转成bytes
        bytes memory origin = bytes(str);
        uint256 len = origin.length;

        // 使用for循环进行对半交换
        for(uint256 i = 0; i < len / 2; i++){
            (origin[i], origin[len - 1 - i]) = (origin[len - 1 - i], origin[i]);
        }
        // 将bytes转成string
        return string(origin);
    }
}