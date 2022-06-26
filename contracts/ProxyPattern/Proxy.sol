//SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Greeter.sol";
import "hardhat/console.sol";

contract Proxy is Ownable{
    
    address private innerLogicContractAddress;
    uint256[] private items;
    mapping(address => uint256) balances;

    modifier checkBalance(address client) {
        _;
        if (balances[client] > 0) {
            payable(client).transfer(balances[client]);
        }
    }
    
    function delegateCall1(string memory text) public {
        (bool success, ) = innerLogicContractAddress.delegatecall(
            abi.encodeWithSelector(Greeter.setGreeting.selector, text)
        );
        require(success == true, "DelegateCall1 isn't working");
    }

    function delegateCall2(string memory text) public {
        (bool success, ) = innerLogicContractAddress.delegatecall(
            abi.encodeWithSelector(bytes4(keccak256("setGreeting(string)")), text)
        );
        require(success == true, "DelegateCall");
    }

    function logValue(string calldata value) external view {
        console.log(value);
    }
}