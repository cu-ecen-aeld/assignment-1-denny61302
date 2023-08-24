#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

writefile="$1"
writestr="$2"

# Check if writefile is provided
if [ -z "$writefile" ]; then
    echo "Error: writefile argument not specified."
    exit 1
fi

# Check if writestr is provided
if [ -z "$writestr" ]; then
    echo "Error: writestr argument not specified."
    exit 1
fi

# Create the directory path if it doesn't exist
dir_path="$(dirname "$writefile")"
mkdir -p "$dir_path"

# Write the content to the file
echo "$writestr" > "$writefile"

# Check if the file was created successfully
if [ $? -ne 0 ]; then
    echo "Error: Unable to create or write to $writefile."
    exit 1
fi

echo "Content written to $writefile successfully."

