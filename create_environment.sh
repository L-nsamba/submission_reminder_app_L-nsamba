#!/bin/bash

#Prompt for user to enter name
read -p "Enter your name: " name
echo "Creation of directory..."
sleep 0.5

#Creation of respective directory
mkdir -p submission_reminder_"$name"
echo "Directory 'submission_reminder_"$name"' created."

#Creation of subdirectories within the student's directory
cd submission_reminder_"$name"
mkdir -p app
mkdir -p modules
mkdir -p assets
mkdir -p config
sleep 0.5
echo "Sub-directories in 'submission_reminder_"$name"' created."

#Creation of files within the student's directory
touch app/reminder.sh
touch modules/functions.sh
touch assets/submissions.txt
touch config/config.env
touch startup.sh
sleep 0.5
echo "Files within sub-directories created."

