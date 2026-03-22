# 🚀 TechFlow Task Manager: CI/CD Artifact Management with Jenkins & Nexus

This repository demonstrates a complete, production-ready Continuous Integration and Continuous Deployment (CI/CD) pipeline. It automates the process of fetching code, compiling, testing, packaging, and securely deploying the built Java artifacts (`.war`/`.jar`) to a centralized **Sonatype Nexus3** repository using **Jenkins** and **Docker**.

---

## 🛠️ Tech Stack & Infrastructure

- **Cloud Provider:** AWS EC2 (Ubuntu 24.04, t2.large, 28GB EBS)
- **CI/CD Server:** Jenkins
- **Containerization:** Docker
- **Artifact Repository:** Sonatype Nexus Repository Manager 3
- **Build Tool:** Apache Maven
- **Language:** Java (JDK 17 / JDK 21)

---

## 📋 Prerequisites

Before starting, ensure your AWS EC2 instance has the following inbound security group ports open:

- `22` (SSH)
- `8080` (Jenkins Default)
- `8081` (Nexus Default)
- `80`, `443` (HTTP/HTTPS)

---

## 🚀 Step-by-Step Installation & Configuration Guide

---

### 🔹 Phase 1: Environment Setup & Jenkins Installation

Connect to your EC2 instance via SSH (e.g., MobaXTerm) and run:

```bash
# Update packages and install Java
sudo apt update
sudo apt install openjdk-17-jre-headless -y

# Add Jenkins repository and install
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
| sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins -y
```
### 👉 Access Jenkins:
```
http://<YOUR_EC2_PUBLIC_IP>:8080
```
## Phase 2: Docker Installation
```
# Install dependencies
sudo apt-get update
sudo apt-get install ca-certificates curl -y

# Add Docker GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
-o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repo
echo "deb [arch=$(dpkg --print-architecture) \
signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io \
docker-buildx-plugin docker-compose-plugin -y
```
## Phase 3: Sonatype Nexus Setup via Docker
```
sudo docker run -d --name nexus3 -p 8081:8081 sonatype/nexus3
```
### 🔑 Get Initial Admin Password
```
sudo docker exec -it nexus3 /bin/bash
cat sonatype-work/nexus3/admin.password
exit
```

### 👉 Access Nexus:
```
http://<YOUR_EC2_PUBLIC_IP>:8081
```
 ● Login: admin
 ● Use retrieved password
 ● Set new password
 ● Enable anonymous access


## ⚙️ Phase 4: Jenkins Plugin & Tool Configuration
### 🔌 Install Plugins

#### Go to:
Manage Jenkins → Plugins → Available

#### Install:
● Config File Provider
● Maven Integration
● Eclipse Temurin Installer
● Pipeline Maven Integration

## 🧰 Configure Tools

#### Go to:
Manage Jenkins → Tools

● JDK
  ● Name: jdk17
  ● Version: jdk-17.0.11+9
● Maven
  ● Name: maven3
  ● Version: Latest

## 🔐 Configure Nexus Credentials

#### Go to:
Manage Jenkins → Managed Files
Add Global Maven settings.xml:
```
<servers>
    <server>
        <id>maven-releases</id>
        <username>admin</username>
        <password>YOUR_NEXUS_PASSWORD</password>
    </server>
    <server>
        <id>maven-snapshots</id>
        <username>admin</username>
        <password>YOUR_NEXUS_PASSWORD</password>
    </server>
</servers>
```

## 📦 Phase 5: Application Configuration (pom.xml)

Add this block:
```
<distributionManagement>
    <repository>
        <id>maven-releases</id>
        <url>http://<YOUR_NEXUS_IP>:8081/repository/maven-releases/</url>
    </repository>
    <snapshotRepository>
        <id>maven-snapshots</id>
        <url>http://<YOUR_NEXUS_IP>:8081/repository/maven-snapshots/</url>
    </snapshotRepository>
</distributionManagement>
```

## 🚀 Phase 6: Jenkins Pipeline (Jenkinsfile)
```
pipeline {
    agent any

    tools {
        maven 'maven3'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'master',
                url: 'https://github.com/15Vaibhavparte/Techflow-Task-Manager.git'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Deploy Artifacts') {
            steps {
                withMaven(
                    globalMavenSettingsConfig: 'settings.xml',
                    jdk: 'jdk17',
                    maven: 'maven3',
                    traceability: true
                ) {
                    sh 'mvn deploy'
                }
            }
        }
    }
}
```

## 🔧 Troubleshooting: Nexus Deployment Policies
If you redeploy the same version (e.g., 0.0.2), Nexus blocks it by default.

✅ Fix (For Testing Only)
Go to Nexus → Settings (⚙️) → Repositories
Select maven-releases
Change:
Layout Policy: Permissive
Deployment Policy: Allow redeploy
Save
🎯 Summary

This pipeline automates:

Code checkout from GitHub
Compilation & testing
Packaging artifacts
Deployment to Nexus repository

It provides a production-ready CI/CD workflow using Jenkins, Docker, and Nexus.


---








