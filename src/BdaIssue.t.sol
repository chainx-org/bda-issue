// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.12;

import {DssDeployTestBase, GemJoin, Flipper} from "dss-deploy/DssDeploy.t.base.sol";
import {DGD} from "dss-gem-joins/tokens/DGD.sol";
import {GemJoin3} from "dss-gem-joins/join-3.sol";
import {DSValue} from "ds-value/value.sol";
import {DSToken} from "ds-token/token.sol";
import {DssProxyActions} from "dss-proxy-actions/DssProxyActions.sol";
import {DssCdpManager} from "dss-cdp-manager/DssCdpManager.sol";
import {ProxyRegistry, DSProxyFactory, DSProxy} from "proxy-registry/ProxyRegistry.sol";
import "./BdaIssue.sol";

contract ProxyCalls {
    DSProxy proxy;
    address dssProxyActions;
    address dssProxyActionsEnd;
    address dssProxyActionsDsr;

    function transfer(address, address, uint256) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function open(address, bytes32, address) public returns (uint cdp) {
        bytes memory response = proxy.execute(dssProxyActions, msg.data);
        assembly {
            cdp := mload(add(response, 0x20))
        }
    }

    function give(address, uint, address) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function giveToProxy(address, address, uint, address) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function cdpAllow(address, uint, address, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function urnAllow(address, address, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function hope(address, address) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function nope(address, address) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function flux(address, uint, address, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function move(address, uint, address, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function frob(address, uint, int, int) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function frob(address, uint, address, int, int) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function quit(address, uint, address) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function enter(address, address, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function shift(address, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function lockETH(address, address, uint) public payable {
        (bool success,) = address(proxy).call.value(msg.value)(abi.encodeWithSignature("execute(address,bytes)", dssProxyActions, msg.data));
        require(success, "");
    }

    function safeLockETH(address, address, uint, address) public payable {
        (bool success,) = address(proxy).call.value(msg.value)(abi.encodeWithSignature("execute(address,bytes)", dssProxyActions, msg.data));
        require(success, "");
    }

    function lockGem(address, address, uint, uint, bool) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function safeLockGem(address, address, uint, uint, bool, address) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function makeGemBag(address) public returns (address bag) {
        address payable target = address(proxy);
        bytes memory data = abi.encodeWithSignature("execute(address,bytes)", dssProxyActions, msg.data);
        assembly {
            let succeeded := call(sub(gas(), 5000), target, callvalue(), add(data, 0x20), mload(data), 0, 0)
            let size := returndatasize()
            let response := mload(0x40)
            mstore(0x40, add(response, and(add(add(size, 0x20), 0x1f), not(0x1f))))
            mstore(response, size)
            returndatacopy(add(response, 0x20), 0, size)

            bag := mload(add(response, 0x60))

            switch iszero(succeeded)
            case 1 {
                // throw if delegatecall failed
                revert(add(response, 0x20), size)
            }
        }
    }

    function freeETH(address, address, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function freeGem(address, address, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function exitETH(address, address, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function exitGem(address, address, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function draw(address, address, address, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function wipe(address, address, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function wipeAll(address, address, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function safeWipe(address, address, uint, uint, address) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function safeWipeAll(address, address, uint, address) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function lockETHAndDraw(address, address, address, address, uint, uint) public payable {
        (bool success,) = address(proxy).call.value(msg.value)(abi.encodeWithSignature("execute(address,bytes)", dssProxyActions, msg.data));
        require(success, "");
    }

    function openLockETHAndDraw(address, address, address, address, bytes32, uint) public payable returns (uint cdp) {
        address payable target = address(proxy);
        bytes memory data = abi.encodeWithSignature("execute(address,bytes)", dssProxyActions, msg.data);
        assembly {
            let succeeded := call(sub(gas(), 5000), target, callvalue(), add(data, 0x20), mload(data), 0, 0)
            let size := returndatasize()
            let response := mload(0x40)
            mstore(0x40, add(response, and(add(add(size, 0x20), 0x1f), not(0x1f))))
            mstore(response, size)
            returndatacopy(add(response, 0x20), 0, size)

            cdp := mload(add(response, 0x60))

            switch iszero(succeeded)
            case 1 {
                // throw if delegatecall failed
                revert(add(response, 0x20), size)
            }
        }
    }

    function lockGemAndDraw(address, address, address, address, uint, uint, uint, bool) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function openLockGemAndDraw(address, address, address, address, bytes32, uint, uint, bool) public returns (uint cdp) {
        bytes memory response = proxy.execute(dssProxyActions, msg.data);
        assembly {
            cdp := mload(add(response, 0x20))
        }
    }

    function openLockGNTAndDraw(address, address, address, address, bytes32, uint, uint) public returns (address bag, uint cdp) {
        bytes memory response = proxy.execute(dssProxyActions, msg.data);
        assembly {
            bag := mload(add(response, 0x20))
            cdp := mload(add(response, 0x40))
        }
    }

    function wipeAndFreeETH(address, address, address, uint, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function wipeAllAndFreeETH(address, address, address, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function wipeAndFreeGem(address, address, address, uint, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function wipeAllAndFreeGem(address, address, address, uint, uint) public {
        proxy.execute(dssProxyActions, msg.data);
    }

    function end_freeETH(address a, address b, address c, uint d) public {
        proxy.execute(dssProxyActionsEnd, abi.encodeWithSignature("freeETH(address,address,address,uint256)", a, b, c, d));
    }

    function end_freeGem(address a, address b, address c, uint d) public {
        proxy.execute(dssProxyActionsEnd, abi.encodeWithSignature("freeGem(address,address,address,uint256)", a, b, c, d));
    }

    function end_pack(address a, address b, uint c) public {
        proxy.execute(dssProxyActionsEnd, abi.encodeWithSignature("pack(address,address,uint256)", a, b, c));
    }

    function end_cashETH(address a, address b, bytes32 c, uint d) public {
        proxy.execute(dssProxyActionsEnd, abi.encodeWithSignature("cashETH(address,address,bytes32,uint256)", a, b, c, d));
    }

    function end_cashGem(address a, address b, bytes32 c, uint d) public {
        proxy.execute(dssProxyActionsEnd, abi.encodeWithSignature("cashGem(address,address,bytes32,uint256)", a, b, c, d));
    }

    function dsr_join(address a, address b, uint c) public {
        proxy.execute(dssProxyActionsDsr, abi.encodeWithSignature("join(address,address,uint256)", a, b, c));
    }

    function dsr_exit(address a, address b, uint c) public {
        proxy.execute(dssProxyActionsDsr, abi.encodeWithSignature("exit(address,address,uint256)", a, b, c));
    }

    function dsr_exitAll(address a, address b) public {
        proxy.execute(dssProxyActionsDsr, abi.encodeWithSignature("exitAll(address,address)", a, b));
    }
}

contract BdaIssueTest is DssDeployTestBase, ProxyCalls {
    GemJoin3 dgdJoin;
    DGD dgd;
    DSValue pipDGD;
    Flipper dgdFlip;

    DssProxyActions dssProxyActions;
    DSProxy proxy;
    DssCdpManager manager;
    DSToken gem;
    DSProxyFactory factory;
    ProxyRegistry registry;
    BdaIssue issue;
    uint256 delay;

    uint256 constant startTime = 1649835136;

    function setUp() public {
        super.setUp();
        deployKeepAuth();

        hevm.warp(startTime);

        // Add a token collateral
        dgd = new DGD(1000 * 10 ** 9);
        dgdJoin = new GemJoin3(address(vat), "DGD", address(dgd), 9);
        pipDGD = new DSValue();
        dssDeploy.deployCollateral("DGD", address(dgdJoin), address(pipDGD));
        (dgdFlip, ) = dssDeploy.ilks("DGD");
        pipDGD.poke(bytes32(uint(50 ether))); // Price 50 DAI = 1 DGD (in precision 18)
        this.file(address(spotter), "DGD", "mat", uint(1500000000 ether)); // Liquidation ratio 150%
        this.file(address(vat), bytes32("DGD"), bytes32("line"), uint(10000 * 10 ** 45));
        spotter.poke("DGD");
        (,,uint spot,,) = vat.ilks("DGD");
        assertEq(spot, 50 * RAY * RAY / 1500000000 ether);

        manager = new DssCdpManager(address(vat));
        gem = new DSToken('BDA');
        factory = new DSProxyFactory();
        registry = new ProxyRegistry(address(factory));
	    dssProxyActions = new DssProxyActions();
        proxy = DSProxy(registry.build());
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

    function test_adventure() public{
//        uint256 cdp = this.open(address(manager), "DGD", address(proxy));
//        assertEq(cdp, 1);
    }

    function test_treasure() public{
//        uint256 cdp = this.open(address(manager), "DGD", address(proxy));
//        assertEq(cdp, 1);
    }

}

