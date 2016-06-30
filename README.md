# Magento-Cron for systems without 'ps'

This is a  simple shellscript for starting Magento-cronjobs without the need of "ps".
The script uses lockfiles instead of ps to determine if the cronjob is running already.

## Usage

Just replace the default cron.sh that comes with your Magento installation, with this script.
