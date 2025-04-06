#!/bin/bash

# Output file matches script name
OUTPUT_FILE="${0%.*}.txt"

{
    echo "=== Complete File Listing with Contents ==="
    echo "Generated on: $(date)"
    echo "==========================================="
    echo

    # Find specific file types and exclude unwanted directories
    find . \( -name "*.js" -o -name "*.css" -o -name "*.json" -o -name "*.html" \) \
        ! -path "*/node_modules/*" \
        ! -path "*/\.*" \
        ! -path "*/dist/*" \
        ! -name "package-lock.json" \
        -print0 | while IFS= read -r -d '' file; do
        
        echo "=== File: $file ==="
        echo "----------------------------------------"
        # Show file contents
        cat "$file"
        echo -e "\n\n"
    done

} | tee "$OUTPUT_FILE"

echo -e "\nOutput has been saved to list-files.txt"
