// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract BinarySearch {
    
    function binarySearch(
        uint256[] memory arr,
        uint256 target
    ) public pure returns (uint256) {
        // 初始化左右边界指针[4,9](@ref)
        uint256 left = 0;
        uint256 right = arr.length;

        // 二分查找核心循环
        while (left < right) {
            // 计算中间索引（防止整数溢出）
            uint256 mid = left + (right - left) / 2;
            
            // 找到目标值直接返回索引
            if (arr[mid] == target) {
                return mid;
            }
            
            // 调整搜索范围
            if (arr[mid] < target) {
                left = mid + 1;  // 目标值在右半区
            } else {
                right = mid;     // 目标值在左半区
            }
        }
        
        // 未找到目标值
        return type(uint256).max;
    }
}