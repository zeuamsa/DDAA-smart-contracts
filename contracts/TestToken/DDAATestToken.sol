// SPDX-License-Identifier: None
pragma solidity ^0.8.0;

import { SolidStateERC20 } from "@solidstate/contracts/token/ERC20/SolidStateERC20.sol";
import { OwnableInternal } from "@solidstate/contracts/access/ownable/OwnableInternal.sol";
import { ERC20MetadataStorage } from "@solidstate/contracts/token/ERC20/metadata/ERC20MetadataStorage.sol";
import { IDDAATestToken } from "./IDDAATestToken.sol";

contract DDAATestToken is 
  IDDAATestToken, 
  SolidStateERC20,
  OwnableInternal
{
  using ERC20MetadataStorage for ERC20MetadataStorage.Layout;
  constructor() {
  //Init ERC20
    ERC20MetadataStorage.Layout storage l = ERC20MetadataStorage.layout();

    l.setName("DDAA TEST Token");
    l.setSymbol("DDAA");
    l.setDecimals(0);
  //Set owner
    _transferOwnership(msg.sender);
  }
  
  function mint(address account, uint256 amount)
    external
  //onlyOwner
  {
    _mint(account, amount);
  }

  function mintAdjustedToDecimals(address account, uint256 amount) external {
    _mint(account, amount * (10 ** _decimals()));
  }

  function multiplyByThatToGetOneToken() external view returns(uint256) {
    return (10 ** _decimals());
  }

  function burnMyBalance()
    external
  //onlyOwner
  {
    _burn(msg.sender, _balanceOf(msg.sender));
  }
}