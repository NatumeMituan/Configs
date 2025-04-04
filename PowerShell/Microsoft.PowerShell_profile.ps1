# Define the profile directory
$profileDirectory = Split-Path -Parent $PROFILE

# Dot source additional profile scripts
. "$profileDirectory\profile_functions.ps1"
. "$profileDirectory\profile_aliases.ps1"
. "$profileDirectory\profile_settings.ps1"
