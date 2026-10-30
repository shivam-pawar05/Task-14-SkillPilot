USE company_demo;

INSERT IGNORE INTO departments(department_name) VALUES
('IT'), ('Finance'), ('Sales'), ('HR');

INSERT INTO employees(employee_name,email,department_id,salary,hired_at) VALUES
('Aarav Sharma','aarav@example.test',1,62000,'2023-05-10'),
('Priya Patel','priya@example.test',2,58000,'2022-11-18'),
('Rahul Deshmukh','rahul@example.test',3,51000,'2024-02-01'),
('Neha Kulkarni','neha@example.test',4,47000,'2023-09-12');

INSERT INTO orders(customer_name,order_date,amount,status) VALUES
('Customer A','2026-10-01 10:15:00',1250.00,'completed'),
('Customer B','2026-10-02 12:20:00',3400.50,'pending'),
('Customer C','2026-10-03 16:45:00',890.00,'completed'),
('Customer A','2026-10-04 09:30:00',2100.00,'cancelled');
