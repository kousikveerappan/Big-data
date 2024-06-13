#!/bin/bash

# Update the package list
sudo apt update

# Install necessary packages
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker's APT repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# Update the package list again with Docker's repository included
sudo apt update

# Install Docker CE
sudo apt install -y docker-ce

echo "==================================================================="
echo "==================================================================="
echo "Checking the status of Docker service"

# Check if Docker service is running
sudo systemctl is-active --quiet docker

if [ $? -eq 0 ]; then
    echo "Docker is running successfully. Starting Jupyter PySpark notebook container..."
    # Run the Jupyter PySpark notebook container
    container_id=$(sudo docker run --detach -p 8888:8888 -p 4040:4040 -p 4041:4041 quay.io/jupyter/pyspark-notebook)
    echo "Jupyter PySpark notebook container started with ID: $container_id"

    # Check if the pyspark-notebook container is running and healthy
    container_status=$(sudo docker inspect --format='{{.State.Health.Status}}' $container_id)
    if [ "$container_status" == "healthy" ]; then
        echo "pyspark-notebook container is running and healthy. Fetching logs..."
        sudo docker logs $container_id
    else
        echo "===================================================================================="
    fi
else
    echo "Docker is not running. Please check the Docker installation and try again."
    exit 1
fi

