USE supply_chain_db;

ALTER TABLE `supply_chain_db`.`raw_data` 
    CHANGE COLUMN `Days_for_shipping_real` `Days_for_shipping_real` INT NULL DEFAULT NULL,
    CHANGE COLUMN `Days_for_shipment_scheduled` `Days_for_shipment_scheduled` INT NULL DEFAULT NULL,
    CHANGE COLUMN `Order_Id` `Order_Id` VARCHAR(255) NULL DEFAULT NULL,
    CHANGE COLUMN `Benefit_per_order` `Benefit_per_order` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Sales_per_customer` `Sales_per_customer` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Late_delivery_risk` `Late_delivery_risk` INT NULL DEFAULT NULL,
    CHANGE COLUMN `Latitude` `Latitude` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Longitude` `Longitude` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Order_Item_Discount` `Order_Item_Discount` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Order_Item_Discount_Rate` `Order_Item_Discount_Rate` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Order_Item_Product_Price` `Order_Item_Product_Price` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Order_Item_Profit_Ratio` `Order_Item_Profit_Ratio` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Order_Item_Quantity` `Order_Item_Quantity` INT NULL DEFAULT NULL,
    CHANGE COLUMN `Sales` `Sales` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Order_Item_Total` `Order_Item_Total` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Order_Profit_Per_Order` `Order_Profit_Per_Order` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Product_Price` `Product_Price` DECIMAL(10,2) NULL DEFAULT NULL,
    CHANGE COLUMN `Product_Status` `Product_Status` INT NULL DEFAULT NULL;