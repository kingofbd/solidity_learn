// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract Roman2Int {

    // 实现罗马数字转数整数
    // 主转换函数：将罗马数字字符串转换为整数
    function romanToInt(string memory s) public pure returns (uint256) {
        // 将字符串转为字节数组以便处理
        bytes memory romanBytes = bytes(s);
        uint256 length = romanBytes.length;
        uint256 total = 0;
        
        // 遍历每个字符
        for (uint256 i = 0; i < length; i++) {
            uint256 currentVal = _charValue(romanBytes[i]);
            
            // 检查下一个字符是否存在且比当前值大（减法规则）
            if (i + 1 < length) {
                uint256 nextVal = _charValue(romanBytes[i + 1]);
                if (currentVal < nextVal) {
                    total += (nextVal - currentVal);
                    i++; // 跳过下一个字符（已处理复合符号）
                    continue;
                }
            }
            total += currentVal;
        }
        return total;
    }

    // 内部函数：罗马字符到数值的映射
    function _charValue(bytes1 c) private pure returns (uint256) {
        // 使用高效的内存比较
        if (c == 'I') return 1;
        if (c == 'V') return 5;
        if (c == 'X') return 10;
        if (c == 'L') return 50;
        if (c == 'C') return 100;
        if (c == 'D') return 500;
        if (c == 'M') return 1000;
        return 0; // 无效字符默认返回0
    }
}