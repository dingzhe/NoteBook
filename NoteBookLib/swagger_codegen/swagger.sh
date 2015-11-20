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
rm -f NoteBookLib/$DES_DIR/*
                          
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
