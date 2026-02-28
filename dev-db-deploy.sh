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
        read -p "Enter a container name for MongoDB [default: mongo_db]: " mongo_name
        mongo_name=${mongo_name:-mongo_db}

        read -p "Enter the port number for MongoDB [default: 27017]: " mongo_port
        mongo_port=${mongo_port:-27017}

        docker run -d --name "$mongo_name" -p "$mongo_port":27017 mongo
        echo "MongoDB container '$mongo_name' deployed on port $mongo_port"
        ;;
    2)
        read -p "Enter a container name for PostgreSQL [default: postgres_db]: " pg_name
        pg_name=${pg_name:-postgres_db}

        read -p "Enter the port number for PostgreSQL [default: 5432]: " pg_port
        pg_port=${pg_port:-5432}

        read -p "Enter a database name for PostgreSQL [default: mydb]: " pg_db
        pg_db=${pg_db:-mydb}

        read -p "Enter a username for PostgreSQL [default: postgres]: " pg_user
        pg_user=${pg_user:-postgres}

        read -sp "Enter a password for PostgreSQL [default: postgres]: " pg_password
        pg_password=${pg_password:-postgres}
        echo "" # Adds a new line after hidden password input

        docker run -d --name "$pg_name" \
            -e POSTGRES_USER="$pg_user" \
            -e POSTGRES_PASSWORD="$pg_password" \
            -e POSTGRES_DB="$pg_db" \
            -p "$pg_port":5432 postgres
        echo "PostgreSQL container '$pg_name' deployed on port $pg_port with database '$pg_db'"
        ;;
    3)
        read -p "Enter a container name for MariaDB [default: mariadb_db]: " mariadb_name
        mariadb_name=${mariadb_name:-mariadb_db}

        read -p "Enter the port number for MariaDB [default: 3306]: " mariadb_port
        mariadb_port=${mariadb_port:-3306}

        read -sp "Enter the root password for MariaDB [default: mariadb]: " mariadb_password
        mariadb_password=${mariadb_password:-mariadb}
        echo "" # Adds a new line after hidden password input

        docker run -d --name "$mariadb_name" \
            -e MARIADB_ROOT_PASSWORD="$mariadb_password" \
            -p "$mariadb_port":3306 mariadb
        echo "MariaDB container '$mariadb_name' deployed on port $mariadb_port"
        ;;
    *)
        echo "Invalid selection. Please try again."
        ;;
esac
