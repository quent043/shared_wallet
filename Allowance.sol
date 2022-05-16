pragma solidity ^0.8.7;
//SPDX-License-Identifier: UNLICENSED

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";


contract Allowance is Ownable {
    using SafeMath for uint;

    event AllowanceChanged(address indexed _forWho, address indexed _fromWhome, uint _oldAmount, uint _newAmount);
    
    mapping(address => uint) public allowance;

    function setAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, _msgSender(), allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    function reduceAllowance(address _who, uint _amount) internal {
        emit AllowanceChanged(_who, _msgSender(), allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }

    function renounceOwnership() public pure override(Ownable) {
        revert("This functionnality does not exist in this Smart Contract.");
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[_msgSender()] >= _amount, "You are not allowed to get Le Pognon");
        _;
    }
}
