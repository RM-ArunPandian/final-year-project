// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LoanNFT is ERC721, Ownable {
    // Loan data stored in the NFT contract
    address public borrower;
    address public lender;
    uint256 public amount;
    uint256 public interestAmount;
    uint256 public loanDuration;  // in days
    uint256 public dueDate;       // timestamp
    string public terms;

    uint256 public tokenId;

    constructor(
        address _borrower,
        address _lender,
        uint256 _amount,
        uint256 _interestAmount,
        uint256 _loanDuration,
        uint256 _dueDate,
        string memory _terms,
        uint256 _tokenId,
        address initialOwner
    ) ERC721("LoanNFT", "LNFT") Ownable(initialOwner) {
        borrower = _borrower;
        lender = _lender;
        amount = _amount;
        interestAmount = _interestAmount;
        loanDuration = _loanDuration;
        dueDate = _dueDate;
        terms = _terms;
        tokenId = _tokenId;

        _mint(initialOwner, tokenId);
    }

    // Burn NFT by transferring ownership to zero address (burn ownership)
    function burn() external onlyOwner {
        _transferOwnership(address(0));
    }
}
