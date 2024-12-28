#!/bin/bash

# Define file paths
SOURCE_FILE="server.log"
EXTRACTED_FILE="extracted_logs.log"
TRANSFORMED_FILE="transformed_logs.log"
LOADED_FILE="error_report.log"

# Step 1: Extract
echo "Extracting data from $SOURCE_FILE..."
cat $SOURCE_FILE > $EXTRACTED_FILE
echo "Data extracted to $EXTRACTED_FILE."

# Step 2: Transform
echo "Filtering ERROR and WARN logs from $EXTRACTED_FILE..."
grep -E "ERROR|WARN" $EXTRACTED_FILE > $TRANSFORMED_FILE
echo "Filtered data saved to $TRANSFORMED_FILE."

# Step 3: Load
echo "Loading transformed logs into $LOADED_FILE..."
mv $TRANSFORMED_FILE $LOADED_FILE
echo "ETL process completed. Final report saved to $LOADED_FILE."

# Final Summary
echo "Summary of Logs:"
echo "Total Logs: $(wc -l < $SOURCE_FILE)"
echo "Errors and Warnings: $(wc -l < $LOADED_FILE)"
