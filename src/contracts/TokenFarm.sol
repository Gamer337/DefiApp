pragma solidity ^0.5.0;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    //All code goes here...
    string public name = "Dapp Token Farm";
    DappToken public dappToken;
    DaiToken public daiToken;
    address public owner;
    
    address[] public stakers; 
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;
    
    constructor(DappToken _dappToken, DaiToken _daiToken) public {
        //Storing reference to the DappToken and DaiToken
        dappToken = _dappToken;
        daiToken = _daiToken;
        owner = msg.sender;
    }

    //1. Stake Tokens(Deposit)
    function stakeTokens(uint _amount) public {
        //Require amount greater than 0
        require( _amount > 0, "amount cannot be 0");
        
        //Transfer Mock dai Tokens to this contract for staking
        daiToken.transferFrom(msg.sender, address(this), _amount);

        // Update staking Balance
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        //Add user to stakers array only if they haven't staked
        if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        // updating staking status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }


    //2. Issuing Tokens
    function issueTokens() public {
        require(msg.sender == owner, "caller must be owner");
        for(uint i=0; i<stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if(balance > 0) {
                dappToken.transfer(recipient, balance);
            }      
        }
    }

    // Unstaking Tokens (Withdrawn)
    function unstakeTokens() public {
        //Fetch staking balnce
        uint balance = stakingBalance[msg.sender];

        // Require amount greater than 0
        require(balance > 0, "staking balance cannot be 0");

        // Transfer Mock Dai tokens to this contract for staking
        daiToken.transfer(msg.sender, balance);

        //Update staking balance
        stakingBalance[msg.sender] = 0;

        // Reset staking balance
        isStaking[msg.sender] = false;
    }
}
