// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Articles.sol";

contract role_access{

    event Deploy(address);

    fallback() external payable {} //退回主幣
    receive() external payable {}

    //權限->使用者地址->是否有權限(boolean)
    //bytes32比address更省GAS
    mapping(bytes32 => mapping(address => bool)) public roles;
    
    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));

    //0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    //使用者地址->儲存文章地址的陣列
    mapping(address => address[]) public articles;
    //取得某使用者的文章數量
    function getArticlesNum(address _addr) view external returns(uint){
        return articles[_addr].length;
    }
    //取得某使用者的文章地址
    function getArticleAddress(address _addr, uint _index) view external returns(address){
        return articles[_addr][_index];
    }
    
    function PostArticle(address _addr,address _Article) external{
        articles[_addr].push(_Article);
    }
    constructor() {
        //部署合約者設為管理員
        internal_grantRole(ADMIN, msg.sender);
    }

    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    //用於構造函式
    function internal_grantRole(bytes32 _role, address _account) internal{
        roles[_role][_account] = true;
    }
    /*確認呼叫地址是否為管理員*/
    modifier check_ADMIN(bytes32 _role){
        require(roles[_role][msg.sender],"not autorized.");
        _;
    }

    function external_grantRole(bytes32 _role, address _account) external check_ADMIN(ADMIN){
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function external_revokeRole(bytes32 _role, address _account) external check_ADMIN(ADMIN){
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }

}