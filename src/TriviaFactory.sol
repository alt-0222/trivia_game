// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.17;

import "./TriviaGame.sol";

contract TriviaFactory {
    TriviaGame[] public trivias;
    event TriviaCreated(TriviaGame indexed trivia);

    constructor() {}

    function createTrivia(string memory question, bytes32 answer) public {
        TriviaGame trivia = new TriviaGame(question, answer);
        trivias.push(trivia);
        emit TriviaCreated(trivia);
    }

    function getTrivias() public view returns (TriviaGame[] memory) {
        return trivias;
    }
}