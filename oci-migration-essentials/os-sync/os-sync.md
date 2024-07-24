# Migrating Data with OCI Object Storage Sync

## Introduction
OCI Object Storage Sync (os sync) is part of the OCI Command Line Interface (CLI) which synchronizes a filesystem directory with objects in a bucket. The command traverses sub-directories copying new and modified files or objects from the source to the destination and optionally deleting those that are not present in the sourc.

Estimated time: 20 min

### Objectives

In this lab you will:
- Use OCI os sync to synchronize data from a local file system to an OCI Object Storage bucket
- Use OCI os sync to synchronize data from an OCI Object Storage bucket to a local file system

### Prerequisites

This lab assumes you have:
* Completed all previous labs
* You have OCI Command Line installed with a working configuration file
* You can change directories/ folders, create/edit files, create directories/folder , run commands, and install software on your laptop or workstaion
* Have at least 1 GiB of free space on your laptop or workstation to create test files


## Task 1: Create Test Files 

1. Create a directory or folder on your laptop or workstation

  ```
  <copy>
  mkdir migration-files
  </copy>
  ```

2. Create some test files, then move up 1 directory

  ```
  <copy>
  cd <path to migration-files>
  echo  test1 > file1.txt
  echo test2 > file2.txt
  echo test3 > file3.txt
  ls
  cd ..
  </copy>
 ```

Change the path to the `migration-files` directory/ folder, example:

  ```
  cd /home/username/migration-files
  echo test1 > file1.txt
  echo test2 > file2.txt
  echo test3 > file3.txt
  ls
  file1.txt  file2.txt  file3.txt
  cd $HOME
 ```

## Task 2: Create an OCI Object Storage Bucket

Use the OCI CLI to create an OCI Object Storage Bucket. 

  ```
  <copy>
  oci os bucket create --name migration-ossync --compartment-id <compartment or tenancy OCID>
  </copy>
  ```
If you do not have a compartment created in your tenancy, use the tenancy OCID for the `compartment-id` flag

> **Note:** You can find your tenancy OCID in your OCI CLI configuration file. The OCI CLI configuration file is usually in your home directory/ folder in sub-directory/folder .oci named config, for example: `/home/username/.oci/config`

## Task 3: Synchronize Local File System Data into OCI Object Storage

1. Use the OCI CLI `os object sync` command to synchronize the files from the `migration-files` directory into the `migration-ossync` bucket

  ```
  <copy>
  oci os object sync --src-dir <path to migration-files> --bucket-name migration-ossync
  </copy>
  ```
  
Use the full or relative path to the `migration-files` directory

Example with expected output:

  ```
  oci os object sync --src-dir /home/username/migration-files --bucket-name migration-ossync
  Uploaded file1.txt  [####################################]  100%
  Uploaded file2.txt  [####################################]  100%
  Uploaded file3.txt  [####################################]  100%

  {
    "skipped-objects": [],
    "upload-failures": {},
    "uploaded-objects": {
      "file1.txt": {
        "etag": "1fde12b9-a12e-4f9a-bbe8-7bf55bb517c9",
        "last-modified": "Fri, 19 Jul 2024 02:42:15 GMT",
        "opc-content-md5": "PncFSY6L5gUghBQJ68abwQ=="
      },
      "file2.txt": {
        "etag": "b536b1f4-94e5-418a-8070-8c08bc7a4fce",
        "last-modified": "Fri, 19 Jul 2024 02:42:16 GMT",
        "opc-content-md5": "EmqKUbnRu9B/3cZYGaVCww=="
      },
      "file3.txt": {
        "etag": "05368ab5-759c-4c64-82d1-2442905fcccc",
        "last-modified": "Fri, 19 Jul 2024 02:42:16 GMT",
        "opc-content-md5": "O8O+EU+2MjrcWwrXQi0ZOg=="
      }
    }
  }
  ```

> **Note:** This same command can be used for on-prem local file systems, on-prem NFS file systems, and on an OCI compute instance with OCI File System Storage NFS mounts to move data from OCI File System Storage into an OCI Object Storage Bucket

2. Verify the Files are in bucket

  ```
  <copy>
  oci os object list --bucket-name migration-ossync --fields name --output table
  </copy>
  ```
  
Successful output should show the created files in the `migration-ossync` bucket like this:

  ```
  oci os object list --bucket-name migration-ossync --fields name --output table
  +----------------+------+------+-----------+------+--------------+--------------+---------------+
  | archival-state | etag | md5  | name      | size | storage-tier | time-created | time-modified |
  +----------------+------+------+-----------+------+--------------+--------------+---------------+
  | None           | None | None | file1.txt | None | None         | None         | None          |
  | None           | None | None | file2.txt | None | None         | None         | None          |
  | None           | None | None | file3.txt | None | None         | None         | None          |
  +----------------+------+------+-----------+------+--------------+--------------+---------------+
  ```

3. Add files to the `migration-files` directory/ folder
   
Use an editor or command  of your choice and add 1-2 files to the `migration-files` directory/ folder. Example command:

  ```
  <copy>
  cd <path to migration-files>
  echo  test4 > file4.txt
  echo test5 > file5.txt
  </copy>
 ```

Change the path to the `migration-files` directory/ folder, example:

  ```
  cd /home/username/migration-files
  echo test4 > file4.txt
  echo test5 > file5.txt
 ```

