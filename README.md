# Development Database Deploy-er

## Overview
This script allows users to deploy database containers dynamically with customizable names, ports, and environment variables. It currently supports **MongoDB**, **PostgreSQL**, and **MariaDB** using Podman. This is not intended for use in production, I use it mainly for development.

**Note:** You can replace Podman commands with Docker since both adhere to the Open Container Initiative (OCI) standards. Their container runtimes and image formats are compatible, meaning your script should work with minimal adjustments. Just swap podman with docker in commands, and everything should function as expected!

## Features
- Select a database to deploy: **MongoDB, PostgreSQL, or MariaDB**
- Customize container name and port number
- Provide credentials for PostgreSQL and MariaDB
- Secure password input handling
- Simple, interactive command-line interface

Additionally, you can modify the script to deploy databases from your preferred repository by simply changing the image URL used in the podman run or docker run commands. This flexibility allows you to use custom-built images or alternative sources.

## Usage

**⚠️ Make sure Podman is installed on your system**:

```bash
sudo apt install podman
podman --version
```

1. Clone the repository:
   ```bash
   git clone https://github.com/petrusjohannesmaas/dev-database-deployer
   cd dev-database-deployer
   ```
2. Make the script executable:
   ```bash
   chmod +x dev-db-deploy.sh
   ```

3. Run the script:
   ```bash
   ./dev-db-deploy.sh
   ```

4. Follow the interactive prompts to deploy the desired database container.


## Future improvements
- **Enhanced Error Handling**: Improve robustness and gracefully manage exceptions.
- **Expanded Database Support**: Add Redis support for key-value storage.
- **Additional Configuration Options**: Provide users with more environment variables for fine-tuned deployments.


## Troubleshooting with Podman

If you encounter issues while deploying database containers with Podman, here are some common problems and solutions:

### 1️⃣ **Podman Command Not Found**
**Issue:** Running `podman` results in a "command not found" error.  
**Solution:** Ensure Podman is installed properly:
```bash
sudo apt install podman  # Debian/Ubuntu
sudo dnf install podman  # Fedora
sudo yum install podman  # CentOS
brew install podman      # macOS (Homebrew)
```
Verify installation with:
```bash
podman --version
```

### 2️⃣ **Containers Not Starting**
**Issue:** After running the script, containers fail to start.  
**Solution:** Check container logs and status:
```bash
podman ps -a  # View all containers
podman logs <container_name>  # Check logs of a specific container
```
Ensure the correct image is pulled by running:
```bash
podman images
```
If needed, try pulling the latest version:
```bash
podman pull docker.io/library/mongo
```

### 3️⃣ **Port Conflicts**
**Issue:** The port you specified is already in use.  
**Solution:** Find active processes using the port:
```bash
sudo netstat -tulnp | grep <port_number>
```
If necessary, use a different port or stop the conflicting service.

### 4️⃣ **Podman vs Docker Compatibility**
**Issue:** Script works with Docker but fails in Podman.  
**Solution:** Try running the script with Podman in Docker compatibility mode:
```bash
alias docker=podman
```
Ensure Podman uses Docker-like behavior:
```bash
podman --log-level=debug run ...
```