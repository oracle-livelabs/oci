# Other Migration Tools, Optional Lab

## Introduction
OCI Object Storage supports an Amazon S3 Compatibility API. Customers who are already familiar with the variety of Amazon S3 tools can continue to use them. 

This lab will explore using the S3cmd  and S5cmd tools to migrate data into OCI Object Storage. 

S3cmd (s3cmd) is a free command line tool and client for uploading, retrieving and managing data in an S3 compatible object store. S3cmd is an open source project written in Python.

S5cmd (s5cmd) is another free, open source project. S5cmd enables browsing and transferring data to/from an S3 compatible  object store. It is written the Go language.

Both S3cmd and S5cmd usage is very similar in command line format, many users report they prefer using the S5cmd because they have found it runs much faster than the S3cmd, OCI OS Object Sync, and Rclone. The S5cmd also provides other userful utilities.

Estimated time: 30 min

### Objectives

In this lab you will:
- Create a Customer secret access key for S3
- Install S3cmd and S5cmd  on your laptop or workstation
- Configure S3cmd and S5cmd  with OCI Object Storage
- Migrate test files from local laptop to OCI Object Storage
- Migrate test files from OCI Object Storage to local laptop filesystem using S3cmd and S5cmd

### Prerequisites

This lab assumes you have:
* Completed all previous labs
* You have access to a Mac OS, Linux laptop/ workstation, or virtual machine/ compute instance
* You have OCI Command Line installed with a working configuration file
* Ability to install software, create files and directories, edit files, and move to different directories on Linux or Mac OS
* Have at least 1 GiB of free space on your laptop or workstation to create test files
* Have Python and Go installed and are familiar with installing tools/ packages for these languages


## Task 1: Create Customer Secret Access Key for S3

Use the OCI CLI to create customer secret access keys

  ```
  <copy>
  oci iam customer-secret-key create --display-name s3lab --user-id <user OCID>
  </copy>
  ```

> **Note:** You can find your user OCID in your OCI CLI configuration file. The OCI CLI configuration file is usually in your home directory/ folder in sub-directory/folder .oci named config, for example: `/home/username/.oci/config`

Example command with expected output:

  ```
  oci iam customer-secret-key create --display-name s3lab --user-id ocid1.user.oc1..aaaaaaaa-user-ocid-sdd6ahdouq
  {
    "data": {
      "display-name": "s3lab",
      "id": "7aaaa3462aa34271a276002015f30674a5325aaa",
      "inactive-status": null,
      "key": "1aaa577aaaa/aa3aa92aa7aa7aaaaaaAa0aaaAa8AAa=",
      "lifecycle-state": "ACTIVE",
      "time-created": "2024-07-19T19:58:03.794000+00:00",
      "time-expires": null,
      "user-id": "ocid1.user.oc1..aaaaaaaa-user-ocid-sdd6ahdouq"
    },
    "etag": "e63038c73fc24fa087a2a4c3339ef709"
  }
  ```

Copy the `id` and `key` strings to another file to use in the next step.

## Task 2: Configure S3 API Credentials for OCI Object Storage

1. In your home directory, create the `.aws` directory

  ```
  <copy>
  mkdir .aws
  </copy>
  ```

2. Create a credentials file in the .aws directory

  ```
  <copy>
  cd .aws
  vim credentals
  </copy>
  ```

> **Note:** Use the editor which works best for your environment such as `vim` , `pico`, `nano`, etc.

The file should have the following contents:

  ```
  <copy>
  [default]
  aws_access_key_id = 7aaaa3462aa34271a276002015f30674a5325aaa
  aws_secret_access_key = 1aaa577aaaa/aa3aa92aa7aa7aaaaaaAa0aaaAa8AAa=
  </copy>
  ```

Replace values based on output from Task 1, use the `id` string for the `aws_access_key_id` and `key` string for the `aws_secret_access_key` 

3. Get the OCI Object Storage namespace for your tenancy

   ```
   <copy>
   oci os ns get
   </copy>
   ```

4. Export the S3 Compatible Endpoint 

