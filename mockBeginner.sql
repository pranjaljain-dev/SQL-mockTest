-- Basic Queries
-- 1. Write a query to display all the authors in the database.
select
    *
from
    authors;

-- 2. Retrieve the names and emails of all customers who joined after February 1, 2023.
select
    name,
    email
from
    customers
where
    joindate > '2023-02-01';

-- 3. Find all books in the 'Fantasy' genre.
select
    title
from
    books
where
    genre = 'Fantasy';

-- 4. Display the total number of books available in stock.
select
    sum(stock) as available_books
from
    books;

-- Intermediate Queries
-- 5. Show the total revenue generated from all orders.
select
    sum(totalprice) as revenue
from
    orders;

-- 6. List the details of orders placed by the customer named 'Alice Johnson.'
select
    o.orderid,
    c.name,
    o.bookid,
    o.orderdate,
    o.quantity,
    o.totalprice
from
    orders o
    join customers c on o.customerid = c.customerid
where
    c.name = 'Alice Johnson';

-- 7. Identify the book with the highest price.
select
    title,
    price
from
    books
where
    price = (
        select
            max(price)
        from
            books
    );

-- 8. Retrieve the details of books that have less than 50 units in stock.
select
    bookid,
    title,
    genre,
    price
from
    books
where
    stock < 50;

-- Joins
-- 9. Write a query to list all books along with their author's name.
select
    a.name as author_name,
    b.title as book_name
from
    books b
    join authors a on b.authorid = a.authorid;

-- 10. Display all orders with the customer name and book title included.
select
    o.orderid,
    c.name as customer,
    b.title as book,
    o.quantity,
    o.totalprice
from
    orders o
    join customers c on o.customerid = c.customerid
    join books b on o.bookid = b.bookid;

-- Aggregations
-- 11. Calculate the total number of orders placed by each customer.
select
    customerid,
    count(orderid) as total_orders
from
    orders
group by
    customerid;

-- 12. Find the average price of books in the 'Fiction' genre.
select
    title,
    avg(price) as average_price
from
    books
where
    genre = 'Fiction'
group by
    title;

-- 13. Determine the author whose books have the highest combined stock.
select
    a.name,
    sum(b.stock) as total_stock
from
    books b
    join authors a on b.authorid = b.authorid
group by
    a.name
order by
    total_stock desc
limit
    1;

-- Filtering
-- 14. Retrieve the names of authors born before 1950.
select
    name
from
    authors
where
    birthyear < '1950';

-- 15. Find all customers from the 'United Kingdom.'
select
    *
from
    customers
where
    country = 'United Kingdom';

-- Advanced Queries
-- 16. Write a query to list all books that have been ordered more than once.
select
    b.title
from
    books b
    join orders o on b.bookid = o.bookid
group by
    b.title
having
    count(o.orderid) > 1;

-- 17. Identify the top-selling book based on the quantity sold.
select
    b.title
from
    books b
    join orders o on b.bookid = o.bookid
where
    o.quantity > 1
order by
    o.quantity desc
limit
    1;

-- 18. Calculate the total stock value for each book (price * stock).
select
    title,
    sum(price * stock)
from
    books
group by
    title;

-- Subqueries
-- 19. Write a query to find the name of the customer who placed the most expensive order.
select
    c.name as customer,
    o.totalprice
from
    customers c
    join orders o on c.customerid = o.customerid
where
    o.totalprice = (
        select
            max(totalprice)
        from
            orders
    );

-- 20. Retrieve all books that have not been ordered yet.
select
    b.title as book_name
from
    books b
    join orders o on o.bookid = b.bookid
where
    o.bookid not in (
        select
            o.bookid
        from
            orders o
    );