// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IString {
    function value() external returns(string memory);
    function setValue(string memory input) external;
}

contract TheString is IString {
    string public value;

    function setValue(string calldata input) public {
        value = input;
    }
}

contract TestYulString {
    IString target;

    constructor(IString t) { target = t; }

    function value() public returns (string memory) {
        return target.value();
    }

    function setValue(string calldata input) public {
        target.setValue(input);
    }
}

contract DelegateTestYulString {
    string take_my_slot_please;
    IString target;

    constructor(IString t) { target = t; }

    function value() public returns (string memory) {
        (bool success, bytes memory data) = address(target).delegatecall(
            abi.encodeWithSignature("value()")
        );

        require(success, "delegatecall failed");
        return abi.decode(data, (string));
    }

    function setValue(string calldata input) public {
        (bool success, ) = address(target).delegatecall(
            abi.encodeWithSignature("setValue(string)", input)
        );

        require(success, "delegatecall failed");
    }
}


