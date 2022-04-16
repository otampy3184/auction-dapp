pragma solidity ^0.8.13;

//SPDX-License-Identifier: UNLICENSED

//ERC721のトークンレシーバインターフェース
//operatorの引数は省略
abstract contract ERC721Receiver {
    bytes4 constant ERC721_RECEIVED = 0xf0b9e5ba;

    function onERC721Received(
        address _from,
        uint256 _tokenId,
        bytes memory _data
    ) public virtual returns(bytes4);
}
