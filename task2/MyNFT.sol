// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 导入OpenZeppelin的安全合约库
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";        // ERC721标准实现
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; // 支持每个代币独立URI
import "@openzeppelin/contracts/access/Ownable.sol";            // 权限控制：仅所有者可执行敏感操作

/**
 * @title MyNFT
 * @dev 基于ERC721和ERC721URIStorage的NFT合约，支持元数据绑定和权限控制
 */
contract MyNFT is ERC721, ERC721URIStorage, Ownable {
    // 状态变量：下一个可用的tokenId（自动递增）
    uint256 private _nextTokenId;

    /**
     * @dev 构造函数初始化NFT名称和符号
     * @param initialOwner 合约部署者地址，自动成为所有者
     */
    constructor(address initialOwner) 
        ERC721("MyNFT", "MNFT")               // 设置NFT名称"MyNFT"，符号"MNFT"
        Ownable(initialOwner)                 // 设置合约所有者
    {}

    /**
     * @dev 铸造新NFT并关联元数据（仅合约所有者可调用）
     * @param recipient NFT接收者地址
     * @param uri 元数据IPFS链接
     */
    function mintNFT(address recipient, string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId;       // 获取当前tokenId
        _nextTokenId++;                       // 递增计数器，为下次铸造准备
        _safeMint(recipient, tokenId);        // 安全铸造（检查接收方是否为合约）
        _setTokenURI(tokenId, uri);           // 关联元数据URI到tokenId
    }

    // ============== 重写ERC721URIStorage必要函数 ==============
    /**
     * @dev 查询指定tokenId的元数据URI
     * @param tokenId 代币ID
     * @return 元数据URI字符串
     */
    function tokenURI(uint256 tokenId) 
        public 
        view 
        override(ERC721, ERC721URIStorage)   // 明确指定重写来源
        returns (string memory) 
    {
        return super.tokenURI(tokenId);       // 调用父类实现
    }

    /**
     * @dev 支持接口检测（ERC165标准）
     * @param interfaceId 接口ID字节码
     * @return 是否支持该接口
     */
    function supportsInterface(bytes4 interfaceId) 
        public 
        view 
        override(ERC721, ERC721URIStorage)   // 多重继承需明确重写
        returns (bool) 
    {
        return super.supportsInterface(interfaceId);
    }
}
//etherscan:
//https://sepolia.etherscan.io/tx/0xab144df71309668cccd73942cc35072800dc473c934f4948001b764a8e935bf9
//https://sepolia.etherscan.io/tx/0x396c1d68593bdd4b030401fc6b11c1f89bb228ce49fda4cc639c6e06409255c5