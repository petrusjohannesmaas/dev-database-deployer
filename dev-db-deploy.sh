#!/bin/bash

# Handle CTRL+C gracefully
trap 'echo -e "\nOperation cancelled. No containers were deployed."; exit 1' SIGINT

echo "Select a database to deploy:"
echo "1) MongoDB"
echo "2) PostgreSQL"
echo "3) MariaDB"
read -p "Enter the number of your choice: " choice

case $choice in
    1)
        read -p "Enter a container name for MongoDB: " mongo_name
        read -p "Enter the port number for MongoDB: " mongo_port
        podman run -d --name "$mongo_name" -p "$mongo_port":27017 docker.io/library/mongo
        echo "MongoDB container '$mongo_name' deployed on port $mongo_port"
        ;;
    2)
        read -p "Enter a container name for PostgreSQL: " pg_name
        read -p "Enter the port number for PostgreSQL: " pg_port
        read -p "Enter a database name for PostgreSQL: " pg_db
        read -p "Enter a username for PostgreSQL: " pg_user
        read -sp "Enter a password for PostgreSQL: " pg_password
        echo "" # Adds a new line after hidden password input
        podman run -d --name "$pg_name" -e POSTGRES_USER="$pg_user" -e POSTGRES_PASSWORD="$pg_password" -e POSTGRES_DB="$pg_db" -p "$pg_port":5432 docker.io/library/postgres
        echo "PostgreSQL container '$pg_name' deployed on port $pg_port with database '$pg_db'"
        ;;
    3)
        read -p "Enter a container name for MariaDB: " mariadb_name
        read -p "Enter the port number for MariaDB: " mariadb_port
        read -sp "Enter the root password for MariaDB: " mariadb_password
        echo "" # Adds a new line after hidden password input
        podman run -d --name "$mariadb_name" -e MARIADB_ROOT_PASSWORD="$mariadb_password" -p "$mariadb_port":3306 docker.io/library/mariadb
        echo "MariaDB container '$mariadb_name' deployed on port $mariadb_port"
        ;;
    *)
        echo "Invalid selection. Please try again."
        ;;
esac
