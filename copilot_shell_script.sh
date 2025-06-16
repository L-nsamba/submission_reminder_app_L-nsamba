#!/bin/bash

#Accessing the submission reminder directory
sub_reminder_dir=$( find . -maxdepth 1 -type d -name 'submission_reminder_*' -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2- )

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

#Displaying current assignment history
config_path="$sub_reminder_dir/config/config.env"
echo "Your current assignment is: $(grep 'ASSIGNMENT=' "$config_path" )"
sleep 0.5

#Prompt for user to enter new assignment to check in reminder file
read -p "Enter new assignment: " new_assignment
sleep 0.5

#Updating the startup.sh script with new assignment requested by user
echo "Updating reminder system..."
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$config_path"
sleep 0.5

#Running startup.sh script to display user's new assignment history
echo "Displaying new assignment '$new_assignment' in the submission reminder system."
sleep 0.5
cd "$sub_reminder_dir"
./startup.sh
