// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.12;

import "ds-test/test.sol";

import "./BdaIssue.sol";

contract BdaIssueTest is DSTest {
    BdaIssue issue;

    function setUp() public {
        issue = new BdaIssue();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