4. Re-run the `os object sync` command

  ```
  <copy>
  oci os object sync --src-dir <path to migration-files> --bucket-name migration-ossync
  </copy>
  ```
Use the full or relative path to the `migration-files` directory

Example with expected output:
  ```
  oci os object sync --src-dir /home/username/migration-files --bucket-name migration-ossync
  Uploaded file5.txt  [####################################]  100%
  Uploaded file4.txt  [####################################]  100%

  {
    "skipped-objects": [
      "file2.txt",
      "file3.txt",
      "file1.txt"
    ],
    "upload-failures": {},
    "uploaded-objects": {
      "file4.txt": {
        "etag": "d8566bce-31a5-4a20-9c26-a69f8144e9cb",
        "last-modified": "Fri, 19 Jul 2024 02:55:53 GMT",
        "opc-content-md5": "tRY88nCj+6w0gnxKJxPu9A=="
      },
      "file5.txt": {
        "etag": "23eda846-c740-4229-be55-d37a99710cef",
        "last-modified": "Fri, 19 Jul 2024 02:55:53 GMT",
        "opc-content-md5": "u02hKQecEtTdruZLp5oD/w=="
      }
    }
  }
  ```

5. Check that the new files have been copied into the `migration-ossync` bucket

Re-run the OCI CLI command from Step 2 above

```
  <copy>
  oci os object list --bucket-name migration-ossync --fields name --output table
  </copy>
  ```

You should now see `file4.txt` and `file5.txt` with the previously migrated files. 

  
## Task 4 Migrate Data from OCI Object Storage to a Local File System

1. Create a new directory/ folder on your laptop or workstation

  ```
  <copy>
  mkdir migration-target
  </copy>
  ```

2. Use `os object sync` to move the data from the `migration-ossync` bucket to the `migration-target` directory/ folder

  ```
  <copy>
  oci os object sync --dest-dir <path to migration-target directory> --bucket-name migration-ossync
  </copy>
  ```
Use the full or relative path to the `migration-target` directory

Example command with expected output:
  ```
  oci os object sync --dest-dir /home/username/migration-target --bucket-name migration-ossync
  Downloaded file2.txt  [####################################]  100%
  Downloaded file1.txt  [####################################]  100%
  Downloaded file5.txt  [####################################]  100%
  Downloaded file4.txt  [####################################]  100%
  Downloaded file3.txt  [####################################]  100%

  {
    "download-failures": {},
    "downloaded-objects": [
      "file2.txt",
      "file1.txt",
      "file5.txt",
      "file4.txt",
      "file3.txt"
    ],
    "skipped-objects": []
  }
  ```

> **Note:** The command above can be used for on-prem local file systems, on-prem NFS file systems, and on an OCI compute instance with an OCI File System Storage NFS mount to move the data from OCI File System Storage Service into an OCI Object Storage bucket


3. List the files in the `migration-target` directory/ folder and see that the contents match Task 3, Step 5

  ```
  <copy>
  cd <path to migration-target>
  ls
  </copy>
  ```

Example with expected output:
  ```
  cd /home/username/migration-target
  ls
  file1.txt	file2.txt	file3.txt	file4.txt	file5.txt
  ```

You should now see the bucket objects in the local file system directory.
   

## Task 5: Lab Clean Up

This is an optional lab to clean up all created items.

1. Remove Objects

Delete all the objects in the `migration-ossync` bucket using the OCI CLI

  ```
  <copy>
  oci os object bulk-delete --bucket-name migration-ossync
  </copy>
  ```

When prompted, answer `y`. Example and expected output:

  ```
  oci os object bulk-delete --bucket-name migration-ossync 
  WARNING: This command will delete at least 5 objects. Are you sure you wish to continue? [y/N]: y
  Deleted object file4.txt  [####################################]  100%
  Deleted object file3.txt  [####################################]  100%
  Deleted object file5.txt  [####################################]  100%
  Deleted object file1.txt  [####################################]  100%
  Deleted object file2.txt  [####################################]  100%

  {
    "delete-failures": {},
    "deleted-objects": [
      "file4.txt",
      "file3.txt",
      "file5.txt",
      "file1.txt",
      "file2.txt"
    ]
  }
  ```

2. Delete the Bucket

Use the OCI CLI to delete the bucket

  ```
  <copy>
  oci os bucket delete --name migration-ossync
  </copy>
  ```

When prompted, answer `y` to delete the bucket. Example and expected output:

  ```
  oci os bucket delete --name migration-ossync
  Are you sure you want to delete this bucket? [y/N]: y
  ```

3. Remove the Test Migration Files and Directories

 #### Mac OS, Linux, and BSD Systems

  ```
  <copy>
  rm -rf <path to migration-files>
  rm -rf <path to migration-target>
  </copy>
  ```

Example:

  ```
  rm -rf /home/username/migration-files
  rm -rf /home/username/migration-target
  ```

#### Windows

Drag and drop the `migration-files` and `migration-target` folders to the trash

You may now **proceed to the next lab**.

## Learn More

* [OCI Object Storage](https://docs.oracle.com/en/learn/migrate-data-to-oci-object-storage/index.html#introduction)
* [OCI Command Line Object Storage Sync](https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.44.2/oci_cli_docs/cmdref/os/object/sync.html)

## Acknowledgements

* **Author** - Melinda Centeno, Senior Principal Product Manager
* **Last Updated** - Melinda Centeno, 19 July 2024

