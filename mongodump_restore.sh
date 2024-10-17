#!/bin/bash

# Defining an array of the new database names
new_names=("testDB_1" "testDB_2" "testDB_3")

# Creating a log file with the current date and time
log_file="testDB_mongodump_restore_log$(date '+%Y-%m-%d_%H-%M-%S').log"

# Set email variables
recipient="your_email@example.com"  # Change to your email
subject="MongoDB Restore Completion Notification"

# Loop through each new name and run the mongodump and mongorestore command
for new_name in "${new_names[@]}"; do
  echo "[$(date)] Running mongodump and mongorestore for $new_name" | tee -a $log_file

  # Run mongodump and mongorestore commands with logging
  mongodump --archive --gzip --uri "mongodb+srv://<username>:<password>@<cluster_url>/testDB" 2>> $log_file | \
  mongorestore --archive --gzip --nsFrom='testDB.*' --nsTo="$new_name.*" --uri "mongodb+srv://<username>:<password>@<cluster_url>" 2>> $log_file

  if [ $? -eq 0 ]; then
    echo "[$(date)] Successfully restored $new_name" | tee -a $log_file
    email_body="The MongoDB restore for $new_name has been successfully completed."
  else
    echo "[$(date)] Error encountered while restoring $new_name" | tee -a $log_file
    email_body="An error occurred during the MongoDB restore for $new_name. Check the logs for details."
  fi

  # Send email notification
  # echo "$email_body" | mail -s "$subject" $recipient

  # Pause between runs if necessary
  sleep 5
done

echo "[$(date)] All tasks completed." | tee -a $log_file
