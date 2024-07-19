// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("Degen", "DGN") {}

    function mint(address _account, uint256 _amount) public onlyOwner {
        _mint(_account, _amount);
    }

    function transferTokens(address _to, uint256 _amount) external {
        require(balanceOf(msg.sender) >= _amount, "Insufficient balance");
        _transfer(msg.sender, _to, _amount);
    }

    function getTokenBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function burnTokens(uint256 _amount) external {
        require(balanceOf(msg.sender) >= _amount, "Insufficient tokens");
        _burn(msg.sender, _amount);
    }

    function distributeTokens(uint256 _gamesWon) external {
        require(_gamesWon >= 1 && _gamesWon <= 4, "Invalid number of games won");

        uint256 tokensToDistribute = 0;

        if (_gamesWon == 1) {
            tokensToDistribute = 100;
        } else if (_gamesWon == 2) {
            tokensToDistribute = 250;
        } else if (_gamesWon == 3) {
            tokensToDistribute = 500;
        } else if (_gamesWon == 4) {
            tokensToDistribute = 1000;
        }

        require(tokensToDistribute > 0, "Invalid number of tokens to distribute");
        require(balanceOf(owner()) >= tokensToDistribute, "Insufficient contract balance");

        _transfer(owner(), msg.sender, tokensToDistribute);
    }

    function getDistributionDetails(uint256 _gamesWon) external pure returns (string memory) {
        require(_gamesWon >= 1 && _gamesWon <= 4, "Invalid number of games won");

        string memory distributionDetails;

        if (_gamesWon == 1) {
            distributionDetails = "1 game won: 100 tokens";
        } else if (_gamesWon == 2) {
            distributionDetails = "2 games won: 250 tokens";
        } else if (_gamesWon == 3) {
            distributionDetails = "3 games won: 500 tokens";
        } else if (_gamesWon == 4) {
            distributionDetails = "4 games won: 1000 tokens";
        }

        return distributionDetails;
    }
}
