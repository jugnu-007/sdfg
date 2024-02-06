CREATE TABLE IF NOT EXISTS client_master (
    Client_no VARCHAR(6),
    Name VARCHAR(30),
    Address1 VARCHAR(30),
    Address2 VARCHAR(30),
    City VARCHAR(15),
    State VARCHAR(15),
    Pincode INT,
    Balance_due DECIMAL(10,2)
);
