#!/bin/bash

# ==================== USAGE FUNCTION ====================
usage() {
    cat <<EOF

mini "grep" tool

Usage: "$0" [OPTIONS] SEARCH_STRING FILENAME

Options:
  -n            Show line numbers
  -v            Invert match (show non-matching lines)
  -h, --help    Show this help message

Examples:
 "$0" "hello" file.txt          # Basic search (case-insensitive)
 "$0"  -n "hello" file.txt       # Show line numbers
 "$0" -vn or -nv "hello" file.txt      # Invert match with line numbers
EOF
    exit 0
}

for arg in "$@"; do
    if [[ "$arg" == "--help" || "$arg" == "-h" ]]; then
        usage
    fi
done

# ========== Checking the given arguments ===========
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 [options] search_string filename"
    exit 1
fi

# Initialize the required variables and flags 
search_string=""
filename=""
show_line_numbers=false
invert_match=false

# =================== Parse options ======================
while getopts "nv" option; do
    case "$option" in
        n) show_line_numbers=true ;;
        v) invert_match=true ;;
        *) echo "Usage: $0 [-n] [-v] search_string filename"; exit 1 ;;
    esac
done

shift $((OPTIND-1))  # Shift past all options

if [ "$#" -lt 2 ]; then
    echo "Error: Missing search string or filename!"
    exit 1
fi

# ===== first argument declaration =====
search_string="$1"
shift

# ===== second argument declaration =====
filename="$1"

# ===== Process file line by line =====
line_number=0
match_found=false  
while IFS= read -r line; do
    line_number=$((line_number + 1))

    # Custom case insensitive match algorithm
    lower_line=$(echo "$line" | tr '[:upper:]' '[:lower:]')
    lower_search=$(echo "$search_string" | tr '[:upper:]' '[:lower:]')

    if [[ "$lower_line" == *"$lower_search"* ]]; then
        matched=true
    else
        matched=false
    fi

    # Apply invert match if needed
    if { [ "$matched" = true ] && [ "$invert_match" = false ]; } || { [ "$matched" = false ] && [ "$invert_match" = true ]; }; then
        if [ "$show_line_numbers" = true ]; then
            echo "${line_number}: $line"
        else
            echo "$line"
        fi
        match_found=true  
    fi
done < "$filename"

# ============ Print a message if no matches were found =============
if [ "$invert_match" = false ] && [ "$match_found" = false ]; then
    echo "string not exist"
fi

# ======================= End of Script =============================



