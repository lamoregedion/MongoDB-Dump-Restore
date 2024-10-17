# MongoDB Dump and Restore Script

This repository contains a Bash script for performing MongoDB database dumps and restores.

## Script Overview

The script automates the process of creating copies of a MongoDB database using `mongodump` and `mongorestore`, logging the operations, and optionally sending email notifications upon completion.

## Prerequisites

- MongoDB tools (`mongodump`, `mongorestore`) must be installed.
- Email utility for sending notifications (optional).
- Proper access credentials for the MongoDB instance.

## Usage

1. Clone this repository:

   ```bash
   git clone https://github.com/lamoregedion/MongoDB-Dump-Restore.git
