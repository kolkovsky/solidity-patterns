// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.7;

contract String {
    function hashCompareWithLengthCheck(string memory a, string memory b) public pure returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
        }
    }
}