CREATE DATABASE Library;
USE Library;
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(20),
    category_description VARCHAR(MAX)
);
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(20),
    book_author VARCHAR(20),
    book_genre VARCHAR(20),
    publication_year INT,
    availability_status VARCHAR(20),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(20),
    contact_information VARCHAR(20),
    membership_type VARCHAR(20),
    registration_date DATE
);

CREATE TABLE library_staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(20),
    contact_information VARCHAR(20),
    assigned_section VARCHAR(20),
    employment_date DATE
);

CREATE TABLE MemberBook (
    borrowing_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrowing_date DATE,
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    reservation_date DATE,
    reservation_status VARCHAR(20),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
CREATE TABLE financial_fines (
    fine_id INT PRIMARY KEY,
    member_id INT,
    fine_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO categories VALUES
(1, 'Science', 'works of non-fiction, often referred to as popular science, that make complex scientific concepts'),
(2, 'Technology', 'Books about programming, databases,Hardware,and software'),
(3, 'Technology', 'Books about programming, databases,Hardware,and softwares'),
(4, 'History', 'Books covering historical events and periods'),
(5, 'Mathematics', 'Classic and modern literary works');
ALTER TABLE books 
ALTER COLUMN book_title VARCHAR(30);


INSERT INTO books VALUES
(1, 'Database Fundamentals', 'AuthorA', 'Edu', 2020, 'Available', 3),
(2, 'SQL for Beginners', 'AuthorB', 'Edu', 2021, 'Available', 3),
(3, 'C# Programming', 'AuthorC', 'Programming', 2019, 'Borrowed', 2),
(4, 'Future World', 'AuthorD', 'Science', 2018, 'Available', 1),
(5, 'History Book', 'AuthorE', 'History', 2015, 'Available', 4);

INSERT INTO members VALUES
(1, 'Ahmad', '1111111111', 'Student', '2025-01-01'),
(2, '’Mohammad', '2222222222', 'Teacher', '2024-06-05'),
(3, 'Ali', '3333333333', 'Visitor', '2024-01-03'),
(4, 'Omar', '4444444444', 'Student', '2024-01-07'),
(5, 'Khaled', '5555555555', 'Teacher', '2023-12-20');

INSERT INTO library_staff VALUES
(1, 'Staff1', '999111111', 'Books', '2020-01-01'),
(2, 'Staff2', '999222222', 'Members', '2021-02-01'),
(3, 'Staff3', '999333333', 'IT', '2022-03-01'),
(4, 'Staff4', '999444444', 'Archive', '2019-04-01'),
(5, 'Staff5', '999555555', 'Support', '2018-05-01');

INSERT INTO MemberBook VALUES
(1, 1, 2, '2024-01-02', '2024-01-07', '2024-01-06'), 
(2, 2, 2, '2024-01-03', '2024-01-08', '2024-01-07'), 
(3, 3, 2, '2024-01-04', '2024-01-09', '2024-01-08'), 
(4, 4, 2, '2024-01-05', '2024-01-10', '2024-01-09'), 

(5, 2, 3, '2024-01-03', '2024-01-08', '2024-01-10'), 
(6, 3, 3, '2024-01-06', '2024-01-11', NULL),         

(7, 4, 1, '2024-01-07', '2024-01-12', '2024-01-11'), 
(8, 5, 4, '2024-01-08', '2024-01-13', NULL);      

INSERT INTO reservations VALUES
(1, 1, 1, '2024-01-01', 'Pending'),
(2, 2, 2, '2024-01-02', 'Completed'),
(3, 3, 3, '2024-01-03', 'Cancelled'),
(4, 4, 4, '2024-01-04', 'Pending'),
(5, 5, 5, '2024-01-05', 'Completed');

INSERT INTO financial_fines VALUES
(1, 2, 10.00, 'Paid'),
(2, 4, 15.50, 'Unpaid'),
(3, 5, 5.00, 'Paid'),
(4, 1, 7.25, 'Unpaid'),
(5, 3, 12.00, 'Paid');

ALTER TABLE members
ADD email VARCHAR(20);

UPDATE members
SET member_name = 'Hasan'
WHERE member_id = 4;

INSERT INTO members VALUES
(6, 'Omar', '9876543210', 'Student', '2024-06-05', 'Omar@gmail.com');
--1. Retrieve all members who have made reservations.
SELECT DISTINCT members.member_name 
FROM members
JOIN reservations ON members.member_id = reservations.member_id;
--2. Retrieve members who borrowed the book titled "SQL for Beginners".
SELECT members.member_name 
FROM members
JOIN MemberBook ON members.member_id = MemberBook.member_id
JOIN books ON MemberBook.book_id = books.book_id
WHERE books.book_title = 'SQL for Beginners';
--3. Retrieve members who borrowed and returned the book titled "C# Programming".
SELECT members.member_name 
FROM members
JOIN MemberBook ON members.member_id = MemberBook.member_id
JOIN books ON MemberBook.book_id = books.book_id
WHERE books.book_title = 'C# Programming' AND MemberBook.return_date IS NOT NULL;
--4. Find members who returned books after their due date.
SELECT DISTINCT members.member_name 
FROM members
JOIN MemberBook ON members.member_id = MemberBook.member_id
WHERE MemberBook.return_date > MemberBook.due_date;
--5. Identify books that were borrowed more than 3 times.
SELECT books.book_title, COUNT(MemberBook.book_id) AS times_borrowed
FROM books
JOIN MemberBook ON books.book_id = MemberBook.book_id
GROUP BY books.book_id, books.book_title
HAVING COUNT(MemberBook.book_id) > 3;
--6. Find members who borrowed books between 01-01-2024 and 10-01-2024.
SELECT DISTINCT members.member_name 
FROM members
JOIN MemberBook ON members.member_id = MemberBook.member_id
WHERE MemberBook.borrowing_date BETWEEN '2024-01-01' AND '2024-01-10';
--7. Count the total number of books in the library.
SELECT COUNT(*) AS total_books_count 
FROM books;
--8.Find members who borrowed books but have not returned them yet.
SELECT DISTINCT members.member_name 
FROM members
JOIN MemberBook ON members.member_id = MemberBook.member_id
WHERE MemberBook.return_date IS NULL;
--9.Find members who borrowed books from the Science Fiction category.
SELECT DISTINCT members.member_name 
FROM members
JOIN MemberBook ON members.member_id = MemberBook.member_id
JOIN books ON MemberBook.book_id = books.book_id
JOIN categories ON books.category_id = categories.category_id
WHERE categories.category_name = 'Science ';
