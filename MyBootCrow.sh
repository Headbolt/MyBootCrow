#!/bin/bash

#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	MyBootCrow.sh
#	https://github.com/Headbolt/MyBootCrow
#
#   This Script is designed for use in JAMF
#
#   - This script will ...
#       Set the password for a specified account
#       Deletes the Login Keychain to avoid issues with the Keychain password not matching
#       Checks if user is in FileVault and then updates filevault as well
#
###############################################################################################################################################
#
# Notes: Does not require knowledge of previous password.
#
# Requires the following parameters be set.
#     ! setUsername: $4
#     ! setPassword: $5
#
###############################################################################################################################################
#
# HISTORY
#
#   Version: 1.1 - 14/10/2019
#
#   - 13/03/2018 - V1.0 - Created by Headbolt
#
#   - 14/10/2019 - V1.1 - Updated by Headbolt
#                           More comprehensive error checking and notation
#
####################################################################################################
#
#   DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################
#
setUsername=$4 # Grab the username for user whose password we want to change from JAMF variable #4 eg. username
setPassword=$5 # Grab the new password for user whose password we want to change from JAMF variable #5 eg. password
ScriptName="Security | Escrow Bootstrap Token" # Set the name of the script for later logging
#
####################################################################################################
#
#   Checking and Setting Variables Complete
#
###############################################################################################################################################
# 
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Variable Check Function
#
VarCheck(){
#
/bin/echo 'Checking that the required Variables are set' # Check that the required variables are set
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
if [ "$setUsername" == "" ]
	then
		/bin/echo 'This script requires a username.'
		SectionEnd
		ScriptEnd
		exit 1
fi
#
if [ "$setPassword" == "" ]
	then
		/bin/echo 'This script requires a password.'
		SectionEnd
		ScriptEnd
		exit 1
fi
#
/bin/echo 'Required Variables appear to be set'
#
}
#
###############################################################################################################################################
#
# Section End Function
#
SectionEnd(){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Script End Function
#
ScriptEnd(){
#
# Outputting a Blank Line for Reporting Purposes
#/bin/echo
#
/bin/echo Ending Script '"'$ScriptName'"'
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
# 
# Begin Processing
#
####################################################################################################
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
SectionEnd
#
sudo profiles install -type bootstraptoken -user $setUsername -password $setPassword #Escrow the token
sudo jamf recon #force the Mac to send inventory to update the EA - but the escrow is immediate if the Mac is online.
#
ScriptEnd
