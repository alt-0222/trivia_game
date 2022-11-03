// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.17;

import "../src/TriviaGame.sol";
import "../forge-std/lib/ds-test/src/test.sol";


interface CheatCodes {
    function deal(address, uint256) external;
}

contract TriviaGameTest is DSTest {
    CheatCodes constant cheats = CheatCodes(HEVM_ADDRESS);
    TriviaGame public game;

    function setUp() public {
        // Create a question
        string memory question = "What is the only even prime number?";
        string memory answer = "2";
        bytes32 salt = bytes32("321123321");
        bytes32 hashedAnswer = keccak256(abi.encodePacked(salt, answer));
        emit log_bytes32(hashedAnswer);
        game = new TriviaGame(question, hashedAnswer);
        emit log(game.question());
    }

    function testTriviaFail() public {
        try game.guess("0") {
            assertTrue(false);
        } catch {
            assertTrue(true);
        }
    }

    function testTriviaPass() public {
        uint256 beginningBalance = address(this).balance;
        cheats.deal(address(game), 1500);
        game.guess("2");
        assertEq(address(this).balance, beginningBalance + 1500);
    }

    fallback() external payable {}

    receive() external payable {}
}