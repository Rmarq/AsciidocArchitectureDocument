#!/usr/bin/env bash

set -e

TEMP_DIR="./temp-diagrams"

# Create temporary directory
mkdir -p "$TEMP_DIR"

# Generate PDF
asciidoctor-pdf -r asciidoctor-diagram -a imagesoutdir="$TEMP_DIR" ArchitectureDocument.adoc

# Clean up generated images after successful PDF generation
rm -rf "$TEMP_DIR"

echo "PDF generated successfully."