# PRNG-Based Data Encryption & Decryption

## 📌 Overview
This project implements a pseudo-random number generator (PRNG) based
data encryption and decryption system using XOR logic. The design is
verified using a golden reference model and a self-checking testbench.

## 🔐 Encryption Technique
- PRNG generated using LFSR
- Encryption/Decryption using XOR operation
- Same logic supports encryption and decryption

## 🧩 Modules
- `top_prng` – RTL encryption engine (DUT)
- `prng_golden_module` – Reference model for verification
- `RTL_engin_golden_model_DV_engin_tb` – Self-checking testbench

## 🛠 Tools Used
- Verilog HDL
- Simulator: ModelSim / Questa / Xcelium / EDA Playground

## 🧪 Verification
RTL output is continuously compared with the golden model output.
Pass/fail statistics are printed automatically.

## ⚠️ Note
This implementation is intended for learning and verification purposes
and does not represent a secure cryptographic algorithm.

## 👤 Author
Shyam
