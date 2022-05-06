ALTER TABLE users ADD cardnumber VARCHAR(50) NOT NULL;
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id VARCHAR(50) NOT NULL,
    receiver VARCHAR(50) NOT NULL,
    sender VARCHAR(50) NOT NULL,
    amount INT(20) NOT NULL DEFAULT '0',
    description TEXT NOT NULL,
    date VARCHAR(50) NULL,
)