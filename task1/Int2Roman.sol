// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Int2Roman {
    function intToRoman(uint256 num) public pure returns (string memory) {
        require(num >= 1 && num <= 3999, "Range: 1-3999");
        
        // 数值-符号映射表（显式声明为 uint256[13]）
        uint256[13] memory values = [
            uint256(1000), 900, 500, 400, 
            100, 90, 50, 40,
            10, 9, 5, 4, 1
        ];
        
        // 修复：使用 bytes 类型存储符号（非固定长度）
        bytes[] memory symbols = new bytes[](13);
        symbols[0] = "M";
        symbols[1] = "CM";
        symbols[2] = "D";
        symbols[3] = "CD";
        symbols[4] = "C";
        symbols[5] = "XC";
        symbols[6] = "L";
        symbols[7] = "XL";
        symbols[8] = "X";
        symbols[9] = "IX";
        symbols[10] = "V";
        symbols[11] = "IV";
        symbols[12] = "I";

        bytes memory roman;
        for (uint i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                // 直接拼接字节数组
                roman = abi.encodePacked(roman, symbols[i]);
                num -= values[i];
            }
        }
        return string(roman);
    }
}