Set the environment variable `S3_ENDPOINT_URL`

  ```
   <copy>
   export S3_ENDPOINT_URL=https://<namespace>.compat.objectstorage.<region>.oraclecloud.com
   </copy>
  ```

Replace the namespace with the value from Step 3 and the region with your tenancy home region.

> **Note:** Use the same region identified in your OCI CLI configuration file. The OCI CLI configuration file is usually in your home directory/ folder in sub-directory/folder .oci named config, for example: `/home/username/.oci/config` 

## Task 3 Install S3cmd & S5cmd


1. Install S3cmd and S5cmd 

> **Note:** If you already have a networking environment set up in your tenancy with VCN and networks and can launch compute intances, you can run this lab on an OCI compute instance. Oracle Linux would be recommended, follow relevant directions below.
 
#### For Mac OS X

Open a terminal window and install on Mac OS X with [Homebrew](https://docs.brew.sh/Installation):

  ```
  <copy>
  brew update && brew install s3cmd
  brew install peak/tap/s5cmd
  </copy>
  ```

#### For Linux

Open a terminal
  ```
  <copy>
  sudo yum install python-pip
  sudo pip install s3cmd
  conda config --add channels conda-forge
  conda config --set channel_priority strict
  conda install s5cmd
  </copy>
  ```

> **Note:** For additional operating systems, installation variations, and environments see full details at [Installation of S3cmd](https://github.com/s3tools/s3cmd/blob/master/INSTALL.md) and [S5cmd Installation](https://github.com/peak/s5cmd#installation)

2. Configure S3cmd

Run the following command to setup a `.s3config` file for the S3cmd

  ```
  <copy>
  s3cmd --configure
  </copy>
  ```

Answer the prompts as they come up, the command will read the `Access Key` and `Secret Key` from the `credentials` file set up in Task 2. When prompted for the region, use you tenancy home region in the OCI CLI configuration file, use the string used for the `S3_ENDPOINT_URL` in Task 2 when prompted for the `S3 Endpoint` and `DNS-style bucket+hostname:port template for accessing a bucket`. You can usually accept the defaults after those settings. 

The command run should look like this:

  ```
  s3cmd --configure

  Enter new values or accept defaults in brackets with Enter.
  Refer to user manual for detailed description of all options.

  Access key and Secret key are your identifiers for Amazon S3. Leave them empty for using the env variables.
  Access Key [7aaaa3462aa34271a276002015f30674a5325aaa]: 
  Secret Key [1aaa577aaaa/aa3aa92aa7aa7aaaaaaAa0aaaAa8AAa=]: 
  Default Region [US]: us-ashburn-1

  Use "s3.amazonaws.com" for S3 Endpoint and not modify it to the target Amazon S3.
  S3 Endpoint [namespae.compat.objectstorage.us-ashburn-1.oraclecloud.com]: 

  Use "%(bucket)s.s3.amazonaws.com" to the target Amazon S3. "%(bucket)s" and "%(location)s" vars can be used
  if the target S3 system supports dns based buckets.
  DNS-style bucket+hostname:port template for accessing a bucket [%(bucket)s.s3.amazonaws.com]: namespace.compat.objectstorage.us-ashburn-1.oraclecloud.com

  Encryption password is used to protect your files from reading
  by unauthorized persons while in transfer to S3
  Encryption password: 
  Path to GPG program [None]: 

  When using secure HTTPS protocol all communication with Amazon S3
  servers is protected from 3rd party eavesdropping. This method is
  slower than plain HTTP, and can only be proxied with Python 2.7 or newer
  Use HTTPS protocol [Yes]: 

  On some networks all internet access must go through a HTTP proxy.
  Try setting it here if you can't connect to S3 directly
  HTTP Proxy server name: 

  New settings:
    Access Key: 7aaaa3462aa34271a276002015f30674a5325aaa
    Secret Key: 1aaa577aaaa/aa3aa92aa7aa7aaaaaaAa0aaaAa8AAa=
    Default Region: us-ashburn-1
    S3 Endpoint: namespace.compat.objectstorage.us-ashburn-1.oraclecloud.com
    DNS-style bucket+hostname:port template for accessing a bucket: namespace.compat.objectstorage.us-ashburn-1.oraclecloud.com
    Encryption password: 
    Path to GPG program: None
    Use HTTPS protocol: True
    HTTP Proxy server name: 
    HTTP Proxy server port: 0

  Test access with supplied credentials? [Y/n] Y
  Please wait, attempting to list all buckets...
  Success. Your access key and secret key worked fine :-)

  Now verifying that encryption works...
  Not configured. Never mind.

  Save settings? [y/N] y
  Configuration saved to '/home/username/.s3cfg'
  ```
3. Testing S3cmd and S5cmd

Create a bucket with each command

  ```
  <copy>
  s3cmd mb s3://s3cmd-bucket
  s5cmd mb s3://s5cmd-bucket
  </copy>
  ```

> **Note:** If you could not create the buckets, take another look at your `$HOME/.aws/credentials` file and your `$HOME/.s3config` file  make sure all the parameters are setup correctly for your tenancy. In the `$HOME/.s3config` file check that the values for `host-base` and `host_bucket` are both set to the `S3_ENDPOINT_URL` from Task 2. Also check that the values for `access_key` and `secret_key` are the same values from the OCI CLI output from Task 1 and used in the `$HOME/.aws/credentials` file in Task 2.

## Task 4: Create Test Files

1. Create a test directory or folder to stage the test files on your laptop or workstation

  ```
  <copy>
  cd $HOME
  mkdir migration-files
  </copy>
  ```

2. Create some files

   ```
   <copy>
   for i in {1..10};do echo "This is file ${i}" > $HOME/migration-files/file_${i}.txt;done
   </copy>
   ```

3. Verify the files were created

  ```
  <copy>
   ls $HOME/migration/files
  </copy>
  ```

## Task 4: Migrating Data into an OCI Object Storage Bucket Using S3cmd and S5cmd

1. Use S3cmd to migrate files into the `s3cmd-bucket`

  ```
  <copy>
  s3cmd sync $HOME/migration-files s3://s3cmd-bucket
  </copy>
  ```

Output should look similar to the following:
  ```
  s3cmd sync $HOME/migration-files s3://s3cmd-bucket
  upload: '/home/username/migration-files/file_1.txt' -> 's3://s3cmd-bucket/migration-files/file_1.txt'  [1 of 10]
   15 of 15   100% in    0s    87.51 B/s  done
  upload: '/home/username/migration-files/file_10.txt' -> 's3://s3cmd-bucket/migration-files/file_10.txt'  [2 of 10]
   16 of 16   100% in    0s    65.09 B/s  done
  upload: '/home/username/migration-files/file_2.txt' -> 's3://s3cmd-bucket/migration-files/file_2.txt'  [3 of 10]
   15 of 15   100% in    0s   107.54 B/s  done
  upload: '/home/username/migration-files/file_3.txt' -> 's3://s3cmd-bucket/migration-files/file_3.txt'  [4 of 10]
   15 of 15   100% in    0s   101.78 B/s  done
  upload: '/home/username/migration-files/file_4.txt' -> 's3://s3cmd-bucket/migration-files/file_4.txt'  [5 of 10]
   15 of 15   100% in    0s   105.90 B/s  done
  upload: '/home/username/migration-files/file_5.txt' -> 's3://s3cmd-bucket/migration-files/file_5.txt'  [6 of 10]
   15 of 15   100% in    0s   106.24 B/s  done
  upload: '/home/username/migration-files/file_6.txt' -> 's3://s3cmd-bucket/migration-files/file_6.txt'  [7 of 10]
   15 of 15   100% in    0s    74.72 B/s  done
  upload: '/home/username/migration-files/file_7.txt' -> 's3://s3cmd-bucket/migration-files/file_7.txt'  [8 of 10]
   15 of 15   100% in    0s   108.58 B/s  done
  upload: '/home/username/migration-files/file_8.txt' -> 's3://s3cmd-bucket/migration-files/file_8.txt'  [9 of 10]
   15 of 15   100% in    0s    58.93 B/s  done
  upload: '/home/username/migration-files/file_9.txt' -> 's3://s3cmd-bucket/migration-files/file_9.txt'  [10 of 10]
   15 of 15   100% in    0s    97.74 B/s  done
  Done. Uploaded 151 bytes in 1.8 seconds, 84.62 B/s.
  ```

  
> **Note:** This same command can be used for on-prem local file systems, on-prem NFS file systems, and on an OCI compute instance with OCI File System Storage NFS mounts to move data from OCI File System Storage into an OCI Object Storage Bucket

2. Check that the files in the `migration-files` directory are now in the bucket `s3cmd-bucket`

Use the S3cmd to list the objects in the bucket

  ```
  <copy>
  s3cmd ls s3://s3cmd-bucket/migration-files/
  </copy>
  ```

Command output should look similar to this:

  ```
  s3cmd ls s3://s3cmd-bucket/migration-files/
  2024-07-19 22:24           15  s3://s3cmd-bucket/migration-files/file_1.txt
  2024-07-19 22:24           16  s3://s3cmd-bucket/migration-files/file_10.txt
  2024-07-19 22:24           15  s3://s3cmd-bucket/migration-files/file_2.txt
  2024-07-19 22:24           15  s3://s3cmd-bucket/migration-files/file_3.txt
  2024-07-19 22:24           15  s3://s3cmd-bucket/migration-files/file_4.txt
  2024-07-19 22:24           15  s3://s3cmd-bucket/migration-files/file_5.txt
  2024-07-19 22:24           15  s3://s3cmd-bucket/migration-files/file_6.txt
  2024-07-19 22:24           15  s3://s3cmd-bucket/migration-files/file_7.txt
  2024-07-19 22:24           15  s3://s3cmd-bucket/migration-files/file_8.txt
  2024-07-19 22:24           15  s3://s3cmd-bucket/migration-files/file_9.txt
  ```

3. Use S5cmd to migrate files into the `s5cmd-bucket`

  ```
  <copy>
  s5cmd sync $HOME/migration-files s3://s5cmd-bucket
  </copy>
  ```

Example command and output should looks something like this:

  ```
  s5cmd sync $HOME/migration-files s3://s5cmd-bucket
  cp /home/username/migration-files/file_8.txt s3://s5cmd-bucket/migration-files/file_8.txt
  cp /home/username/migration-files/file_1.txt s3://s5cmd-bucket/migration-files/file_1.txt
  cp /home/username/migration-files/file_9.txt s3://s5cmd-bucket/migration-files/file_9.txt
  cp /home/username/migration-files/file_7.txt s3://s5cmd-bucket/migration-files/file_7.txt
  cp /home/username/migration-files/file_6.txt s3://s5cmd-bucket/migration-files/file_6.txt
  cp /home/username/migration-files/file_5.txt s3://s5cmd-bucket/migration-files/file_5.txt
  cp /home/username/migration-files/file_2.txt s3://s5cmd-bucket/migration-files/file_2.txt
  cp /home/username/migration-files/file_3.txt s3://s5cmd-bucket/migration-files/file_3.txt
  cp /home/username/migration-files/file_10.txt s3://s5cmd-bucket/migration-files/file_10.txt
  cp /home/username/migration-files/file_4.txt s3://s5cmd-bucket/migration-files/file_4.txt
  ```

> **Note:** This same command can be used for on-prem local file systems, on-prem NFS file systems, and on an OCI compute instance with OCI File System Storage NFS mounts to move data from OCI File System Storage into an OCI Object Storage Bucket

4. Check that the files in the `migration-files` directory are now in the bucket `s5cmd-bucket`

Use the S5cmd to list the bucket

  ```
  <copy>
  s5cmd ls s3://s5cmd-bucket/migration-files/
  </copy>
  ```
  
Successful output should look something like this:

  ```
  s5cmd ls s3://s5cmd-bucket/migration-files/
  2024/07/19 22:33:17                15  file_1.txt
  2024/07/19 22:33:17                16  file_10.txt
  2024/07/19 22:33:17                15  file_2.txt
  2024/07/19 22:33:17                15  file_3.txt
  2024/07/19 22:33:17                15  file_4.txt
  2024/07/19 22:33:17                15  file_5.txt
  2024/07/19 22:33:17                15  file_6.txt
  2024/07/19 22:33:17                15  file_7.txt
  2024/07/19 22:33:17                15  file_8.txt
  2024/07/19 22:33:17                15  file_9.txt
  ```

3. Add files to the `migration-files` directory
   
  ```
  <copy>
  for i in {11..15};do echo "This is file ${i}" > $HOME/migration-files/file_${i}.txt;done
  </copy>
 ```

This command will create 5 new files in the `migration-files` directory

4. Re-run the S3cmd sync command

  ```
  <copy>
  s3cmd sync $HOME/migration-files s3://s3cmd-bucket
  </copy>
  ```

Example run with output, notice only the 5 new files are copied into the bucket:

  ```
  s3cmd sync $HOME/migration-files s3://s3cmd-bucket
  upload: '/home/username/migration-files/file_11.txt' -> 's3://s3cmd-bucket/migration-files/file_11.txt'  [1 of 5]
   16 of 16   100% in    0s    85.74 B/s  done
  upload: '/home/username/migration-files/file_12.txt' -> 's3://s3cmd-bucket/migration-files/file_12.txt'  [2 of 5]
   16 of 16   100% in    0s   110.51 B/s  done
  upload: '/home/username/migration-files/file_13.txt' -> 's3://s3cmd-bucket/migration-files/file_13.txt'  [3 of 5]
   16 of 16   100% in    0s   115.98 B/s  done
  upload: '/home/username/migration-files/file_14.txt' -> 's3://s3cmd-bucket/migration-files/file_14.txt'  [4 of 5]
   16 of 16   100% in    0s    97.18 B/s  done
  upload: '/home/username/migration-files/file_15.txt' -> 's3://s3cmd-bucket/migration-files/file_15.txt'  [5 of 5]
   16 of 16   100% in    0s    87.29 B/s  done
  Done. Uploaded 80 bytes in 1.0 seconds, 80.00 B/s.
  ```

5. Re-run the S5cmd sync command

  ```
  <copy>
  s5cmd sync $HOME/migration-files s3://s5cmd-bucket
  </copy>
  ```

Again, only the 5 new files are copied into the bucket:

  ```
  s5cmd sync $HOME/migration-files s3://s5cmd-bucket
  cp /home/username/migration-files/file_15.txt s3://s5cmd-bucket/migration-files/file_15.txt
  cp /home/username/migration-files/file_13.txt s3://s5cmd-bucket/migration-files/file_13.txt
  cp /home/username/migration-files/file_11.txt s3://s5cmd-bucket/migration-files/file_11.txt
  cp /home/username/migration-files/file_12.txt s3://s5cmd-bucket/migration-files/file_12.txt
  cp /home/username/migration-files/file_14.txt s3://s5cmd-bucket/migration-files/file_14.txt
  ```

## Task 5 Migrate Data from OCI Object Storage to a Local File System

1. Create a 2 new directories on your laptop or workstation

  ```
  <copy>
  mkdir $HOME/s3-target;mkdir $HOME/s5-target
  </copy>
  ```

2. Use S3cmd to move data from the buckets into the `s3-target` directory

  ```
  <copy>
  s3cmd sync s3://s3cmd-bucket $HOME/s3-target/ 
  </copy>
  ```

Output should look something like this:

  ```
  s3cmd sync s3://s3cmd-bucket $HOME/s3-target/
  download: 's3://s3cmd-bucket/migration-files/file_1.txt' -> '/home/username/s3-target/migration-files/file_1.txt'  [1 of 15]
   15 of 15   100% in    0s    94.22 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_10.txt' -> '/home/username/s3-target/migration-files/file_10.txt'  [2 of 15]
   16 of 16   100% in    0s    97.57 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_11.txt' -> '/home/username/s3-target/migration-files/file_11.txt'  [3 of 15]
   16 of 16   100% in    0s   102.57 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_12.txt' -> '/home/username/s3-target/migration-files/file_12.txt'  [4 of 15]
   16 of 16   100% in    0s   121.36 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_13.txt' -> '/home/username/s3-target/migration-files/file_13.txt'  [5 of 15]
   16 of 16   100% in    0s   120.17 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_14.txt' -> '/home/username/s3-target/migration-files/file_14.txt'  [6 of 15]
   16 of 16   100% in    0s   105.31 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_15.txt' -> '/home/username/s3-target/migration-files/file_15.txt'  [7 of 15]
   16 of 16   100% in    0s   118.14 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_2.txt' -> '/home/username/s3-target/migration-files/file_2.txt'  [8 of 15]
   15 of 15   100% in    0s   100.63 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_3.txt' -> '/home/username/s3-target/migration-files/file_3.txt'  [9 of 15]
   15 of 15   100% in    0s   115.35 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_4.txt' -> '/home/username/s3-target/migration-files/file_4.txt'  [10 of 15]
   15 of 15   100% in    0s    86.27 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_5.txt' -> '/home/username/s3-target/migration-files/file_5.txt'  [11 of 15]
   15 of 15   100% in    0s   105.20 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_6.txt' -> '/home/username/s3-target/migration-files/file_6.txt'  [12 of 15]
   15 of 15   100% in    0s   111.90 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_7.txt' -> '/home/username/s3-target/migration-files/file_7.txt'  [13 of 15]
   15 of 15   100% in    0s   101.18 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_8.txt' -> '/home/username/s3-target/migration-files/file_8.txt'  [14 of 15]
   15 of 15   100% in    0s    69.02 B/s  done
  download: 's3://s3cmd-bucket/migration-files/file_9.txt' -> '/home/username/s3-target/migration-files/file_9.txt'  [15 of 15]
   15 of 15   100% in    0s    75.18 B/s  done
  Done. Downloaded 231 bytes in 2.4 seconds, 98.15 B/s.
  ```

> **Note:** The command above can be used for on-prem local file systems, on-prem NFS file systems, and on an OCI compute instance with an OCI File System Storage NFS mount to move the data from OCI File System Storage Service into an OCI Object Storage bucket


You can re-run the `s3cmd ls s3://s3cmd-bucket/migration=files/` and `ls $HOME/s3-target/migration-files` to verify the contents are the same

3. Use S5cmd to move data from the buckets into the `s5-target` directory

  ```
  <copy>
  s5cmd sync s3://s5cmd-bucket/* $HOME/s5-target/
  </copy>
  ```

Output should look something like this:  

  ```
  s5cmd sync s3://s5cmd-bucket/* $HOME/s5-target/
  cp s3://s5cmd-bucket/migration-files/file_10.txt /home/username/s5-target/migration-files/file_10.txt
  cp s3://s5cmd-bucket/migration-files/file_11.txt /home/username/s5-target/migration-files/file_11.txt
  cp s3://s5cmd-bucket/migration-files/file_15.txt /home/username/s5-target/migration-files/file_15.txt
  cp s3://s5cmd-bucket/migration-files/file_12.txt /home/username/s5-target/migration-files/file_12.txt
  cp s3://s5cmd-bucket/migration-files/file_6.txt /home/username/s5-target/migration-files/file_6.txt
  cp s3://s5cmd-bucket/migration-files/file_2.txt /home/username/s5-target/migration-files/file_2.txt
  cp s3://s5cmd-bucket/migration-files/file_13.txt /home/username/s5-target/migration-files/file_13.txt
  cp s3://s5cmd-bucket/migration-files/file_7.txt /home/username/s5-target/migration-files/file_7.txt
  cp s3://s5cmd-bucket/migration-files/file_4.txt /home/username/s5-target/migration-files/file_4.txt
  cp s3://s5cmd-bucket/migration-files/file_8.txt /home/username/s5-target/migration-files/file_8.txt
  cp s3://s5cmd-bucket/migration-files/file_9.txt /home/username/s5-target/migration-files/file_9.txt
  cp s3://s5cmd-bucket/migration-files/file_14.txt /home/username/s5-target/migration-files/file_14.txt
  cp s3://s5cmd-bucket/migration-files/file_3.txt /home/username/s5-target/migration-files/file_3.txt
  cp s3://s5cmd-bucket/migration-files/file_5.txt /home/username/s5-target/migration-files/file_5.txt
  cp s3://s5cmd-bucket/migration-files/file_1.txt /home/username/s5-target/migration-files/file_1.txt
  ```

> **Note:** The command above can be used for on-prem local file systems, on-prem NFS file systems, and on an OCI compute instance with an OCI File System Storage NFS mount to move the data from OCI File System Storage Service into an OCI Object Storage bucket

You can re-run the `s5cmd ls s3://s3cmd-bucket/migration=files/` and `ls $HOME/s3-target/migration-files` to verify the contents are the same

## Task 6: Lab Clean Up

This is an optional lab to clean up all created items.

1. Remove the S3cmd Objects and Bucket

Use the S3cmd to remove the objects and bucket `s3cmd-bucket`

  ```
  <copy>
  s3cmd del --recursive --force s3://s3cmd-bucket
  s3cmd rb s3://s3cmd-bucket
  </copy>
 ```

Example commands and output:

  ```
  s3cmd del --recursive --force s3://s3cmd-bucket
  delete: 's3://s3cmd-bucket/migration-files/file_1.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_10.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_11.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_12.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_13.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_14.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_15.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_2.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_3.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_4.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_5.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_6.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_7.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_8.txt'
  delete: 's3://s3cmd-bucket/migration-files/file_9.txt'
  $ s3cmd rb s3://s3cmd-bucket
  Bucket 's3://s3cmd-bucket/' removed
  ```
2. Remove the Sr53cmd Objects and Bucket

Use the S5cmd to remove the objects and bucket `s5cmd-bucket`

  ```
  <copy>
  s5cmd rm "s3://s5cmd-bucket/*"
  s5cmd rb s3://s5cmd-bucket
  </copy>
  ```

Example commands and output:

  ```
  s5cmd rm "s3://s5cmd-bucket/*"
  rm s3://s5cmd-bucket/migration-files/file_3.txt
  rm s3://s5cmd-bucket/migration-files/file_11.txt
  rm s3://s5cmd-bucket/migration-files/file_5.txt
  rm s3://s5cmd-bucket/migration-files/file_10.txt
  rm s3://s5cmd-bucket/migration-files/file_8.txt
  rm s3://s5cmd-bucket/migration-files/file_13.txt
  rm s3://s5cmd-bucket/migration-files/file_7.txt
  rm s3://s5cmd-bucket/migration-files/file_14.txt
  rm s3://s5cmd-bucket/migration-files/file_15.txt
  rm s3://s5cmd-bucket/migration-files/file_2.txt
  rm s3://s5cmd-bucket/migration-files/file_4.txt
  rm s3://s5cmd-bucket/migration-files/file_6.txt
  rm s3://s5cmd-bucket/migration-files/file_9.txt
  rm s3://s5cmd-bucket/migration-files/file_1.txt
  rm s3://s5cmd-bucket/migration-files/file_12.txt
  $ s5cmd rb s3://s5cmd-bucket
  rb s3://s5cmd-bucket
  ```
3. Remove the Test Migration Files and Directories

  ```
  <copy>
  cd $HOME
  rm -rf s3-target;rm -rf s5-target;rm -rf migration-files
  </copy>
  ```

## Learn More

* [OCI Object Storage](https://docs.oracle.com/en/learn/migrate-data-to-oci-object-storage/index.html#introduction)
* [S3cmd](https://s3tools.org/s3cmd)
* [S5cmd](https://github.com/peak/s5cmd)

## Acknowledgements

* **Author** - Melinda Centeno, Senior Principal Product Manager
* **Last Updated** - Melinda Centeno, 19 July 2024

