# 💳 CreditToken - A Blockchain-Based Lending Framework

## 🎥 Project Demo
[![Project Demo](https://img.shields.io/badge/Watch-Project%20Demo-red?style=for-the-badge&logo=youtube)](https://www.youtube.com/watch?v=QpSz40UdMBo)

## 📌 Overview
**CreditToken** is an Ethereum-based decentralized lending framework that combines **ERC-20 tokens**, **ERC-721 NFTs**, and **smart contracts** to enable a transparent, verifiable, and automated loan issuance system. Every loan is minted as a unique NFT, serving as collateralized proof of the agreement.

## 🚀 Features
- ✅ **KYC Verification**: Only verified users can lend or borrow.
- 🔐 **Tokenized Loan Contracts**: Each loan is minted as a unique ERC-721 NFT representing the loan agreement.
- 💰 **Secure Lending**: Loans are issued using ERC-20 tokens with proper allowance checks.
- 📜 **NFT Lifecycle**:
  - NFT is minted at loan issuance.
  - NFT is owned by the smart contract (escrow).
  - NFT is burned (sent to `0x0`) after repayment.
- 🤝 **Loan Lifecycle**:
  - Issue → Accept → Repay → Burn NFT.
- ❌ **Cancellation**: Lender can cancel before acceptance.
- ⚠️ **Defaults**: Loans not repaid by due date are marked defaulted.

## 🧱 Architecture

- `CreditToken.sol` – The main ERC-20 lending logic + KYC + loan management + NFT minting.
- `LoanNFT.sol` – Minimal ERC-721 NFT representing each loan, deployed by `CreditToken` contract.

## 🏗️ Technologies Used
- **Solidity (v0.8.x)** – Smart contract language
- **OpenZeppelin Contracts** – Industry-standard library for ERC-20, ERC-721, and ownership
- **Remix IDE** – Development and testing
- **Metamask + Web3.js** – Blockchain interactions

---

## 📜 Smart Contract Details

### 🔹 CreditToken.sol (Main Logic)
#### Core Functions:
- `verifyKYC(user)` → Verify a user
- `issueLoan(borrower, amount, interest, terms)` → Issues a loan + mints a LoanNFT
- `acceptLoan(loanId)` → Borrower accepts and receives funds
- `repayLoan(loanId)` → Repays the loan, triggers NFT burn
- `cancelLoan(loanId)` → Cancel unaccepted loan
- `checkDefault(loanId)` → Mark loan as defaulted if overdue
- `timeUntilDue(loanId)` → Returns time until loan is due

### 🔹 LoanNFT.sol (ERC-721 NFT)
- Auto-deployed during loan issuance
- Stores loan details per tokenId
- NFT is owned by `CreditToken` contract until repaid
- On repayment, NFT is burned by transferring to `0x000...dEaD`

---

## 🧾 Events

| Event | Description |
|-------|-------------|
| `LoanIssued` | Loan created + NFT minted |
| `LoanAccepted` | Borrower accepted the loan |
| `LoanRepaid` | Loan repaid fully |
| `LoanCanceled` | Loan canceled by lender |
| `DefaultedLoan` | Loan defaulted due to timeout |
| `KYCVerified` | User verified for KYC |
| `NFTBurned` | Loan NFT burned post repayment |

---

## ⚙️ How to Use

### 1️⃣ Deploy with Remix IDE
- Load both `CreditToken.sol` and `LoanNFT.sol`
- Compile using **Solidity 0.8.x**
- Deploy `CreditToken.sol`
- Loan NFTs will be automatically deployed when a loan is issued

### 2️⃣ Interact
- Use functions like `verifyKYC`, `issueLoan`, `acceptLoan`, `repayLoan`
- NFTs are auto-managed under the hood

---

## 🔐 Security Practices
- ✅ Uses **SafeERC20** to prevent fund loss
- ✅ All state changes verified with strict checks
- ✅ Burns NFTs to ensure they can't be reused
- ✅ Keeps ownership internal until valid repayment

---

## 🛠️ Future Roadmap

- 🧮 **Dynamic Interest Rates**
- 💎 **NFT Metadata / IPFS Loan Representation**
- ⚖️ **Liquidation Mechanism for Collateral**
- 🌉 **Cross-Chain Lending Support**
- 📊 **Dashboard to View Loan NFTs**

---

## 👨‍💻 Author
- **Arun Pandian**  
  🔗 [GitHub](https://github.com/arunpandian)  
  🌐 Tamil Nadu, India  

---

## 📜 License
MIT License – Use it, build on it, ship it 🚀

---

🌟 **Like the project? Give it a ⭐ and share it with your dev friends!**
