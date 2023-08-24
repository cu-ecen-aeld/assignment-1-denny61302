#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <filesdir> <searchstr>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

# Check if filesdir exists and is a directory
if [ ! -d "$filesdir" ]; then
    echo "$filesdir is not a directory or doesn't exist."
    exit 1
fi

# Function to search for the given string in files recursively
search_in_files() {
    local dir="$1"
    local pattern="$2"
    local file_count=0
    local match_count=0

    # Loop through each file in the directory
    for file in "$dir"/*; do
        if [ -f "$file" ]; then
            ((file_count++))
            # Search for the pattern in the file
            if grep -q "$pattern" "$file"; then
                ((match_count++))
            fi
        elif [ -d "$file" ]; then
            # Recursively search in subdirectories
            sub_results=($(search_in_files "$file" "$pattern"))
            ((file_count += ${sub_results[0]}))
            ((match_count += ${sub_results[1]}))
        fi
    done

    echo "$file_count $match_count"
}

# Call the search_in_files function and get results
results=($(search_in_files "$filesdir" "$searchstr"))
total_files="${results[0]}"
total_matches="${results[1]}"

echo "The number of files are $total_files and the number of matching lines are $total_matches"

