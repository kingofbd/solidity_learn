// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/access/Ownable.sol";

// 讨饭合约
/**
//部署到测试sepolia的合约地址：0x92f05c60a0c3c3231f93e37c7d6144aa8492c107
//etherscan:
//https://sepolia.etherscan.io/tx/0xeedbaa4aebd238c246c3e7121c52b3e84e4c654d4c9e6fde304ce4e8f971e372
//测试过程在remix上，截图见同目录image中的图片
*/
contract BeggingContract is Ownable {

    // 记录每个捐赠者的金额
    mapping (address => uint256) private donations;

    // 事件，记录捐赠和提款的行为
    event Donation(address indexed donor, uint256 amount);
    event Withdrawn(address indexed owner, uint256 amount);

    // 构造函数，声明合约所有者
    constructor() Ownable(msg.sender) {}

    // 捐赠方法
    function donate() external payable {
        // 捐赠数量必须大于0
        require(msg.value > 0, "Donation must be > 0");
        // 更新捐赠记录
        donations[msg.sender] += msg.value;
        // 触发事件记录日志
        emit Donation(msg.sender, msg.value);
    }

    // 提款方法，仅合约所有者可以调用
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        // 合约中的资金必须大于0才能提款
        require(balance > 0, "Contract has no balance");
        // 将合约中的所有资金转移到所有者地址
        payable(owner()).transfer(balance);
        // 触发事件记录日志
        emit Withdrawn(owner(), balance);
    }

    // 查看某个捐赠者的金额
    function getDonation(address addr) external view returns (uint256) {
        return donations[addr];
    }
}