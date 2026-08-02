import pandas as pd
import matplotlib.pyplot as plt
from sqlalchemy import create_engine
import seaborn as sns



#-----------------------------------------------------------------
# تحليل موسمي للمبيعات لاكتشاف شهور الذروة التي يجب زيادة المخزون فيها
#-----------------------------------------------------------------
#الاتصال بقاعدة البيانات
db_connection_str = 'mysql+pymysql://root:your_password@localhost/supply_chain_db'
db_connection = create_engine(db_connection_str)

# استخراج البيانات
query = "SELECT * FROM raw_data"
df = pd.read_sql(query, db_connection)



# نجهز الداتا ونرتبها حسب الشهر
monthly_sales = df.groupby('Order_Month')['Sales'].sum().reset_index()

# عرض النتائج
plt.figure(figsize=(12, 6))
sns.barplot(data=monthly_sales, x='Order_Month', y='Sales', palette='rocket')

plt.title('Total Sales Trend by Month', fontsize=16)
plt.xlabel('Month', fontsize=12)
plt.ylabel('Sales', fontsize=12)
plt.grid(axis='y', linestyle='--', alpha=0.7)


plt.show()