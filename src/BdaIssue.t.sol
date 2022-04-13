// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.12;

import {DSTest}  from "ds-test/test.sol";
import {DSToken} from "ds-token/token.sol";
import {Vat}  from "dss/vat.sol";
import {DssCdpManager} from "dss-cdp-manager/DssCdpManager.sol";
import {ProxyRegistry, DSProxyFactory} from "proxy-registry/ProxyRegistry.sol";
import "./BdaIssue.sol";

interface Hevm {
    function warp(uint256) external;
}

contract BdaIssueTest is DSTest {
    Hevm hevm;

//    DssProxyActions dssProxyActions;
//    DSProxy proxy;
    DssCdpManager manager;
    DSToken gem;
    DSProxyFactory factory;
    Vat vat;
    ProxyRegistry registry;
    BdaIssue issue;
    uint256 delay;

    uint256 constant startTime = 1649835136;

    function setUp() public {
        hevm = Hevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
        hevm.warp(startTime);

        vat = new Vat();
        manager = new DssCdpManager(address(vat));
        gem = new DSToken('BDA');
        factory = new DSProxyFactory();
        registry = new ProxyRegistry(address(factory));
//	    dssProxyActions = address(new DssProxyActions());
//        proxy = DSProxy(registry.build());
        delay = 3 days;

        issue = new BdaIssue(address(gem), address(manager), address(registry), delay);
    }

    function test_destiny() public {
        hevm.warp(startTime + delay);
        uint256 alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 2.47E27);

        hevm.warp(startTime + delay + 1);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 2.47E27);

        hevm.warp(startTime + delay + 1 days);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 2.4453E27);

        hevm.warp(startTime + delay + 2 days - 1);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 2.4453E27);

        hevm.warp(startTime + delay + 10 days);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 2.2338237252717470903247E27);

        hevm.warp(startTime + delay + 30 days);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 1.827059922269052644143137277E27);

        hevm.warp(startTime + delay + 90 days);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 0.999687972515460497612684396E27);

        hevm.warp(startTime + delay + 180 days);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 0.404605685178976560030271307E27);

        hevm.warp(startTime + delay + 360 days);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 0.066277635821517851162759391E27);

        hevm.warp(startTime + delay + 720 days);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 0.001778431178173986334247354E27);

        hevm.warp(startTime + delay + 1440 days);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 0.000001280492896964094383307E27);

        hevm.warp(startTime + delay + 2880 days);
        alpha = issue.destiny(block.timestamp - (startTime + delay));
        assertEq(alpha , 0.000000000000663830793188462E27);
    }

}

