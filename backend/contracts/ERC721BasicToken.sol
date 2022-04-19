pragma solidity ^0.8.0;

//SPDX-License-Identifier: UNLICENSED

import "./ERC721Basic.sol";
import "./ERC721Receiver.sol";
import "../util/math/SafeMath.sol";
import "../util/AddressUtils.sol";

/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */

abstract contract ERC721BasicToken is ERC721Basic {
    using SafeMath for uint256;
    using AddressUtils for address;

    bytes4 constant ERC721_RECEIVED = 0xf0b9e5ba;

    mapping (uint256 => address) internal tokenOwner;

    mapping (uint256 => address) internal tokenApprovals;

    mapping (address => uint256) internal ownedTokenCount;

    mapping (address => mapping (address => bool)) internal operatorApprovals;

    modifier onlyOwnerOf(uint256 _tokenId){
        require(ownerOf(_tokenId) == msg.sender);
        _;
    }

    // modifier canTransfer(uint256 _tokenId) {
    //     require(isApprovedOrOwner(msg.sender, tokenId));
    //     _;
    // }

    function balanceOf(address _owner)public override view returns (uint256) {
        require(_owner != address(0));
        return ownedTokenCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public override view returns (address) {
        address owner = tokenOwner[_tokenId];
        require(owner != address(0));
        return owner;
    }

    function exists(uint256 _tokenId) public override view returns (bool) {
        address owner = tokenOwner[_tokenId];
        return owner != address(0);
    }

    function _approve(address to, uint256 tokenId) internal virtual {
        tokenApprovals[tokenId] = to;
        emit Approval(ownerOf(tokenId), to, tokenId);
    }

    // TODO: Overriding function changes state mutability from "view" to "nonpayable".
    // function approve(address to, uint256 tokenId) public virtual override {
    //     address owner = ownerOf(tokenId);
    //     require(to != owner, "ERC721: approval to current owner");

    //     require(
    //         msg.sender == owner || isApprovedForAll(owner, msg.sender),
    //         "ERC721: approve caller is not owner nor approved for all"
    //     );

    //     _approve(to, tokenId);
    //}
}

