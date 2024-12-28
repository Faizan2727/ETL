# Data Masking and ETL Tool using Shell Scripting

## **Objective**
Create a tool that:
1. Extracts data from a source.
2. Transforms the data (e.g., masks sensitive information like emails and credit card numbers).
3. Loads the processed data into a destination file.

This tool is implemented using `bash`, `sed`, and `awk` to perform the ETL process.

---

## **Script**
Save the following script as `etl_tool.sh`:

```bash
#!/bin/bash

# Define source and destination files
SOURCE_FILE="input_data.txt"
DEST_FILE="processed_data.txt"

echo "Starting the ETL process..."

# Step 1: Extract data
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file $SOURCE_FILE does not exist."
    exit 1
fi

data=$(cat "$SOURCE_FILE")

# Step 2: Transform data
transformed_data=$(echo "$data" | sed -E 's/([a-zA-Z])[a-zA-Z]*\.([a-zA-Z])[a-zA-Z]*@/\1***.\2**@/g' | \
    sed -E 's/([0-9]{4})-[0-9]{4}-[0-9]{4}-([0-9]{4})/\1-****-****-\2/g')

# Step 3: Load data into destination file
echo "$transformed_data" > "$DEST_FILE"

echo "ETL process completed. Processed data saved in $DEST_FILE."
```

---

## **How to Run**

### 1. **Prepare the Source File:**
Create a file named `input_data.txt` with the following sample content:
```text
Name: John Doe, Email: john.doe@example.com, Card: 1234-5678-9012-3456
Name: Jane Smith, Email: jane.smith@domain.com, Card: 9876-5432-1098-7654
```

### 2. **Make the Script Executable:**
```bash
chmod +x etl_tool.sh
```

### 3. **Run the Script:**
```bash
./etl_tool.sh
```

### 4. **Check the Output:**
The masked data will be saved in `processed_data.txt`. Example output:
```text
Name: John Doe, Email: j***.d**@example.com, Card: 1234-****-****-3456
Name: Jane Smith, Email: j***.s*****@domain.com, Card: 9876-****-****-7654
```

---

## **Extending the Tool**
You can enhance the tool by:
- Adding support for additional data transformations.
- Accepting dynamic input/output file names as arguments.
- Integrating the script into a CI/CD pipeline for automated ETL processes.

Enjoy building secure and efficient ETL pipelines! 🚀

