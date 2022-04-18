// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.12;

import {DssDeployTestBase, GemJoin, Flipper} from "dss-deploy/DssDeploy.t.base.sol";
import {DGD} from "dss-gem-joins/tokens/DGD.sol";
import {GemJoin3} from "dss-gem-joins/join-3.sol";
import {DSValue} from "ds-value/value.sol";
import {DSToken} from "ds-token/token.sol";
import {DssProxyActions, DssProxyActionsEnd, DssProxyActionsDsr} from "dss-proxy-actions/DssProxyActions.sol";
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
}

contract BdaIssueTest is DssDeployTestBase, ProxyCalls {
    GemJoin3 dgdJoin;
    DGD dgd;
    DSValue pipDGD;
    Flipper dgdFlip;

    DssCdpManager manager;
    DSToken gem;
    DSProxyFactory factory;
    ProxyRegistry registry;
    BdaIssue issue;
    uint256 delay;

    uint256 constant startTime = 1649835136;

    event log                    (string);
    event log_uint                    (uint256);

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
        dssProxyActions = address(new DssProxyActions());
        proxy = DSProxy(registry.build());
        delay = 3 days;

        issue = new BdaIssue(address(gem), address(manager), address(registry), delay);
        gem.setOwner(address(issue));
    }

    // optimized version from dss PR #78
    function rpow(uint256 x, uint256 n, uint256 b) internal pure returns (uint256 z) {
        assembly {
            switch n case 0 {z := b}
            default {
                switch x case 0 {z := 0}
                default {
                    switch mod(n, 2) case 0 {z := b} default {z := x}
                    let half := div(b, 2)  // for rounding.
                    for {n := div(n, 2)} n {n := div(n, 2)} {
                        let xx := mul(x, x)
                        if shr(128, x) {revert(0, 0)}
                        let xxRound := add(xx, half)
                        if lt(xxRound, xx) {revert(0, 0)}
                        x := div(xxRound, b)
                        if mod(n, 2) {
                            let zx := mul(z, x)
                            if and(iszero(iszero(x)), iszero(eq(div(zx, x), z))) {revert(0, 0)}
                            let zxRound := add(zx, half)
                            if lt(zxRound, zx) {revert(0, 0)}
                            z := div(zxRound, b)
                        }
                    }
                }
            }
        }
    }

    function rmul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        z = x * y;
        require(y == 0 || z / y == x);
        z = z / RAY;
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x - y) <= x);
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
        uint cdp = this.open(address(manager), "DGD", address(proxy));
        dgd.approve(address(proxy), 3 * 10 ** 9);
        uint prevBalance = dgd.balanceOf(address(this));
        this.lockGemAndDraw(address(manager), address(jug), address(dgdJoin), address(daiJoin), cdp, 3 * 10 ** 9, 50 ether, true);
        // 50 dai base debt
        assertEq(dai.balanceOf(address(this)), 50 ether);
        assertEq(dgd.balanceOf(address(this)), prevBalance - 3 * 10 ** 9);
        // Stable rate 5% annualized
        uint256 duty = 1000000001547125957863212448;
        this.file(address(jug), bytes32("DGD"), bytes32("duty"), duty);
        // 4 days debt , 1 day alpha
        uint256 rate = rpow(duty, 4 days, RAY);
        hevm.warp(now + delay + 1 days);
        jug.drip("DGD");
        (, uint prev,,,) = vat.ilks("DGD");
        assertEq(rate, prev);
        issue.adventure(1, true);
        assertEq(issue.rates(cdp), rate);

        uint256 alpha = issue.destiny(1 days);
        uint256 diff = sub(rate, RAY);
        uint256 reward = rmul(alpha, rmul(diff, 50 ether));
        assertEq(gem.balanceOf(address(this)), reward);
        // mint bda 0.065390953399390975 ether
        assertEq(reward, 0.065390953399390975 ether);

        hevm.warp(now + 1 days);
        jug.drip("DGD");
        issue.adventure(1, true);
        assertEq(gem.balanceOf(address(this)) - reward, 0.016189670132835061 ether);
        reward = gem.balanceOf(address(this)) ;
        

        hevm.warp(now + 1 days);
        jug.drip("DGD");
        issue.adventure(1, true);
        assertEq(gem.balanceOf(address(this)) - reward, 0.016029916034149989 ether);
        reward = gem.balanceOf(address(this)) - reward;
    }

    function test_treasure() public{
        uint cdp = this.open(address(manager), "DGD", address(proxy));
        this.open(address(manager), "DGD", address(proxy));
        dgd.approve(address(proxy), 3 * 10 ** 9);
        uint prevBalance = dgd.balanceOf(address(this));
        this.lockGemAndDraw(address(manager), address(jug), address(dgdJoin), address(daiJoin), cdp, 3 * 10 ** 9, 50 ether, true);
        assertEq(dai.balanceOf(address(this)), 50 ether);
        assertEq(dgd.balanceOf(address(this)), prevBalance - 3 * 10 ** 9);
        this.file(address(jug), bytes32("DGD"), bytes32("duty"), uint(1000000001547125957863212448));
        hevm.warp(now + delay + 1 days);
        jug.drip("DGD");
        issue.treasure(true);
        assertEq(issue.rates(cdp), 1000534829701054193563189148);
        assertEq(gem.balanceOf(address(this)), 65390953399390975);
    }
}

