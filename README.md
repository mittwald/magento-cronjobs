# Magento cron job for systems without 'ps'

This is a  simple shell script for starting Magento cron jobs without the need of "ps".
The script uses lockfiles instead of ps to determine if the cronjob is running already.

## Usage

Just replace the default `cron.sh` that comes with your Magento installation with this script:

    cd /path/to/magento
    wget https://raw.githubusercontent.com/mittwald/magento-cronjobs/master/cron.sh
