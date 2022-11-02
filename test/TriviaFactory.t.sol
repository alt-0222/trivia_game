// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.17;

import "../src/TriviaFactory.sol";
import "forge-std/Test.sol";


contract TriviaFactoryTest is DSTest {
    TriviaFactory public factory;

    function setUp() public {
        factory = new TriviaFactory();
    }

    function testCreateTrivia() public {
        string memory question = "What is the only even prime number?";
        string memory answer = "2";
        bytes32 salt = bytes32("321123321");
        bytes32 hashedAnswer = keccak256(abi.encodePacked(salt, answer));
        factory.createTrivia(question, hashedAnswer);
        TriviaGame trivia = factory.trivias(0);
        assertEq(
            keccak256(abi.encodePacked(trivia.question())),
            keccak256(abi.encodePacked(question))
        );
    }

    function testCountTrivia() public {
        string memory question = "What is the only even prime number?";
        string memory answer = "2";
        bytes32 salt = bytes32("321123321");
        bytes32 hashedAnswer = keccak256(abi.encodePacked(salt, answer));
        factory.createTrivia(question, hashedAnswer);
        factory.createTrivia(question, hashedAnswer);
        TriviaGame[] memory trivias = factory.getTrivias();
        assertEq(trivias.length, 2);
    }
}