// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 导入 OpenZeppelin 
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyERC20 is IERC20, Ownable {
    // 代币元数据
    string private _name;
    string private _symbol;
    uint8 private constant _decimals = 18;

    // 代币供应
    uint256 private _totalSupply;
    // 账户余额
    mapping(address => uint256) private _balances;
    // 授权信息
    mapping(address => mapping(address => uint256)) private _allowances;

    // 构造函数初始化代币
    constructor(string memory name_,string memory symbol_,uint256 initialSupply_) Ownable(msg.sender) {
        _name = name_;
        _symbol = symbol_;
        // 初始化供应量
        _mint(msg.sender, initialSupply_ * 10 ** decimals()); 
    }

    // ================ ERC20 标准接口实现 ================
    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    // 查询账户余额
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    // 转账
    function transfer(address to, uint256 value) public override returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    // 查询授权的代币余额
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    // 授权第三方使用代币（比如a授权b，动作是a发起的，那么这里的owner是a，spender是b）
    function approve(address spender, uint256 value) public override returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    // 使用授权转移代币（b经a授权后对a的账户做操作，动作是b发起的，那么这里的from是a，to是b）
    function transferFrom(address from, address to, uint256 value) public override returns (bool) {
        _spendAllowance(from, msg.sender, value);
        _transfer(from, to, value);
        return true;
    }

    // ================ 权限控制功能 ================
    // 仅所有者可调用的铸币函数
    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Invalid recipient");
        _mint(to, amount);
    }

    // ================ 内部核心逻辑 ================
    function _transfer(address from, address to, uint256 value) private {
        require(from != address(0), "Transfer from zero address");
        require(to != address(0), "Transfer to zero address");
        require(_balances[from] >= value, "Insufficient balance");
        // 改变内部状态
        _balances[from] -= value;
        _balances[to] += value;
        // 触发事件记录日志
        emit Transfer(from, to, value);
    }

    function _approve(address owner, address spender, uint256 value) private {
        require(owner != address(0), "Approve from zero address");
        require(spender != address(0), "Approve to zero address");
        // 记录授权状态（owner授权spender可操作的代币数量value）
        _allowances[owner][spender] = value;
        // 触发事件记录日志
        emit Approval(owner, spender, value);
    }

    function _spendAllowance(address owner, address spender, uint256 value) private {
        // 查询一下能够操作转移的代币数量
        uint256 currentAllowance = allowance(owner, spender);
        // 可操作的数量必须大于等于本次转移的数量
        require(currentAllowance >= value, "Allowance exceeded");
        unchecked {
            // 更新授权状态中的owner授权spender可操作的代币数量（扣除本次转移之后的）
            _approve(owner, spender, currentAllowance - value);
        }
    }

    // 增发代币
    function _mint(address account, uint256 value) private {
        require(account != address(0), "Mint to zero address");
        // 总代币供应更新
        _totalSupply += value;
        // 给这个账户发币，更新状态
        _balances[account] += value;
        // 从零地址转账表示铸币
        emit Transfer(address(0), account, value); 
    }
}

//etherscan:
//https://sepolia.etherscan.io/tx/0xc559f6123313b04a543e5d0040a7736eefe0a1a3b796cf5c0191339abc105410