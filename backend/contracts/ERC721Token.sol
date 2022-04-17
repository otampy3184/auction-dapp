pragma solidity ^0.8.0;

//SPDX-License-Identifier: UNLICENSED

import "./ERC721.sol";
import "./DeprecatedERC721.sol";
import "./ERC721BasicToken.sol";

/**
 * @title Full ERC721 Token
 * This implementation includes all the required and some optional functionality of the ERC721 standard
 * Moreover, it includes approve all functionality using operator terminology
 * @dev see https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */

//ERC721トークンの全体！！
abstract contract ERC721Token is ERC721, ERC721BasicToken {
    //Token name
    string internal name_;

    //Token symbol
    string internal symbol_;

    // Mapping from token ID to owner address
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping(address => uint256) private _balances;

    //Mapping from owner to list owned token IDs
    mapping(address => uint256[]) internal ownedTokens;

    //Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) internal ownedTokenIndex;

    //Array with all token ids, used for enumeration
    uint256[] internal allTokens;

    //Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) internal allTokensIndex;

    //Optional mapping for token URIs
    mapping(uint256 => string) internal tokenURIs;

    /**
     * @dev Constructor function
     */
    //コンストラクタ
    constructor(string memory _name, string memory _symbol) {
        name_ = _name;
        symbol_ = _symbol;
    }

    //Tokenの名前取得
    function name() public view override returns (string memory) {
        return name_;
    }

    //Tokenのシンボル取得
    function symbol() public view override returns (string memory) {
        return symbol_;
    }

    //TokenのURI取得
    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(exists(_tokenId));
        return tokenURIs[_tokenId];
    }

    //リクエスト元のOwnerが所持するIndexから全てのTokenIDを取得する
    function tokenOfOwnerByIndex(address _owner, uint256 _index)
        public
        view
        override
        returns (uint256)
    {
        require(_index < balanceOf(_owner));
        return ownedTokens[_owner][_index];
    }

    //Contractに入っている全Tokenを取得する
    function totalSupply() public view override returns (uint256) {
        return allTokens.length;
    }

    //与えられたIndex値からContractが所有している全トークンを取得する
    function tokenByIndex(uint256 _index)
        public
        view
        override
        returns (uint256)
    {
        require(_index < totalSupply());
        return allTokens[_index];
    }

    //指定のトークンに対してURIを登録する
    function _setTokenURI(uint256 _tokenId, string memory _uri) internal {
        require(exists(_tokenId));
        tokenURIs[_tokenId] = _uri;
    }

    //指定のアドレスに対してトークンIDを付与する
    function addTokenTo(address _to, uint256 _tokenId) internal {
        //super.addTokenTo(_to, _tokenId);
        addTokenTo(_to, _tokenId);
        uint256 length = ownedTokens[_to].length;
        ownedTokens[_to].push(_tokenId);
        ownedTokenIndex[_tokenId] = length;
    }

    //指定のアドレスに付与されたTokenIDを削除する
    //OpenZeppelinによると<https://github.com/OpenZeppelin/openzeppelin-contracts/commit/12533bcb2b69a680d4cd0562de3954d041f1e6d5>のコミットで消された模様
    //詳しくはコメント参照
    //
    //   function removeTokenFrom(address _from, uint256 _tokenId) internal {
    //       //super.removeTokenFrom(_from, _tokenId);
    //       removeTokenFrom(_from, _tokenId);

    //       uint256 tokenIndex = ownedTokenIndex[_tokenId];
    //       uint256 lastTokenIndex = ownedTokens[_from].length - 1;
    //       uint256 lastToken = ownedTokens[_from][lastTokenIndex];

    //       ownedTokens[_from][tokenIndex] = lastToken;
    //       ownedTokens[_from][lastTokenIndex] = 0;

    //       ownedTokens[_from].length--;
    //       ownedTokenIndex[_tokenId] = 0;
    //       ownedTokenIndex[lastToken] =tokenIndex;
    //    }

    //新しいトークンをミントする
    //openzeppelinの方でファンクションの中身が変わった模様
    //    function _mint(address _to, uint256 _tokenId) internal{
    //        super._mint(_to, _tokenId);

    //        allTokensIndex[_tokenId] = allTokens.length;
    //        allTokens.push(_tokenId);
    //     }

    //mint機能はopenzeppelinの方では以下のように変わっている
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!exists(tokenId), "ERC721: token already minted");

        _beforeTokenTransfer(address(0), to, tokenId);

        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);

        _afterTokenTransfer(address(0), to, tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {}

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {}

    //トークンをバーンする
    function _burn(address _owner, uint256 _tokenId) internal {
        super._burn(_owner, _tokenId);

        //メタデータがあった場合は削除する
        if (bytes(tokenURIs[_tokenId]).length != 0) {
            delete tokenURIs[_tokenId];
        }

        uint256 tokenIndex = allTokensIndex[_tokenId];
        uint256 lastTokenIndex;
        uint256 lastToken = allTokens[lastTokenIndex];

        allTokens = lastToken;
        allTokens[lastTokenIndex] = 0;

        allTokens.length--;
        allTokensIndex[_tokenId] = 0;
        allTokensIndex[lastToken] = tokenIndex;
    }
}
