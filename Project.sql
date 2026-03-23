-- Create Book Table.
CREATE TABLE Books(
	Book_ID INT PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(100),
	Published_Year INT,
	Price NUMERIC(10,2),
	Stock INT
);

SELECT * FROM Books;

-- Create Customer Table.
CREATE TABLE Customers(
	Customer_ID INT PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone INT,
	City VARCHAR(100),
	Country VARCHAR(100)
);

SELECT * FROM Customers;

-- Create Orders Table.
CREATE TABLE Orders(
	Order_ID INT PRIMARY KEY,
	Customer_ID INT,
	Book_ID INT,
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);

SELECT * FROM Orders;

-- Basic Quetions

-- 1. Retrieve all books in fiction genre.
SELECT * FROM Books
WHERE Genre='Fiction';

-- 2. Find books published after the year 1950.
SELECT * FROM Books
WHERE Published_year>1950;

-- 3. List all customers from the canada.
SELECT * FROM Customers
WHERE Country='Canada';

-- 4. Show Orders placed in Nov 2023.
SELECT * FROM orders
Where Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5. Retrieve the total stock of book available.
SELECT SUM(Stock) AS Total_Stock FROM Books;

-- 6. Find the details of most expensive books.
SELECT * FROM Books
ORDER BY Price DESC LIMIT 1;

-- 7. Show all customers who ordered more than 1 quantity of a book.
SELECT * FROM Orders
WHERE Quantity>1;

-- 8. Retrieve all orders where the total amount exceeds $20.
SELECT * FROM Orders
WHERE Total_Amount>20.00;

-- 9. List all genre available in books table.
SELECT DISTINCT Genre FROM Books;

--  10. Find the book with lowest stock.
SELECT * FROM Books
ORDER BY stock;

-- 11. Calculate the total revenue generated from all orders.
SELECT SUM(Total_Amount) AS Revenue FROM Orders;

-- Advanced Queries.

-- 1. Retrieve the total number of books sold for each genre.
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- 2. Find the Average price of books in the 'Fantasy' genre.
SELECT AVG(price) AS Avg_of_Fantacy
FROM Books
WHERE Genre='Fantasy';

-- 3. List customer who have placed at least 2 orders.
SELECT o.Customer_id, c.name, COUNT(o.order_id) AS Order_count
FROM Orders o
JOIN Customers c ON o.Customer_id = c.Customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(order_id) >= 2;

-- 4. Find the most frequently ordered book.
SELECT o.book_id, b.title, COUNT(o.order_id) AS Order_COUNT
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY Order_COUNT DESC LIMIT 10;

-- 5. Show the top 3 most expensive books of 'Fantasy' Genre.
SELECT * FROM Books
WHERE Genre='Fantasy'
ORDER BY Price DESC LIMIT 3;

-- 6. Retrieve the total quantity of books sold by each author.
SELECT b.author, SUM(o.quantity) AS Book_sold
FROM Orders o
JOIN Books b ON o.book_id=b.book_id
GROUP BY b.author;

-- 7. List the cities where customers who spent over $30 are located.
SELECT DISTINCT c.City 
FROM Customers c
JOIN Orders o ON c.Customer_id=o.Customer_id
WHERE o.Total_Amount > 30.00;

-- 8. Find the customer who spent the most on orders.
SELECT c.name, SUM(o.Total_Amount) AS Total_Spend
FROM Customers c
JOIN Orders o ON c.Customer_id=o.Customer_id
GROUP BY c.name
ORDER BY Total_Spend DESC LIMIT 1;

-- 9. Calculate the stock remaining after fulfilling all orders.
SELECT b.Book_id, b.Title,
       b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Stock
FROM Books b
LEFT JOIN Orders o ON b.Book_id = o.Book_id
GROUP BY b.Book_id, b.Title, b.Stock;