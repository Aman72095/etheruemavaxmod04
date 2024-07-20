// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {}

    function mint(address addressof, uint256 _amt) public onlyOwner {
        _mint(addressof, _amt);
    }

    function transferTokens(address beneficiary, uint256 _amt) external {
        require(balanceOf(msg.sender) >= _amt, "Invalid Owner !!");
        transfer(beneficiary, _amt);
    }

    function balanceGetter() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function burnTokens(uint256 _amt) external {
        require(balanceOf(msg.sender) >= _amt, "Insufficient Tokens Present");
        _burn(msg.sender, _amt);
    }

    function gaminghub() public pure returns (string memory) {
        return "1. Diamond league NFT=100\n2. Crown League NFT=200\n3. Silver League NFT=300\n4. Bronze League NFT=400\n";
    }

    function pointsLeague(uint256 _points) public pure returns (string memory) {
        require(_points >= 100, "You are not in any league");
        if (_points == 100) {
            return "Congratulations, you are in the Diamond League";
        } else if (_points == 200) {
            return "Congratulations, you are in the Crown League";
        } else if (_points == 300) {
            return "Congratulations, you are in the Silver League";
        } else if (_points == 400) {
            return "Congratulations, you are in the Bronze League";
        } else {
            return "You are not in any specific league";
        }
    }

    function redeemTokens(uint256 choice) external payable {
        require(choice > 0, "Invalid selection");
        uint256 amount;

        if (choice == 1) {
            amount = 100;
        } else if (choice == 2) {
            amount = 200;
        } else if (choice == 3) {
            amount = 300;
        } else if (choice == 4) {
            amount = 400;
        } else {
            revert("Invalid choice");
        }

        require(balanceOf(msg.sender) >= amount, "Insufficient Tokens Present");

        transfer(owner(), amount);
        console.log("Congrats, you have redeemed", amount, "tokens");
    }
}

