/**
 Contains bogus keys and certificates just so that we can go through the whole motion of signing bits
 * For actual use, you need your own keys and valid certificates. see README.md
 */
def CREDENTIAL_DIR=new java.io.File("$CREDENTIAL").parentFile.path
//def CREDENTIAL_DIR="$(abspath $(dir $(lastword $(MAKEFILE_LIST))))/"

ext.GPG_KEYRING="${CREDENTIAL_DIR}test.gpg"
ext.GPG_SECRET_KEYRING="${CREDENTIAL_DIR}test.secret.gpg"
// file that contains GPG passphrase
ext.GPG_PASSPHRASE_FILE="${CREDENTIAL_DIR}test.gpg.password.txt"

ext.PKCS12_FILE="${CREDENTIAL_DIR}test.pkcs12"
ext.PKCS12_PASSWORD_FILE="${CREDENTIAL_DIR}test.pkcs12.password.txt"

ext.KEYCHAIN_FILE="${CREDENTIAL_DIR}test.keychain"
ext.KEYCHAIN_PASSWORD_FILE="${CREDENTIAL_DIR}test.keychain.password.txt"
