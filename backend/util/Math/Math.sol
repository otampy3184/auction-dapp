pragma solidity ^0.8.0;

//SPDX-License-Identifier: UNLICENSED

//Math
//Errorを返さないのでチョットアブナイ
library Math {
    function max64(uint64 a, uint64 b) internal pure returns (uint64){
        return a >= b ? a : b;
    }

    function min64(uint64 a, uint64 b) internal pure returns (uint64) {
        return a < b ? a : b;
    }

    function max256(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    function min256(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }   
}