pragma solidity ^0.8.13;

//SPDX-License-Identifier: UNLICENSED

import "./ERC721.sol";

/**
 * @title ERC-721 methods shipped in OpenZeppelin v1.7.0, removed in the latest version of the standard
 * @dev Only use this interface for compatibility with previously deployed contracts
 * @dev Use ERC721 for interacting with new contracts which are standard-compliant
 */

//古い型で現在は使われていないが、過去のコントラクトとの整合性を保つために必要
abstract contract DeprecatedERC721Token is ERC721 {
    function takeOwnership(uint256 _tokenId) public virtual;
    function transfer(address _to, uint256 _tokenId) public virtual;
    function tokenOf(address _owner) public virtual view returns (uint256[] memory);
}