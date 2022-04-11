pragma solidity ^0.5.16;

//Math
//計算失敗の場合にErrorを返すので安心
library SafeMath {

    //kakezan
    //assure for not overfloating
    function mul(uint256 a, uint256 b) internal pure returns(uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        assert (c / a == b);
        return c;
    }

    //warizan
    function div(uint256 a, uint256 b) internal pure returns(uint256) {
        return a / b;
    }

    //hikizan
    function sub(uint256 a, uint256 b) internal pure returns(uint256) {
        assert(b <= a);
        return a - b;
    }

    //tashizan
    //assure for not overfloating
    function add() {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}