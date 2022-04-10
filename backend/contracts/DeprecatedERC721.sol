pragma solidity ^0.5.16;

import "./ERC721.sol";

/**
 * @title ERC-721 methods shipped in OpenZeppelin v1.7.0, removed in the latest version of the standard
 * @dev Only use this interface for compatibility with previously deployed contracts
 * @dev Use ERC721 for interacting with new contracts which are standard-compliant
 */

//古い型で現在は使われていないが、過去のコントラクトとの整合性を保つために必要
contract DeprecatedERC721Token is ERC721 {
    function takeOwnership(uint256 _tokenId) public;
    function transfer(address _to, uint256 _tokenId) public;
    function tokenOf(address _owner) public view returns (uint256[] memory);
}