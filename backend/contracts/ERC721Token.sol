pragma solidity ^0.5.16;

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
contract ERC721Token is ERC721, ERC721Basic {
    //Token name
    string internal name_;

    //Token symbol 
    string internal symbol_;

    //Mapping from owner to list owned token IDs
    mapping (address => uint256[]) internal ownedTokens;

    //Mapping from token ID to index of the owner tokens list 
    mapping (uint256 => uint256) internal ownedTokenIndex;

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
  constructor(string memory _name, string memory _symbol) public {
      name = _name;
      symbol = _symbol; 
  }

  //Tokenの名前取得
  function name() public view returns (string memory) {
      return name_;
  }

  //Tokenのシンボル取得
  function symbol() public view returns (string memory) {
      return symbol_;
  }

  //TokenのURI取得
  function tokenURI(uint256 _tokenId) public view returns (string memory) {
      require(existx(_tokenId));
      return tokenURIs[_tokenId];
  }

  //リクエスト元のOwnerが所持するIndexから全てのTokenIDを取得する
  function tokenOfOwnerByIndex(address _onwer, uint256 _index) {
      require(_index < balanceOf(owner));
      return ownedTokens[_owner][_index];
  }

  //Contractに入っている全Tokenを取得する
  function totalSupply() public view returns (uint256) {
      return allTokens.length;
  }

  //与えられたIndex値からContractが所有している全トークンを取得する
  function tokenByIndex(uint256 _index) public view returns (uint256) {
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
      super.addTokenTo(_to, _tokenId);
      uint256 length = ownedTokens[_to].length;
      ownedTokens[_to].push(_tokenId);
      ownedTokenIndex[_tokenId] = length;
  }

  //指定のアドレスに付与されたTokenIDを削除する
  function removeTokenFrom(address _from, uint256 _tokenId) internal {
      super.removeTokenFrom(_from, _tokenId);

      uint256 tokenIndex = ownedTokenIndex[_tokenId];
      uint256 lastTokenIndex = ownedTokens[_from].length.sub(1);
      uint256 lastToken = ownedTokens[_from][lastTokenIndex];

      ownedTokens[_from][tokenIndex] = lastToken;
      ownedTokens[_from][lastTokenIndex] = 0;

      ownedTokens[_from].length--;
      ownedTokenIndex[_tokenId] = 0;
      ownedTokenIndex[lastToken] =tokenIndex;
   }

   //新しいトークンをミントする
   function _mint(address _to, uint256 _tokenId) internal{
       super._mint(_to, _tokenId);

       allTokensIndex[_tokenId] = allTokens.length;
       allTokens.push(_tokenId);
    }

    //トークンをバーンする
    function _burn(address _owner, uint256 _tokenId) internal {
        super._burn(_owner, _tokenId);

        //メタデータがあった場合は削除する
        if (bytes(tokenURIs[_tokenId]).length != 0){
            delete tokenURIs[_tokenId];
        }

        uint256 tokenIndex = allTokensIndex[_tokenId];
        uint256 lastTokenindex;
        uint256 lastToken = allTokens[lastTokenIndex];

        allTokens = lastToken;
        allTokens[lastTokenindex] = 0;

        allTokens.length--;
        allTokensIndex[_tokenId] = 0; 
        allTokensIndex[lastToken] = tokenIndex;
    }
}


