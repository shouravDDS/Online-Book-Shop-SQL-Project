-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;

SELECT * FROM Customers;

SELECT * FROM Orders;


--Retrive all the fiction books 
select *from books
where genre in ('Fiction');

--find books publish after the 1950
select * from books
where published_year>1950;


--find the customer from canada
select * from customers
where country = 'Canada';


--Find the order november 2023
select * from orders
where order_date between '2023/09/01' and '2023/09/30';

--Retrive the total stock of books available
select sum(stock) as total_stock from books;

---find the details of the most expensive books 
select * from books order by price desc;


--show all books who ordered more then  1 quantity of book
select * from orders 
where quantity>1;


--show all books where total amount more then 20$
select * from orders 
where total_amount>20;


---list all the genre in the books table 
select distinct(genre) as Unique_list
from books;


---find the lowest stock of the books
select * from books order by stock asc limit 10;


--Calculate the total revenue generate the order 
select sum(total_amount) as Total_Revenue
from orders;


SELECT * FROM Books;

SELECT * FROM Customers;

SELECT * FROM Orders;


--retrive the total number of books sold for each genre
select b.genre,sum(o.quantity) as Total_quantity
from books b
join orders o
on b.book_id= o.book_id
group by genre;


--find the average price of the books in the  "Fantasy" genre

select avg(price) as average_price_of_Fantasy
from books 
where genre in ('Fantasy');

---list customer who have plased at list 2 order
select c.name,c.customer_id, count(o.order_id) as order_count
from customers c
join orders o
on c.customer_id= o.customer_id
group by c.name,c.customer_id
having count(o.order_id)>2;


--Find the most frequently order book
select b.book_id,b.title ,count(o.order_id) as book_frequently
from books b
join orders o
on b.book_id=o.book_id
group by b.book_id,b.title
order by book_frequently desc limit 2;


--Find the average price of book in the "Fantacy"
select avg(price) as Fantasy_book_avarage_price
from books
where genre in ('Fantasy');


--show the top 3 most expensive book of "Fantasy" genre
select *
from books
where genre='Fantasy'
order by price desc 
limit 3;

--Retrive the total quantity of the books sold by each author
select b.author, sum(o.quantity) as Total_books
from books b
join orders o
on b.book_id=o.book_id
group by b.author
order by total_books desc;


--List the cities where customer who spent 30$ are located
select distinct c.city, o.total_amount
from customers c
join orders o
on c.customer_id= o.customer_id
where o.total_amount>300;

--find the customer who spent most on order
select c.name, sum(o.total_amount) as Total_cost
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.name
order by Total_cost desc;




SELECT * FROM Books;

SELECT * FROM Customers;

SELECT * FROM Orders;

--calculate the stock remaining after fulfill the stock
select b.book_id, b.title,b.stock,
		coalesce(sum(quantity),0) as order_quantity,
		b.stock-coalesce(sum(quantity),0) as Final_stock
from books b
left join orders o
on b.book_id= o.book_id
group by b.book_id
order by b.book_id;






