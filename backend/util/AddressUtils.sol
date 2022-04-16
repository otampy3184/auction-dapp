pragma solidity ^0.8.0;

//SPDX-License-Identifier: UNLICENSED

/**
 * @title Address確認用のUtilのコピペ
 */

 library AddressUtils {
     function isContract(address addr) internal view returns(bool) {
        uint256 size;
        // XXX Currently there is no better way to check if there is a contract in an address
        // than to check the size of the code at that address.
        // See https://ethereum.stackexchange.com/a/14016/36603
        // for more details about how this works.
        // TODO Check this again before the Serenity release, because all addresses will be
        // contracts then.
        assembly { size := extcodesize(addr) }  // solium-disable-line security/no-inline-assembly
        return size > 0;
    }
 }