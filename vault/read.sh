#!/bin/bash

secrets_folder=/run/secrets

function read_secret() {
    echo "Please type the secret file you want to read or (a) for all secrets: "
    read -r secret_name
    if [ "$secret_name" == "a" ]
    then
        echo ""
        echo "##### Contents of secrets #####"
        echo ""
        keys=$(ls $secrets_folder)
        for key in ${keys[@]}
        do
            echo "$key: $(cat $secrets_folder/$key)"
        done
        echo ""
        echo "##### End of secrets #####"
        echo ""
    elif [ -f "$secrets_folder/$secret_name" ]
    then
        echo ""
        echo "##### Contents of $secret_name #####"
        echo ""
        cat "$secrets_folder/$secret_name"
        echo ""
        echo "##### End of $secret_name #####"
        echo ""
        exit 0
    else
        echo "File $secret_name does not exist."
        exit 1
    fi
}

echo "#######################"
echo "#                     #"
echo "#  Vault Reader v1.0  #"
echo "#                     #"
echo "#######################"
echo ""


echo "Username: "

read -r USERNAME

echo "Password: "

read -rs PASSWORD

if [ -f $secrets_folder/vault_username ] && [ -f $secrets_folder/vault_password ] && [ "$USERNAME" == "$(cat $secrets_folder/vault_username)" ] && [ "$PASSWORD" == "$(cat $secrets_folder/vault_password)" ]
then
    read_secret
else
    echo "Your credentials are incorrect. Exiting now..."
    exit 1
fi