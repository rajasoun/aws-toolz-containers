#!/usr/bin/env bash

user_name="Raja Soundaramourty"
user_email="rajasoun@cisco.com"

function create_gpg_keys(){
	CN=$user_name
	EMAIL=$user_email
    gpg2 --full-generate-key --batch  <<EOF
%echo Generating a GPG key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Subkey-Usage: encrypt
Name-Real: $CN
Name-Email: $EMAIL
Expire-Date: 1y
%no-protection
%commit
%echo Done
EOF
}

function store_gpg_keys(){
    gpg2 --export -a "$EMAIL" > "${PWD}/.config/.gpg2/keys/public.key"
    gpg2 --export-secret-keys --armor > "${PWD}/.config/.gpg2/keys/private.key"
}

function list_gpg_keys(){
    gpg2 --list-keys
}

function generate_gpg_keys(){
    PGP_DIR=".config/.gpg2/keys"
	mkdir -p $PGP_DIR
	find "$PGP_DIR" -type f -exec chmod 600 {} \; # Set 600 for files
	find "$PGP_DIR" -type d -exec chmod 700 {} \; # Set 700 for directories
	if [ ! -d "${PWD}/.config/.gpg2/keys/public.key" ]; then
		create_gpg_keys
		list_gpg_keys
		store_gpg_keys
	else
		echo -e "GPG Key Exists. Run -> clean_configs to remove all configs"
	fi
}

function init_pass_store(){
	EMAIL=$(gpg2 --list-keys | grep uid | awk '{print $5}' | tr -d '<>')
	if [ ! -f ".config/.store/.gpg-id" ];then
		pass init $EMAIL
	fi
}

generate_gpg_keys
init_pass_store

