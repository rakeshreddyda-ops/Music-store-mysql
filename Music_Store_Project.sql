/*Logic 
1)
To find senior most employee by job title i have filtered data based on highest levels which gives the highest value
and I performed limit to get first value */
SELECT 
*
FROM employee
ORDER BY levels desc
LIMIT 1;

/*Logic
2)
To retrive the country that have highestt invoices , I had counted all the invoices and 
ordered the count in descending order and limit 1 is executed to give the first value
*/
select billing_country, count(*) as c from invoice
group by billing_country
order  by c desc
limit 1;

/*Logic
3)
To retrive the the top 3 values of total invoice i had summed up the total 
and grouped with the countries and ordered in descending to get the top 3 values
i had used limit 3
*/
select billing_country, sum(total) as total_sum from invoice
group by billing_country
order  by total_sum desc
limit 3;

/*Logic
4)
To retrive the best city that has highest invoice total i had used sum aggregation to find the total sum of invoices
and grouped with the billing_city o& arranged nthe total_sum value in descending and limit 1 is applied to get starting
value
*/
select billing_city, sum(total) as total_invoice_sum from invoice
group by billing_city
order  by total_invoice_sum desc
limit 1;

/*Logic
5)
To retrive the customer who had spent most money, I calculates sum of quantity*unitprice 
and i join multiple tables like customer,invoice,invoiceline to get the data that is accessible
as the required columns are in different tables and finally i applied group by and ordered the totalsales by descending order
and limit 1 is used to get the first customer and that is the customer who spent the most money and to display only customer name i used 
the aggregation output as a table using from subquery
*/
select customer_id,first_name,last_name from(select c.customer_id,c.first_name,c.last_name, sum(il.unit_price * il.quantity) as total_sum from customer c
left join invoice i 
on c.customer_id=i.customer_id
join invoiceline il on i.invoice_id=il.invoice_id
group by c.customer_id,c.first_name,c.last_name
order by total_sum desc
limit 1)st;

/*Logic
6)
To find the customer first name last name and email who likes rock genre 
I had used combination of joins on multiple tables like customer,invoice,invoiceline,genre,track
to get the result and email is ordered by ascending so that email starting with A comes first and
remaining data follows 
*/
select  distinct c.first_name,c.last_name,c.email,g.name from customer c
join invoice i on c.customer_id=i.customer_id
join invoiceline l on i.invoice_id=l.invoice_id
join track t on t.track_id=l.track_id
join genre g on g.genre_id=t.genre_id
where g.name='Rock'
order by c.email;

/*Logic
7)
To get top 10 artists i had counted track counts and ordered them by descecnding 
to acheive this i had used joins on multiple tables like track,genre,album,artist
so that we can access that data in different tables and applied where clause with filter to grt rock genre , i used limit 10 to
get top 10 artists  in rock genre and finally to get only names of top 10 artists i used 
the aggregation output as a table using from subquery
*/
select name from(select a.name,count(*) as count_ from track t
join genre g on t.genre_id=g.genre_id 
join album ab on  t.album_id=ab.album_id
join artist a on ab.artist_id=a.artist_id
where g.name='Rock'
group by a.name
order by count_ desc
limit 10 )st;

/*Logic
8)
To get the song name whose song length is greater than average song lenth i used avg aggregation function
and the result is used as subquery to filter within where clause and ordered the songs with respective to 
milliseconds column with descending so that longest songs will appear first
*/
select name from track
where milliseconds >(SELECT avg(milliseconds) FROM track)
order by milliseconds desc;


/*Logic
9)
To get the amount spent by the customer on each artist I calculated sum of product of the unitprice and quantity 
and to retrive customer name,artist name and totalsales i used joins on multiple tables and finally i used group by
with each artist name and customer name to get the aount that has spend by the customer on each artist and i used 
(optional) ordered by with total amount in desc so that highest value will come first and rest follows
*/
select c.first_name,c.last_name,a.name,sum(il.unit_price * il.quantity) as Total_amount from customer c
join invoice i on c.customer_id=i.customer_id
join invoiceline il on i.invoice_id=il.invoice_id
join track t on t.track_id=il.track_id
join album ab on ab.album_id=t.album_id
join artist a on a.artist_id=ab.artist_id
group by  c.first_name,c.last_name,a.name
order by total_amount desc;

/*Logic
10)
To get the each country with its top genre 
First i calculated total sales and by using joins on multiple tables like invoice,invoiceline,track,genre
i retrived country ,genre anme with respective totalsales amount
Second, I took the above output as a table by using subquery with from and i applied dense_rank window function to give rank based on totalsales
Here i did partition with respect to country and ordered totalsales descendingly
Finally i took above output as input table using as subquery with from and used where clause to filter ranking that has 1
and retrived country with top genre name
*/
select billing_country,name from
(select billing_country,name,total_sales,
dense_rank () over (partition by billing_country order by Total_sales desc) as ranking
from
(select i.billing_country,g.name,sum(il.unit_price * il.quantity) Total_sales 
from invoice i
join invoiceline il on i.invoice_id=il.invoice_id
join track t on il.track_id=t.track_id
join genre g on g.genre_id=t.genre_id
group by i.billing_country,g.name)st)rt
where ranking=1;

/*Logic
11)
First,I calculated total sales and by using joins on multiple tables like customer,invoice and invoiceline
i retrived customer id , customer-name and country with respective totalsales amount
Second, I took the above output as a table by using subquery with from and i applied dense_rank window function to give rank based on totalsales
Here i did partition with respect to country and ordered totalsales descendingly
Finally i took above output as input table using as subquery with from and used where clause to filter ranking that has 1
and retrived customer who had spent most on music from each country 
*/
select customer_id,first_name,last_name,billing_country from
(select customer_id,first_name,last_name,billing_country,Total_sales,
dense_rank () over (partition by billing_country order by Total_sales desc) rnk from
(select c.customer_id,c.first_name,c.last_name,i.billing_country,sum(il.unit_price * il.quantity) Total_sales from 
customer c 
join invoice i on c.customer_id=i.customer_id
join invoiceline il on i.invoice_id=il.invoice_id
group by c.customer_id,c.first_name,c.last_name,i.billing_country)st)rt
where rnk=1;