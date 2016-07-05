Bolome code generation tools

- code-gen
    Code gen wrapper wrote in bash script.

- swagger-codegen-distribution-2.1.2-M1.jar
    Code gen jar, providing core functionalities, built from https://github.com/swagger-api/swagger-codegen

- swagger.yaml
    Yaml swagger specification for Bolome restful service, can be used to generate swagger.json

- swagger.json
    Json swagger specification for Bolome restful service, can be used by Swagger CodeGen and Swagger UI.

##How to Use

- Build 'bolome_swagger_gencode' to generate code
- Or manually execute: 'code-gen swagger.json objc .'
```shell
#! /bin/bash
TMP_DIR=.
DES_DIR=noteApiSDK
TOOL_DIR=swagger_codegen
GEN_HEADER=NoteBookLib_gen.h

echo "Generating source codes into temp folder..."
$TOOL_DIR/code-gen $TOOL_DIR/swagger.json objc $TMP_DIR >/dev/null 2>&1

if [[ $? == 0 ]]; then
echo "Clean generated files..."
rm -f NoteBookLib/$GEN_HEADER
rm -f NoteBookLib/$DES_DIR
                           
echo "Generating $GEN_HEADER"
                           
for file in $(ls "$TMP_DIR/client" | grep \\.h); do
echo "#import \"$DES_DIR/$file\"" >> NoteBookLib/$GEN_HEADER
done
                           
echo "Moving generted files..."
mkdir -p "NoteBookLib/$DES_DIR"
mv $TMP_DIR/client/* NoteBookLib/$DES_DIR/
                           
rm -r "$TMP_DIR/client"
rm -f "$TMP_DIR/Podfile"
fi
```
