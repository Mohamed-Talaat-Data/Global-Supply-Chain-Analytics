-- 1. حساب إجمالي المبيعات، إجمالي الأرباح، ومتوسط قيمة الأوردر
SELECT 
    FORMAT(SUM(Sales), 2) AS Total_Sales,
    FORMAT(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
    FORMAT(AVG(Sales), 2) AS Average_Order_Value 
FROM raw_data;
-- ==============================================
-- 2. تحليل المبيعات والأرباح حسب السنوات مع تنسيق الأرقام
SELECT 
    Order_Year,
    FORMAT(SUM(Sales), 2) AS Yearly_Sales,
    FORMAT(SUM(Order_Profit_Per_Order), 2) AS Yearly_Profit,
    FORMAT(COUNT(DISTINCT Order_Id), 0) AS Total_Orders 
FROM raw_data
GROUP BY Order_Year
ORDER BY Order_Year DESC;
-- ==============================================
-- التأكد من تواريخ بداية ونهاية البيانات في سنة 2018
SELECT 
    MIN(order_date_DateOrders) AS First_Order_2018,
    MAX(order_date_DateOrders) AS Last_Order_2018
FROM raw_data
WHERE Order_Year = 2018;
-- ==============================================
-- 3. تحليل المواسم: ترتيب شهور السنة من الاعلى مبيعات للاقل مبيعات
-- الغرض: تحديد اكثر الشهور تحقيق للايرادات لمعرفة مواسم الشغل والذروة
SELECT 
    Order_Month,
    FORMAT(SUM(Sales), 2) AS Monthly_Sales,
    FORMAT(SUM(Order_Profit_Per_Order), 2) AS Monthly_Profit,
    FORMAT(COUNT(DISTINCT Order_Id), 0) AS Total_Orders
FROM raw_data
GROUP BY Order_Month
ORDER BY SUM(Sales) DESC; 
-- ==============================================
-- 4. تحليل أيام الاسبوع: معرفة الايام الاكثر طلبا ومبيعات
-- الغرض: معرفة سلوك المشتري وتحديد الايام اللي نكثف فيها اعلانات
SELECT 
    Order_Day_Name,
    FORMAT(SUM(Sales), 2) AS Daily_Sales,
    FORMAT(SUM(Order_Profit_Per_Order), 2) AS Daily_Profit,
    FORMAT(COUNT(DISTINCT Order_Id), 0) AS Total_Orders
FROM raw_data
GROUP BY Order_Day_Name
ORDER BY SUM(Sales) DESC; 
-- ==============================================
-- 5. تحليل طرق الدفع: معرفة الطرق الاكثر استخداما في البيع
-- الغرض: تحديد الطريقة المفضلة للزبون وتوفير عروض عليها
SELECT 
    `Type` AS Payment_Method, 
    FORMAT(SUM(Sales), 2) AS Total_Sales,
    FORMAT(COUNT(DISTINCT Order_Id), 0) AS Total_Orders
FROM raw_data
GROUP BY `Type`
ORDER BY SUM(Sales) DESC;
-- ==============================================
-- 6. تحليل الاقسام: معرفة الاعلى مبيعات وارباح في الشركة
-- الغرض: تحديد الاقسام الرابحة لزيادة الاستثمار فيها
SELECT 
    Category_Name AS Category, 
    FORMAT(SUM(Sales), 2) AS Total_Sales,
    FORMAT(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
    FORMAT(COUNT(DISTINCT Order_Id), 0) AS Total_Orders
FROM raw_data
GROUP BY Category_Name
ORDER BY SUM(Sales) DESC 
LIMIT 10; 
-- ==============================================
-- 7. تحليل الاقسام الخاسرة: معرفة المنتجات اللي بتخسر الشركة
-- الغرض: تحديد نزيف الارباح واتخاذ قرار بوقف المنتج او تعديل سعره
SELECT 
    Category_Name AS Category,
    FORMAT(SUM(Sales), 2) AS Total_Sales,
    FORMAT(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
    FORMAT(COUNT(DISTINCT Order_Id), 0) AS Total_Orders
FROM raw_data
GROUP BY Category_Name
ORDER BY SUM(Order_Profit_Per_Order) ASC 
LIMIT 10;
-- ==============================================
-- تحليل اعلى الدول تحقيق للمبيعات والارباح
SELECT 
    Order_Country AS Country,
    FORMAT(SUM(Sales), 2) AS Total_Sales,
    FORMAT(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
    FORMAT(COUNT(DISTINCT Order_Id), 0) AS Total_Orders
FROM raw_data
GROUP BY Order_Country
ORDER BY SUM(Sales) DESC
LIMIT 10;
