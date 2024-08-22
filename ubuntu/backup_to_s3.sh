DB_NAME="linkbank"
DB_USER="linkbank"
DB_PASSWORD="lb51;c25e+10c7&1ee"
BACKUP_DIR="/home/linkbank/backups"
BACKUP_NAME="linkbank_$(date +\%Y-\%m-\%d).sql"
S3_BUCKET="s3://learna.backup/_linkbank/"

# Create the backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Export the database
mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_DIR/$BACKUP_NAME

# Upload the backup to S3
aws s3 cp $BACKUP_DIR/$BACKUP_NAME $S3_BUCKET

find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -exec rm {} \;