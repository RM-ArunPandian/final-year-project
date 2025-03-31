// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract CreditToken is ERC20, Ownable {
    using SafeERC20 for ERC20;

    uint256 public nextTokenId = 1;

    struct Loan {
        address borrower;
        address lender;
        uint256 amount;
        uint256 interestAmount;
        uint256 loanDuration;
        uint256 dueDate;
        bool repaid;
        bool accepted;
        bool canceled;
        uint256 nftTokenId;
        bool isNFTBurned;
        string terms;
    }

    mapping(uint256 => Loan) public loans;
    mapping(address => bool) public kycVerified;
    uint256 public nextLoanId = 1;

    event LoanIssued(uint256 loanId, address borrower, address lender, uint256 amount, uint256 interestAmount, uint256 nftTokenId, uint256 dueDate, string terms);
    event LoanAccepted(uint256 loanId);
    event LoanRepaid(uint256 loanId);
    event LoanCanceled(uint256 loanId);
    event DefaultedLoan(uint256 loanId);
    event KYCVerified(address indexed user);
    event NFTBurned(uint256 nftTokenId);

    constructor() ERC20("CreditToken", "CRD") Ownable(msg.sender) {
        uint256 initialSupply = 1_000_000_000;
        _mint(msg.sender, initialSupply);
    }

    function verifyKYC(address user) external onlyOwner {
        kycVerified[user] = true;
        emit KYCVerified(user);
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    function issueLoan(
        address borrower,
        uint256 amount,
        uint256 interestAmount,
        string memory terms
    ) external returns (uint256) {
        require(kycVerified[borrower], "Borrower must be KYC verified");
        require(balanceOf(msg.sender) >= amount, "Insufficient funds");
        require(allowance(msg.sender, address(this)) >= amount, "Allowance is not enough");

        uint256 loanDuration = 30;
        _safeTransferFrom(msg.sender, address(this), amount);
        uint256 nftTokenId = nextTokenId++;
        uint256 loanId = nextLoanId++;

        loans[loanId] = Loan({
            borrower: borrower,
            lender: msg.sender,
            amount: amount,
            interestAmount: interestAmount,
            loanDuration: loanDuration,
            dueDate: block.timestamp + (loanDuration * 1 days),
            repaid: false,
            accepted: false,
            canceled: false,
            nftTokenId: nftTokenId,
            isNFTBurned: false,
            terms: terms
        });

        emit LoanIssued(loanId, borrower, msg.sender, amount, interestAmount, nftTokenId, block.timestamp + (loanDuration * 1 days), terms);
        return nftTokenId;
    }

    function acceptLoan(uint256 loanId) external {
        Loan storage loan = loans[loanId];
        require(msg.sender == loan.borrower, "Only borrower can accept");
        require(!loan.accepted, "Loan already accepted");
        loan.accepted = true;
        _safeTransfer(loan.borrower, loan.amount);
        emit LoanAccepted(loanId);
    }

    function repayLoan(uint256 loanId) external {
        Loan storage loan = loans[loanId];
        require(msg.sender == loan.borrower, "Only borrower can repay");
        require(loan.accepted, "Loan must be accepted first");
        require(!loan.repaid, "Loan already repaid");

        uint256 totalAmount = loan.amount + loan.interestAmount;
        _safeTransferFrom(msg.sender, loan.lender, totalAmount);
        loan.repaid = true;
        burnNFT(loan.nftTokenId);
        emit LoanRepaid(loanId);
    }

    function burnNFT(uint256 nftTokenId) internal {
        for (uint256 i = 1; i < nextLoanId; i++) {
            if (loans[i].nftTokenId == nftTokenId) {
                loans[i].isNFTBurned = true;
                emit NFTBurned(nftTokenId);
                break;
            }
        }
    }

    function isNFTBurned(uint256 nftTokenId) external view returns (bool) {
        for (uint256 i = 1; i < nextLoanId; i++) {
            if (loans[i].nftTokenId == nftTokenId) {
                return loans[i].isNFTBurned;
            }
        }
        return false;
    }

    function cancelLoan(uint256 loanId) external {
        Loan storage loan = loans[loanId];
        require(msg.sender == loan.lender, "Only lender can cancel");
        require(!loan.canceled, "Loan already cancelled");
        require(!loan.accepted, "Cannot cancel an accepted loan");
        _safeTransfer(msg.sender, loan.amount);
        loan.canceled = true;
        emit LoanCanceled(loanId);
    }

    function checkDefault(uint256 loanId) external {
        Loan storage loan = loans[loanId];
        require(block.timestamp > loan.dueDate, "Loan is still within repayment period");
        require(!loan.repaid, "Loan already repaid");
        loan.canceled = true;
        emit DefaultedLoan(loanId);
    }

    function timeUntilDue(uint256 loanId) external view returns (uint256) {
        Loan storage loan = loans[loanId];
        if (block.timestamp >= loan.dueDate) {
            return 0;
        } else {
            return loan.dueDate - block.timestamp;
        }
    }

    function _safeTransferFrom(address from, address to, uint256 amount) internal {
        ERC20(address(this)).safeTransferFrom(from, to, amount);
    }

    function _safeTransfer(address to, uint256 amount) internal {
        ERC20(address(this)).safeTransfer(to, amount);
    }
}
