// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.17;


/// @title A simple trivia game
contract TriviaGame {
    bytes32 public salt = bytes32("321123321");
    bytes32 public hashedAnswer;
    string public question;
    event TriviaFunded(uint256 amount);
    event AnswerGuessed();

    constructor(string memory _question, bytes32 _hashedAnswer) {
        question = _question;
        hashedAnswer = _hashedAnswer;
    }

    function guess(string calldata answer) public {
        require(keccak256(abi.encodePacked(salt, answer)) == hashedAnswer);
        if (address(this).balance > 0) {
            emit AnswerGuessed();
        (bool sent, bytes memory data) = payable(msg.sender).call{value: address(this).balance}("");
            require(sent, "ERROR: failed to send.");
        }
    }

    fallback() external payable {
        emit TriviaFunded(address(this).balance);
    }

    receive() external payable {
        emit TriviaFunded(address(this).balance);
    }
}