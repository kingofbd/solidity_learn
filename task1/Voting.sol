// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Voting {
    // 一个mapping来存储候选人的得票数
    mapping(string => uint256) public candidateVotes;
    // 保存所有的候选人列表
    string[] public candidateList;

    // 一个vote函数，允许用户投票给某个候选人
    function vote(string memory user) external  {
        uint256 votes = candidateVotes[user];
        if (votes == 0) {
            // 记录候选人
            candidateList.push(user);
        }
        votes++;
        candidateVotes[user] = votes;
    }

    // 一个getVotes函数，返回某个候选人的得票数
    function getVotes(string memory user) external view returns (uint) {
        return candidateVotes[user];
    }

    // 一个resetVotes函数，重置所有候选人的得票数
    function resetVotes() external {
        for (uint i = 0; i < candidateList.length; i++) {
            candidateVotes[candidateList[i]] = 0;
        }
    }
}