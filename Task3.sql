use task3;

select * from ecommerce_sql;


-- find out null values from data on the base of quantity is null
select * from ecommerce_sql where quantity IS NULL; 



-- find out the order from each country  
select Country , count(*) As TotalOrders from ecommerce_sql group by Country order by TotalOrders DESC;


--  orders of countries without UK
select Count(*) from ecommerce_sql where Country <> "United Kingdom";


-- Now find out the total order by a CustomerID from country 
select CustomerId,country, Count(*) as TotalOrders
 from ecommerce_sql group by CustomerId, Country order by TotalOrders desc; 
 
 
-- find out the total sales with the help of unitprice and Quantity
select * ,
UnitPrice * Quantity as TotalSales from ecommerce_sql;


-- now find the total sale from country
select country ,sum(UnitPrice * Quantity) As TotalSaleCountry from ecommerce_sql
group by country order by TotalSaleCountry desc;  


			-- Avg sales to customer id with country 
select customerID , Country, avg(UnitPrice*Quantity) as AvgSale 
from ecommerce_sql 
group by customerID,Country
order by AvgSale Desc;



-- now find avg sales for a customerid by using subquerry
select customerId,country, avg(TotalSale) As AvgSale
from(
select Customerid,country, unitprice*Quantity as totalSale 
from ecommerce_sql) as sales_data
group by customerId,country
order by avgsale DESC; 


				-- which stockCode(stock) give more sales
select Stockcode,description, sum(TotalSale) as TotalSaleProduct
from(
select Stockcode,description, UnitPrice*Quantity as totalSale
from ecommerce_sql) as sales_data
group by StockCode,description
order by totalSaleProduct DESC;


-- sales by country and stocks

select stockcode,description,country , sum(TotalSale) as SaleProductCountry
from(
select stockcode,description,country , Unitprice*quantity as totalsale
from ecommerce_sql) as sale_data
group by stockcode,description,country
order by saleProductCountry Desc;
 
 
 -- create view (here we create a new table in database which show total sale of product code by country)
 
 create view V_total_sales_by_product as
 select stockcode,description,country , sum(TotalSale) as SaleProductCountry
from(
select stockcode,description,country , Unitprice*quantity as totalsale
from ecommerce_sql) as sale_data
group by stockcode,description,country
order by saleProductCountry Desc;


select * from v_total_sales_by_product;



-- now creta another view(table) which give total sale of each country

create view total_sale as 
select country ,sum(UnitPrice * Quantity) As TotalSaleCountry from ecommerce_sql
group by country order by TotalSaleCountry desc;  


--  creat indexex in tables
 create index idx on ecommerce_sql(InvoiceNo);
 

 