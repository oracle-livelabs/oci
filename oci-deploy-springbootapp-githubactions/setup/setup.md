# GitHub Project Setup

## Introduction

This lab walks you through the steps to clone a GitHub repository, configure Git authentication using SSH, and open the project in IntelliJ IDEA for local development.

Estimated Lab Time: 15–20 minutes

### About <GitHub> 

GitHub is a distributed version control platform widely used for source code management and collaboration. In this lab, you will prepare a local development environment by securely connecting to GitHub using SSH, cloning a repository, and verifying Git integration inside IntelliJ IDEA.

### Objectives

In this lab, you will:
* Configure GitHub authentication using SSH
* Clone the GitHub repository to your local machine
* Open the project in IntelliJ IDEA

### Prerequisites

This lab assumes you have:
* An active GitHub account
* IntelliJ IDEA installed (Community or Ultimate edition)
* Basic familiarity with the command line


## Task 1: Git Install
Run all the commands in Git Bash/Cmd/PowerShell/Terminal.

1. Check if you already have Git installed.
<br>
```
   git --version 
```
If not:

- Windows: https://git-scm.com/download/win

- macOS:
```
 brew install git 
```
- Linux:
```
 sudo apt install git
```
## Task 2: GitHub Configuration 

Identity setup (Used for commits)
<br>
```
   git config --global user.name "Your name"
   git config --global user.email "email@exemplu.com"
```
## Task 3: SSH GitHub Authentification

1. Check if you already have an SSH key
<br>
```
   ls ~/.ssh
```

2. If you do NOT see id_rsa or id_ed25519, generate a new SSH key:
<br>
 ```
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

3. Press Enter for all prompts (default options).

4. Copy the public SSH key
<br>
     ```
   cat ~/.ssh/id_ed25519.pub
   ```
5. Add the SSH key to GitHub

- Go to GitHub → Settings

- Open SSH and GPG keys

- Click New SSH key

- Paste the copied public key

- Save

## Task 4: Clone the repository locally

1. Using SSH (recommended)
   <br>
```
cd ~/projects
git clone https://github.com/mariagoprea-collab/springboot-demo-oci
```
2. Using HTTPS (if not using SSH)
<br>
```
git clone https://github.com/mariagoprea-collab/springboot-demo-oci
```
- A local folder with the repository name will be created.

## Task 5: Open the project in IntelliJ IDEA

1.  Open the existing project

- Open IntelliJ IDEA

- Go to File → Open

- Select the cloned project folder

- Click OK

IntelliJ will automatically detect:

The Git repository

The project type (Maven / Gradle / Java / Spring, etc.)
