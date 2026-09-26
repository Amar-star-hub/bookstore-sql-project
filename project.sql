create table books (
Book_ID SERIAL PRIMERY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(100),
Published_Year INT,
Price NUMERIC(10,2)
Stock INT

);
CREATE TABLE customer(
Customer_ID SERIAL PRIMARY KEY,
NAME VARCHAR(100),
Email VARCHAR(100),

Phone varchar(100),
City varchar(50),
Country varchar(20)

);
create table orders(
order_id serial primary key,
customer_id int refrences customers(customer_id),
book_id int refrences books(book_id),
quantity int,
total_amount numeric(10,2)

);
select * from orders;
select * from books;
select * from customers;


 --1) retrives all books in the "fiction" genre :
 select * from books
 where genre='Fiction';
 --2)find the book published after the year 1950:
 select * from books 
 where published_year>1950;
 -- 3) list all customers from the canada:
 select * from customers
 where country='Canada';
 -- 4) show order placed in november 2023:
 select * from orders
 where order_date between '2023-11-01' and '2023-11-30';
 -- 5) retrives the total stock of books available:
 select sum(stock) as total_stock
 from books;
-- 6) find the details of most expensive book :
select * from books order by price desc limit 1; 
--7)show all customers who ordered more than 1 quantity of a book :
select * from orders
where quantity >1;
--8)retrives all orders where the total amount exceed  $20:

select * from orders
where total_amount>20;
--9)list all genre available in the books table:
select distinct genre from books;
--10) find the books with the lowest stock:
select * from books order by stock asc limit 1;
--11)calculate the total revenue generated from all orders:

select sum(total_amount )as revenue
from orders;
-- advance question :
--1) retrives the total number of boooks sold for each genre:

select b.genre,sum(o.quantity)as total_books_sold
from orders o
join books b on o.book_id=b.book_id
group by b.genre;
--2) find the average price of books in the "fantacy"genre:
select avg(price)as average_price
from books
where genre='Fantasy';
--3) LIST customer who have placed at least 2 orders:
select customer_id,count(order_id)as order_count
from orders
group by customer_id
having count(order_id)>=2;
--4)find the most frequently ordered  book:
select o.book_id,b.title,count(o.order_id)as order_count
from orders o
join books b on b.book_id=o.book_id
group by o.book_id,b.title
order by order_count desc limit 1;
--5)show the top 3 most expensive books of 'fantacy' genre:

select * from books
where genre='Fantasy'
order by price desc limit 3;
--6)retrives the total quantity of books sold by each author:
select b.author,sum(o.quantity) as total_books_sold
from orders o
join books b on o.book_id=b.book_id
group by b.author;
--7)list the cities where customer who spent over $30 are located:
select distinct c.city,total_amount
from orders o
join customers c on o.customer_id=c.customer_id
where o.total_amount>30;
--8)find the customer who spent the most who spent the most on orders:
select c.customer_id,c.name,sum(o.total_amount)as total_spent
from orders o
join customers c on o.customer_id = c.customer_id
group by c.customer_id,c.name 
order by total_spent desc;
