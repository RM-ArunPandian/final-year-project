# CreditToken - A Blockchain-Based Lending Framework

## 🎥 Project Demo
[![Project Demo](https://img.shields.io/badge/Watch-Project%20Demo-red?style=for-the-badge&logo=youtube)](https://www.youtube.com/watch?v=QpSz40UdMBo)

## 📌 Overview
CreditToken is an Ethereum-based lending framework that enables secure and trustless digital asset lending using Non-Fungible Tokens (NFTs) as loan collateral. This project leverages **Smart Contracts, ERC-20 Tokens, and KYC Verification** to ensure transparent and decentralized lending operations.

## 🚀 Features
- **KYC Verification**: Ensures that only verified users can participate in lending/borrowing.
- **Loan Issuance**: Lenders can issue loans to borrowers based on predefined terms.
- **Allowance & Approval Mechanism**: ERC-20 token approvals ensure safe fund transfers.
- **Loan Acceptance & Transfer**: Borrowers can accept loans and receive funds instantly.
- **Loan Repayment**: Borrowers repay principal + interest, securely returning funds to lenders.
- **NFT-Based Loan Representation**: Loans are mapped to unique NFTs that are burned upon repayment.
- **Loan Cancellation**: Lenders can cancel loans before they are accepted by borrowers.
- **Loan Default Management**: If a borrower fails to repay on time, the loan is marked as defaulted.

## 🏗️ Technologies Used
- **Solidity (v0.8.0)** - Smart contract development
- **OpenZeppelin** - Secure contract implementation (ERC-20, Ownable, SafeERC20)
- **Ethereum Blockchain** - Smart contract deployment
- **Remix IDE** - Smart contract testing and deployment
- **Metamask & Web3.js** - Interacting with the blockchain

## 📜 Smart Contract Details
### CreditToken.sol
#### 📌 Functions & Flow
- **KYC Verification**
  - `verifyKYC(user)` → Marks a user as KYC-verified.
- **Loan Lifecycle**
  - `issueLoan(borrower, amount, interest, terms)` → Lender issues a loan.
  - `acceptLoan(loanId)` → Borrower accepts the loan and receives funds.
  - `repayLoan(loanId)` → Borrower repays the loan (principal + interest).
  - `checkDefault(loanId)` → Checks if the loan has defaulted.
- **NFT Loan Management**
  - `burnNFT(nftTokenId)` → Burns the NFT when a loan is repaid.
  - `isNFTBurned(nftTokenId)` → Checks if an NFT is burned.
- **Allowance & Fund Management**
  - `approve(spender, amount)` → Allows contract to transfer tokens on user’s behalf.
  - `allowance(owner, spender)` → Returns approved token amount.
  - `_safeTransfer(from, to, amount)` → Ensures secure ERC-20 transfers.
  - `_safeTransferFrom(from, to, amount)` → Handles approved token transfers.

## 📄 Events
| Event | Description |
|-------|-------------|
| `LoanIssued` | A new loan has been issued. |
| `LoanAccepted` | A loan has been accepted by the borrower. |
| `LoanRepaid` | A loan has been fully repaid. |
| `LoanCanceled` | A lender canceled a loan before acceptance. |
| `DefaultedLoan` | The loan has defaulted due to missed repayment. |
| `KYCVerified` | A user has been verified for KYC. |
| `NFTBurned` | The NFT associated with a loan has been burned. |

## 📌 How to Use
### 1️⃣ Deploy Smart Contract Using Remix IDE
- Open [Remix IDE](https://remix.ethereum.org/)
- Create a new Solidity file and paste the `CreditToken.sol` contract.
- Compile the contract using **Solidity v0.8.0**.
- Deploy the contract using **Injected Web3 (Metamask)** on a testnet like Rinkeby.

### 2️⃣ Interact with the Contract
Use Remix's **Deployed Contracts** section to call functions such as `issueLoan`, `acceptLoan`, and `repayLoan`.

## 🔒 Security Considerations
- Uses **OpenZeppelin’s SafeERC20** to prevent reentrancy attacks.
- Ensures **only verified users** can access loan services.
- Implements **strict approval checks** to prevent unauthorized fund movements.

## 🛠️ Future Enhancements
- Implement **Dynamic Interest Rates**.
- Introduce **Liquidation Mechanisms** for defaulted loans.
- Enable **Cross-Chain Loan Support**.

## 🏆 Contributors
- **Arun Pandian** - [GitHub](https://github.com/arunpandian)

## 📜 License
This project is licensed under the **MIT License**.

---
🌟 **If you found this useful, don’t forget to ⭐ the repository!**

