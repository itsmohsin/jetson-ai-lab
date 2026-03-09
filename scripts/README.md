# 🚀 Jetson Scripts

Utility scripts for optimizing **NVIDIA Jetson Nano** for Edge AI workloads.

---

## 📜 jetson_full_optimize.sh

Optimizes Jetson Nano 2GB for **headless machine learning development**.

### ✨ Features

- 🧹 Removes unnecessary GUI packages
- ⚡ Enables maximum performance mode
- 🔧 Disables unused services
- 🖥 Switches system to headless boot
- 📦 Cleans unused packages

---

## ▶️ How to Run

Follow the steps below to run the optimization script on your Jetson device.

### 1️⃣ Clone the repository
```bash

git clone https://github.com/itsmohsin/jetson-ai-lab.git
```

### 2️⃣ Navigate to the scripts directory
```
cd jetson-ai-lab/scripts
```
### 3️⃣ Make the script executable
```
chmod +x jetson_full_optimize.sh
```
### 4️⃣ Run the script
```
./jetson_full_optimize.sh
```
### 🔄 Reboot After Running

It is recommended to reboot the system after the optimization process completes.
```
sudo reboot
```
