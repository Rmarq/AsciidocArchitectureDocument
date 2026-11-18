#!/usr/bin/env bash

set -e

INPUT="main.adoc"
TEMP_DIR="./temp-diagrams"

# Read document attributes from the AsciiDoc file
OUTPUT=$(ruby -rasciidoctor -e '
  doc = Asciidoctor.load_file(ARGV[0], safe: :safe)
  puts "#{doc.attr("projname")} - #{doc.attr("documentname")}.pdf"
' "$INPUT")

echo "Generating: $OUTPUT"

# Create temporary directory
mkdir -p "$TEMP_DIR"

# Always clean up temporary files
trap 'rm -rf "$TEMP_DIR"' EXIT

# Generate PDF
asciidoctor-pdf \
    -r asciidoctor-diagram \
    -a imagesoutdir="$TEMP_DIR" \
    -o "$OUTPUT" \
    "$INPUT"

echo "PDF generated successfully: $OUTPUT"