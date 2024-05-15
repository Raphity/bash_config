#!/bin/bash


filename="$1"

if [[ $# -eq 0 ]]; then
    echo "ERROR: need to provide a file to store password !" >&2
    exit 1
fi 

generatedpassword=$(python3 generate.py)
touch "$filename"
echo "$generatedpassword" >> "$filename"

if [[ ! -e "$filename" ]]; then
    echo "ERROR: cannot create password file!" >&2
    exit 1
fi

if [[ ! -s "$filename" ]]; then
    echo "ERROR: could not put password into provided file !" >&2
    exit 1
fi

cryptedfile="testfile"
touch "$cryptedfile"
openssl enc -aes-256-cbc -pbkdf2 -iter 10000 -salt -in "$filename" -out "$cryptedfile"

if [[ $? -eq 0 ]]; then
    echo "Encryption successful"
else
    echo "ERROR: encryption failed !" >&2
    echo "No password provided or password mismatched !" >&2
    rm "$filename"
    rm "testfile"
    exit 1
fi

rm "$filename"
mv "$cryptedfile" "$filename"

chmod 400 "$filename"

exit 0
