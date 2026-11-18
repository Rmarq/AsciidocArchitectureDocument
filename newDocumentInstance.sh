
#!/bin/bash

# Files and folders to copy (relative to the script directory)
FILES=(
    "main.adoc"
    "README.md"
    "LICENSE"
    "generate-pdf.sh"
    "chapters"
    "images"
)

# Check arguments
if [ $# -ne 1 ]; then
    echo "Usage: $0 <destination_path>"
    exit 1
fi

DEST="$1"

# Get the directory where this script is located
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Check that all source files exist
for FILE in "${FILES[@]}"; do
    if [ ! -e "$SCRIPT_DIR/$FILE" ]; then
        echo "Error: Source '$SCRIPT_DIR/$FILE' does not exist."
        exit 1
    fi
done

# Find the nearest existing parent directory
PARENT="$DEST"

while [ ! -e "$PARENT" ]; do
    PARENT="$(dirname "$PARENT")"
done

# Check destination permissions
if [ -d "$DEST" ]; then
    if [ ! -w "$DEST" ] || [ ! -x "$DEST" ]; then
        echo "Error: Destination '$DEST' is not writable."
        exit 1
    fi
else
    if [ ! -d "$PARENT" ] || [ ! -w "$PARENT" ] || [ ! -x "$PARENT" ]; then
        echo "Error: Cannot create destination '$DEST'."
        exit 1
    fi
fi

# Display what will be created
echo "Do you confirm the creation of this:"
echo "- $DEST"

for FILE in "${FILES[@]}"; do
    echo "    - $FILE"
done

echo

# Ask for confirmation
read -r -p "Continue? [y/N] " CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 0
fi

# Create destination directory if necessary
if ! mkdir -p "$DEST"; then
    echo "Error: Could not create destination '$DEST'."
    exit 1
fi

# Copy files and folders
if ! cp -r -- "${FILES[@]/#/$SCRIPT_DIR/}" "$DEST"; then
    echo "Error: Failed to copy some files."
    exit 1
fi

echo "Files successfully copied to '$DEST'."
