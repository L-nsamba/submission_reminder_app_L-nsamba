#!/bin/bash

#Accessing the submission reminder directory
sub_reminder_dir=$( find . -maxdepth 1 -type d -name "submission_reminder_*" | head -1 )

#Error handling for condition where submission directory does not exist
if [ -z "$sub_reminder_dir" ];then
	sleep 0.5
	echo ""
	echo "Unable to find 'submission_reminder_{yourName}'."
	echo ""
	sleep 0.5
	echo "Please run 'create_environment.sh' script."
	echo ""
	exit 1
else
	sleep 0.5
	echo "Successfully located '$sub_reminder_dir'."
fi

#Displaying current assignment
config_path="$sub_reminder_dir/config/config.env"
echo "Your current assignment is: $(grep 'ASSIGNMENT=' "$config_path" )"
sleep 0.5

#Prompt for user to enter new assignment
read -p "Enter new assignment: " new_assignment
sleep 0.5

#Replacing old assignment with new assignment
echo "Updating reminder system..."
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$config_path"
sleep 0.5

#Running script to check for latest updates
echo "New assignment '$new_assignment' history displayed in submission reminder system"
sleep 0.5
cd "$sub_reminder_dir"
./startup.sh
