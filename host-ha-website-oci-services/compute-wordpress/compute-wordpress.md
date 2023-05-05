# Provisioning a Compute Instances and Installing WordPress

## Introduction

This lab will walk you through how to create a new compute instance to host your WordPress site and how to connect to it using the Bastion host created in the previous lab. You will also shown how to connect to the WordPress web page by using the Load Balancer also created in a previous lab.

Estimated Lab Time: -- minutes

### Objectives

In this lab, you will:
* Connect to a Compute instance in a private subnet using the Bastion host
* Install WordPress

### Prerequisites

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Provisioning a Compute Instance to host WordPress

## Task 2: Connecting to your WordPress Instance

## Task 3: Installing Apache

1. Install Apache app server



    Once you are connected to your WordPress instance, use the following commands to install Apache:
    ```
    <copy>sudo yum install httpd -y</copy>
    ```

    ```
    <copy>sudo systemctl enable httpd</copy>
    ```

    ```
    <copy>sudo systemctl restart httpd</copy>
    ```

    ```
    <copy>sudo firewall-cmd --permanent --add-port=80/tcp</copy>
    ```

    ```
    <copy>sudo firewall-cmd --reload</copy>
    ```

2. Test the Apache Server using the [...] on your Web Browser



    Example: http://10.10.10.10

    ![Image alt text](images/sample1.png)

## Task 4. Install PHP

1. Install php
    ```
    <copy>sudo dnf module install php:7.4 -y</copy>
    ```

    ```
    <copy>sudo yum install php-cli php-mysqlnd php-zip php-gd php-mbstring php-xml php-json -y</copy>
    ```

    ```
    <copy>php -v</copy>
    ```

    ```
    <copy>php -m |grep mysql</copy>
    ```

    ```
    <copy>sudo systemctl restart httpd</copy>
    ```

2. Create a test PHP file (info.php)
    ```
    <copy>sudo nano /var/www/html/info.php</copy>
    ```

3. Add the following code to the editor and save the file (ctr + o) (ctl + x)
    ```
    <copy><?php
    phpinfo();
    ?></copy>
    ```

4. Test the info.php page on your web browser

    Example: http://10.10.10.10/info.php

  ![Image alt text](images/sample1.png)

## Task 5. Install WordPress

1. Install required packages
  ```
  <copy>sudo yum install -y php-mysqlnd php-zip php-gd php-mcrypt php-mbstring php-xml php-json</copy>
  ```

  ```
  <copy>sudo systemctl restart httpd</copy>
  ```

2. Download the latest WordPress
  ```
  <copy>curl -O https://wordpress.org/latest.tar.gz</copy>
  ```

3. Extract latest.tar.gz to /var/www/html (Apache document root).
  ```
  <copy>sudo tar zxf latest.tar.gz -C /var/www/html/ --strip 1</copy>
  ```

4. Adjust ownership.
  ```
  <copy>sudo chown apache. -R /var/www/html/</copy>
  ```

5. Create upload directory, adjust ownership.
  ```
  <copy>sudo mkdir /var/www/html/wp-content/uploads</copy>
  ```

  ```
  <copy>sudo chown apache:apache /var/www/html/wp-content/uploads</copy>
  ```

6. Adjust SE Linux.
  ```
  <copy>sudo chcon -t httpd_sys_rw_content_t /var/www/html -R</copy>
  ```

7. Allow Apache to connect to an external database.
  ```
  <copy>sudo setsebool -P httpd_can_network_connect_db 1</copy>
  ```

## Task 6. Install MySQL Shell, and create the WordPress user and database

1. Install MySQL Shell and setup wordpress database
  ```
  <copy>sudo yum -y install mysql-shell</copy>
  ```

2. Connect to the MySql database service using MySQL Shell.
  ```
  <copy>mysqlsh --sql -u admin -h <MDS end point IP></copy>
  ```

3. Create WordPress database and user.
  ```
  <copy>create database wordpress;</copy>
  ```

  ```
  <copy>create user wp IDENTIFIED BY 'Welcome#12345';</copy>
  ```

  ```
  <copy>GRANT ALL PRIVILEGES ON wordpress.* To wp;</copy>
  ```

  ```
  <copy>\q</copy>
  ```

## Task 7. Configure WordPress

1. From a browser access http://instance public IP/wp-admin/setup-config.php.

2. Click Let’s Go.

3. Fill the following information:



    - Database Name: database you created for WordPress
    - Username: Your database username
    - Password: Your database password
    - Database Host: MySQL Database Service IP address
    - Table Prefix: leave as is. only need to change if multiple WordPress running on the same database

4. Click Run the installation.

5. Fill the following information in the welcome screen:



    - Site Title: WordPress site title
    - Username: WordPress admin
    - Password: WordPress admin password
    - Your Email: your email
    - Click Install WordPress.


    You may now follow the instructions on:
      * First Steps with WordPress: https://wordpress.org/documentation/article/first-steps-with-wordpress-block-editor/

## Acknowledgements
* **Author** - <Name, Bernie Castro, Cloud Engineer>
* **Last Updated By/Date** - <Bernie Castro, May 2023>
