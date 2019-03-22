pragma solidity ^0.4.23;

import "./tokens/TRC20/TRC20.sol";

contract Token is TRC20 {

  uint256 constant BASE_ = 1e6;
  ITRC20 constant public Token = ITRC20(0x419fc6e2d070d01e73474d473b32e418c7cd9d5d5b);

  string private name_;
  string private symbol_;
  uint8 private decimals_;

  address public administrator_;

  modifier onlyAdministrator () {
    require (msg.sender == administrator_);
    _;
  }

  constructor () public {
      name_ = "New TronFun Token";
      symbol_ = "NFUN";
      decimals_ = 6;

      administrator_ = msg.sender;

      _mint(administrator_, BASE_.mul(10000000000));
  }

  /**
   * @return the name of the token.
   */
  function name() public view returns (string) {
      return name_;
  }

  /**
   * @return the symbol of the token.
   */
  function symbol() public view returns (string) {
      return symbol_;
  }

  /**
   * @return the number of decimals of the token.
   */
  function decimals() public view returns (uint8) {
      return decimals_;
  }

  function exchange(uint256 _tokens) public returns (bool) {
    address _pAddr = msg.sender;

    bool result = Token.transferFrom(_pAddr, address(this), _tokens);
    require (result);

    _transfer(administrator_, _pAddr, _tokens);
    return true;
  }

  function setAdministrator (address _pAddr) public onlyAdministrator returns (bool) {
    administrator_ = _pAddr;
    return true;
  }

  function withdrawTeamPot (uint256 _value) public onlyAdministrator returns (bool) {
    msg.sender.transfer(_value);
    return true;
  }
  
}
