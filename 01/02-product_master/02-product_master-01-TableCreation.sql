CREATE TABLE IF NOT EXISTS product_master (
    Product_no VARCHAR2(6) PRIMARY KEY START WITH P,
    Description VARCHAR2(40) NOT NULL,
    Profit_percent NUMBER(30) NOT NULL,
    Unit_measure  VARCHAR2(30) NOT NULL,
    Qty_on_hand NUMBER(15) NOT NULL,
    Reorder_level NUMBER(15) NOT NULL,
    Sell_price  NUMBER(6) NOT NULL CHECK (Sell_price <> 0),
    Cost_price NUMBER(10,2) NOT NULL CHECK (Cost_price <> 0)
);

-- CREATE TABLE IF NOT EXISTS product_master (
--     Product_no VARCHAR2(6) PRIMARY KEY CHECK (Product_no LIKE 'P%'),
--     Description VARCHAR2(40) NOT NULL,
--     Profit_percent NUMBER(30) NOT NULL,
--     Unit_measure VARCHAR2(30) NOT NULL,
--     Qty_on_hand NUMBER(15) NOT NULL,
--     Reorder_level NUMBER(15) NOT NULL,
--     Sell_price NUMBER(6) NOT NULL CHECK (Sell_price <> 0),
--     Cost_price NUMBER(10,2) NOT NULL CHECK (Cost_price <> 0)
-- );
