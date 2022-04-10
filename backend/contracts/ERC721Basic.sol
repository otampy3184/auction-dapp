pragma solidity ^0.5.16; 

/**
 * @title ERC721 Non-Fungible Token Standard basic interface
 * @dev 詳しくは https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */

//ERC721トークンのInterface
contract ERC721Basic {
    //Transferのイベント発行
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    
    //Approvalのイベント発行
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
    
    //ApprovalForAllのイベント発行
    event ApprovalForAll(address indexed _owner, address indexed operator, bool _approved);

    //残高を調べる
    function balanceOf(address _owner) public view returns (uint256 _balance);
    //owenerを調べる
    function ownerOf(uint256 _tokenId) public view returns (address _owner);
    //存在を確かめる
    function exists(uint256 _tokenid) public view returns (bool _exists);

    //承認
    function approve(address _to, uint256 _tokenId) public view;
    //承認を得る
    function getApproved(uint256 _tokenid) public view returns (address _operator);

    //全員に承認を与える
    function setApprovalForAll(address _operator, bool _approved) public;
    //全員の承認を確認する
    function isApprovedForAll(address _owner, address _operator) public view returns (bool);

    //資金移転
    function transferFrom(address _from, address _to, uint256 _tokenId) public;
    //安全な資金移転
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) public;
    //禁錮の資金移転
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory _data
    )
     public;
}