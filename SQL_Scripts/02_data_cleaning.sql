USE supply_chain_db;

-- Disable safe updates for bulk data transformation
SET SQL_SAFE_UPDATES = 0;

-- Format string dates to MySQL standard format (YYYY-MM-DD HH:MM:SS)
UPDATE raw_data 
SET order_date_DateOrders = STR_TO_DATE(order_date_DateOrders, '%m/%d/%Y %H:%i');

UPDATE raw_data 
SET shipping_date_DateOrders = STR_TO_DATE(shipping_date_DateOrders, '%m/%d/%Y %H:%i');

-- Convert column datatypes to DATETIME for time-intelligence analysis
ALTER TABLE raw_data 
MODIFY COLUMN order_date_DateOrders DATETIME NULL DEFAULT NULL;

ALTER TABLE raw_data 
MODIFY COLUMN shipping_date_DateOrders DATETIME NULL DEFAULT NULL;

-- Re-enable safe updates
SET SQL_SAFE_UPDATES = 1;


-- الكشف عن القيم الفاضية في العواميد الأساسية
SELECT 
    SUM(CASE WHEN Customer_Lname IS NULL OR Customer_Lname = '' THEN 1 ELSE 0 END) AS missing_last_names,
    SUM(CASE WHEN Product_Description IS NULL OR Product_Description = '' THEN 1 ELSE 0 END) AS missing_product_desc,
    SUM(CASE WHEN Order_Zipcode IS NULL OR Order_Zipcode = '' THEN 1 ELSE 0 END) AS missing_order_zipcodes
FROM raw_data;

-- 1. تنظيف عمود الاسم الأخير وملء الخانات الـ 8 الفاضية بـ Unknown
SET SQL_SAFE_UPDATES = 0;

UPDATE raw_data 
SET Customer_Lname = 'Unknown' 
WHERE Customer_Lname IS NULL OR Customer_Lname = '';

-- 2. حذف عمود وصف المنتج بالكامل لأنه فارغ تماماً ويهدر المساحة
ALTER TABLE raw_data 
DROP COLUMN Product_Description;

-- [قرار بيزنس / جودة البيانات] الإبقاء على القيم الفارغة في عمود الـ Zipcode (Keeping NULLs)
-- السبب: العمود يحتوي على 86% خانات فارغة، ولكن تم الإبقاء على الصفوف كاملة لحماية بيانات المبيعات والأرباح من الحذف.
-- خطة البديل (Workaround): سيتم الاعتماد كلياً على عواميد المدينة (Order_City) والدولة (Order_Country) السليمة بنسبة 100% عند عمل الخرائط والتقارير في Power BI.

SET SQL_SAFE_UPDATES = 1;



-- استكشاف حالات الطلب الفريدة وعدد تكرار كل حالة
SELECT 
    Order_Status, 
    COUNT(*) AS status_count
FROM raw_data
GROUP BY Order_Status
ORDER BY status_count DESC;

-- تحسين مساحة عمود حالة الطلب بناءً على أطوال الكلمات الحقيقية
ALTER TABLE raw_data 
MODIFY COLUMN Order_Status VARCHAR(50) NULL DEFAULT NULL;

-- [جودة البيانات] الكشف عن أخطاء الفوترة الحسابية وعيوب السيستم
-- الهدف: التأكد من عدم وجود فواتير تم تضخيمها بالخطأ وأثرت بالسلب على حسابات المبيعات
SELECT 
    COUNT(*) AS anomalous_rows,
    MIN(Sales) AS min_sales,
    MAX(Sales) AS max_sales
FROM raw_data
WHERE Order_Item_Total > Sales;

-- [جودة البيانات] الكشف عن القيم المتطرفة والأرقام الخيالية (Outliers Check)
-- الهدف: معرفة أقل وأعلى قيمة مبيعات ومتوسط الشغل للتأكد من عدم وجود أخطاء كيبورد (زي زيادة أصفار بالخطأ)
SELECT 
    MIN(Sales) AS lowest_sale,
    MAX(Sales) AS highest_sale,
    ROUND(AVG(Sales), 2) AS average_sale
FROM raw_data;

-- [جودة البيانات] الكشف عن الصفوف المكررة في الجدول (Duplicates Check)
-- الهدف: معرفة هل فيه شحنات مسمعة مرتين بالخطأ في السيستم
SELECT COUNT(*) AS total_duplicate_rows
FROM (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY Order_Id, Order_Item_Cardprod_Id, order_date_DateOrders 
               ORDER BY Order_Id
           ) AS row_num
    FROM raw_data
) AS subquery
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 0;


-- [سلامة البيانات] حذف الصفوف المكررة مباشرة باستخدام القائمة السوداء
-- الهدف: مسح الـ 20,756 صف المكررين مباشرة من الجدول بدون جداول بديلة
DELETE FROM raw_data 
WHERE Order_Item_Id IN (
    SELECT Order_Item_Id 
    FROM (
        SELECT Order_Item_Id,
               ROW_NUMBER() OVER(
                   PARTITION BY Order_Id, Order_Item_Cardprod_Id, order_date_DateOrders 
                   ORDER BY Order_Item_Id
               ) AS row_num
        FROM raw_data
    ) AS subquery
    WHERE row_num > 1
);


-- [جودة البيانات] التحقق النهائي من خلو الجدول تماماً من أي صفوف مكررة
SELECT COUNT(*) AS remaining_duplicates
FROM (
    SELECT ROW_NUMBER() OVER(
               PARTITION BY Order_Id, Order_Item_Cardprod_Id, order_date_DateOrders 
               ORDER BY Order_Item_Id
           ) AS row_num
    FROM raw_data
) AS subquery
WHERE row_num > 1;


-- إضافة أعمدة جاهزة للتحليل الزمني لتسريع تقارير البيزنس
ALTER TABLE raw_data 
ADD COLUMN Order_Year INT,
ADD COLUMN Order_Month INT,
ADD COLUMN Order_Day_Name VARCHAR(20);

-- تعبئة الأعمدة الجديدة من عمود التاريخ الأساسي
UPDATE raw_data 
SET Order_Year = YEAR(order_date_DateOrders),
    Order_Month = MONTH(order_date_DateOrders),
    Order_Day_Name = DAYNAME(order_date_DateOrders);
    
    select * from raw_data;