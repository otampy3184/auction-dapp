pragma solidity ^0.8.13;

//SPDX-License-Identifier: UNLICENSED

import "./ERC721Receiver.sol";

contract ERC721Holder is ERC721Receiver {
    function onERC721Received(address, uint256, bytes memory) public returns(bytes4) {
        return ERC721_RECEIVED;        
    }
}