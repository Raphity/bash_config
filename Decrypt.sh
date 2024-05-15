#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file="$1"

decrypted_content=$(openssl enc -d -aes-256-cbc -pbkdf2 -in "$input_file")

if [ $? -eq 0 ]; then
    echo "Decryption successful:"
    echo "$decrypted_content"
else
    echo "Decryption failed." >&2
    exit 1
fi
