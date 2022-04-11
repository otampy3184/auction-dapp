pragma solidity ^0.8.13;

//SPDX-License-Identifier: UNLICENSED

import "./ERC721Basic.sol";

/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */

//ERC721Tokenの列挙用拡張機能
abstract contract ERC721Enumrable is ERC721Basic {
    //供給量の全量を確認する
    function totalSupply()virtual public view returns (uint256);
    //特定owner所持のトークンをインデックス順に抽出
    function tokenOfOwnerByIndex(address _owner, uint256 _index)virtual public view returns (uint256 _tokenId);
    //全トークンをインデックス順に抽出
    function tokenByIndex(uint256 _index)virtual public view returns (uint256);
}

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */

 //ERC721でMetadataを規定する拡張機能
abstract contract ERC721Metadata is ERC721Basic {
    //Nameデータを返す
    function name()virtual public view returns (string memory _name);
    //Symbolデータを返す
    function symbol()virtual public view returns (string memory _symbol);
    //TokenURIを返す
    function tokenURI(uint256 _tokenid)virtual public view returns (string memory);
}

/**
 * @title ERC-721 Non-Fungible Token Standard, full implementation interface
 * @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */

//拡張機能も合わせたInterface
abstract contract ERC721 is ERC721Basic, ERC721Enumrable, ERC721Metadata {
}
