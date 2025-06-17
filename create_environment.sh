#!/bin/bash

#Prompt for user to enter name
echo ""
read -p "Enter your name: " name
echo ""
echo ""
echo "Creating directory..."
echo ""
sleep 0.5

#Creation of respective directory
mkdir -p submission_reminder_"$name"
echo ""
echo "Directory 'submission_reminder_"$name"' successfully created."
echo ""

#Creation of subdirectories within the student's directory
cd submission_reminder_"$name"
mkdir -p app
mkdir -p modules
mkdir -p assets
mkdir -p config
sleep 0.5
echo ""
echo "Creating sub-directories within 'submission_reminder_"$name"'..."
echo ""

#Creation of files within the student's directory
touch app/reminder.sh
touch modules/functions.sh
touch assets/submissions.txt
touch config/config.env
touch startup.sh
echo ""
echo "Creating files within the sub-directories..."
echo ""

#Populating the scripts within the created files
sleep 0.5
echo ""
echo "Populating files within the sub-directories..."
echo ""

#Populating the reminder script
cat > app/reminder.sh << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
chmod +x app/reminder.sh

#Populating the functions script
cat > modules/functions.sh << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}

EOF
chmod +x modules/functions.sh

#Populating the submissions file
cat > assets/submissions.txt << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Daniella, Shell Basics, submitted
Edgar, Shell Navigation, not submitted
Angello, Shell Navigation, submitted
Jeffery, Git, not submitted
Shabir, Shell Basics, submitted
Zein, Shell Navigation, submitted
Xavi, Shell Navigation, not submitted
Morrison, Git, not submitted
Greg, Shell Basics, submitted
Lorraine, Shell Navigation, not submitted
Sash, Shell Redirections, not submitted
Jorja, Shell Loops, not submitted
EOF

#Populating the config script
cat > config/config.env << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2

EOF
chmod +x config/config.env
echo ""
echo "Successfully completed set up!"
echo ""
echo ""

#Implementing the startup script
cat > startup.sh << 'EOF'
#!/bin/bash
echo ""
echo ""
sleep 0.5
echo "Starting up the reminder application system..."
echo ""
find -name "*.sh" -type f -exec chmod +x {} \;
sleep 0.5
echo ""
echo "Successfully started reminder application system."
echo ""
echo ""
./app/reminder.sh
EOF
chmod +x startup.sh
