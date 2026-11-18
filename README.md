# Where to use
This is best used in VSCode with the needed plugins

# Plugins needed
- AsciiDoc
- Draw.io Integration : If you want to easily edit and integrate draw.io diagrams

# Creating pdf
**_Todo : Describe what need to be installed_**

To generate a pdf just run `./generate-pdf.sh`. If you prefer to manipulate asciidoctor yourself, you can follow that :

- To create a pdf without plantuml or mermaid, simply run this command :

`asciidoctor-pdf ArchitectureDocument.adoc`


- To create a pdf with plantuml, run this command :

`asciidoctor-pdf -r asciidoctor-diagram ArchitectureDocument.adoc`

- To create a pdf with mermaid, run this command :

`TODO`