// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Merge {
    
    function mergeSortedArrays(
        uint256[] memory a,
        uint256[] memory b
    ) public pure returns (uint256[] memory) {
        // 获取数组长度
        uint256 aLen = a.length;
        uint256 bLen = b.length;
        uint256 totalLen = aLen + bLen;
        
        // 创建结果数组（预分配内存空间）
        uint256[] memory result = new uint256[](totalLen);
        
        // 初始化双指针
        uint256 i = 0; // a数组指针
        uint256 j = 0; // b数组指针
        uint256 k = 0; // 结果数组指针

        // 双指针遍历合并
        while (i < aLen && j < bLen) {
            if (a[i] <= b[j]) {
                result[k] = a[i];
                i++;
            } else {
                result[k] = b[j];
                j++;
            }
            k++;
        }

        // 处理剩余元素
        while (i < aLen) {
            result[k] = a[i];
            i++;
            k++;
        }
        while (j < bLen) {
            result[k] = b[j];
            j++;
            k++;
        }

        return result;
    }
}