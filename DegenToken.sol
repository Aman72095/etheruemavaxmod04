
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Degen", "DGN") {}

        function mint(address addressof, uint256 _amt) public onlyOwner{
            _mint(addressof, _amt);
        }
        function transferTokens(address beneficiary, uint _amt) external{
            require(balanceOf(msg.sender) >= _amt, "Invalid Owner !!");
            approve(msg.sender,_amt);
            transferFrom(msg.sender, beneficiary,_amt);
        }
        function balanceGetter() external view returns(uint){
           return balanceOf(msg.sender);
        }
        function burnTokens(uint _amt) external{
            require(balanceOf(msg.sender)>= _amt, "Insufficient Tokens Present");
            _burn(msg.sender,_amt);
        }
        function gaminghub() public pure returns(string memory) {
            return "1.Diamond league  NFT=100\n 2.Crown League NFT=200 \n 3.Silver League NFT=300 \n 4.Bronze League NFT=400 \n";
        }
        function pointsLeague(uint _points)public pure returns(string memory){
            require(_points>=100,"You are not in any league");
            if(_points==100){
                return "Congratulation you are in diamond league";
            }
            else if(_points ==200){
                return "Congratulation you are in crown league";
            }
            else if(_points ==300){
                return "Congratulation you are in silver league";
            }
            else if(_points ==400){
                return "Congratulation you are in bronze league";
            }
        }

        function reedemTokens(uint choice) external payable{
            require(choice>0,"Invalid selection");
            if(choice ==1){
                approve(msg.sender, 100);
                transferFrom(msg.sender, owner(), 100);
                console.log("Congrats you have redeemed 100 tokens ");
            }
            else if(choice ==2){
                approve(msg.sender, 200);
                transferFrom(msg.sender, owner(), 200);
                 console.log("Congrats you have redeemed 200 tokens ");
            }
            else if(choice ==3){
                approve(msg.sender, 300);
                transferFrom(msg.sender, owner(), 300);
                 console.log("Congrats you have redeemed 300 tokens ");
            }
            else if(choice ==4){
                approve(msg.sender, 400);
                transferFrom(msg.sender, owner(), 400);
                 console.log("Congrats you have redeemed 400 tokens ");
            }
        }

}
