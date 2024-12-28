# ETL Pipeline for Server Log Processing

This document provides instructions to set up and execute a simple ETL pipeline using Bash scripting to process server logs.

## Objective
To extract, filter, and save error and warning logs from a server log file for further analysis.

---

## Prerequisites

1. **Bash Shell**: Ensure you have access to a Unix/Linux environment with Bash installed.
2. **Sample Log File**: Create a file named `server.log` with the following sample data:

    ```
    2024-12-01 12:00:01 INFO Starting server...
    2024-12-01 12:05:23 ERROR Failed to connect to database
    2024-12-01 12:10:45 WARN High memory usage detected
    2024-12-01 12:15:12 INFO Request received from IP 192.168.1.5
    2024-12-01 12:20:08 ERROR Timeout while reading from API
    2024-12-01 12:25:30 INFO Server health check passed
    2024-12-01 12:30:00 WARN Disk space usage exceeds 80%
    ```
3. **Script File**: Create a Bash script named `log_etl.sh` with the content provided below.

---

## ETL Script

### Create the Script File (`log_etl.sh`)

```bash
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
```

---

## Steps to Execute

1. **Create the Log File**  
   Save the provided sample log data into a file named `server.log` in your working directory.

2. **Save the Script**  
   Save the Bash script code into a file named `log_etl.sh` in the same directory.

3. **Grant Execute Permissions**  
   Make the script executable by running the following command:
   ```bash
   chmod +x log_etl.sh
   ```

4. **Run the Script**  
   Execute the script using:
   ```bash
   ./log_etl.sh
   ```

5. **View Output**  
   - `extracted_logs.log`: A copy of the original log file.
   - `error_report.log`: Contains only the filtered error and warning logs.

---

## Example Output

After execution, the file `error_report.log` will contain:

```text
2024-12-01 12:05:23 ERROR Failed to connect to database
2024-12-01 12:10:45 WARN High memory usage detected
2024-12-01 12:20:08 ERROR Timeout while reading from API
2024-12-01 12:30:00 WARN Disk space usage exceeds 80%
```

---

## Extensions

1. **Dynamic Date Filtering**: Modify the script to extract logs from specific dates using `grep`.
2. **Database Integration**: Load the filtered logs into a database (e.g., MySQL) using commands or APIs.
3. **Alert Notifications**: Send critical errors via email or Slack using `mail` or webhook integrations.
4. **Automation**: Schedule the script using `cron` for periodic execution.

---

## Conclusion

This ETL pipeline demonstrates a simple yet effective way to process server logs using Bash scripting. Customize it further to suit your operational needs or integrate with advanced data processing systems.

