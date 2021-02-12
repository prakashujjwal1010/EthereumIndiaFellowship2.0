// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.8.0;
import "remix_tests.sol";
import "remix_accounts.sol";
import "../contracts/1_Storage.sol";

contract testSuite {

    Storage storageToTest;
    function beforeEach () public {
        storageToTest = new Storage();
    }

    function checkIfValueStoredCorrectly() public {
        storageToTest.store(3245);
        Assert.equal(storageToTest.retrieve(), uint(3245), "3245 should be stored correctly");
    }

    function defaultValueShouldBeZero() public {
        Assert.equal(storageToTest.retrieve(), uint(0), "default value stored should be zero");
    }
}
