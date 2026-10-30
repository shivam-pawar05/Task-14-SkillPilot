USE company_demo;

-- Supports filtering employees by department and hiring date.
CREATE INDEX idx_employees_department_hired
  ON employees(department_id, hired_at);

-- Supports common order status/date reports.
CREATE INDEX idx_orders_status_date
  ON orders(status, order_date);

-- Supports customer order lookup.
CREATE INDEX idx_orders_customer
  ON orders(customer_name);

-- Inspect indexes:
SHOW INDEX FROM employees;
SHOW INDEX FROM orders;

-- Compare query plans before/after:
EXPLAIN SELECT employee_id, employee_name
FROM employees
WHERE department_id = 1 AND hired_at >= '2024-01-01';

EXPLAIN SELECT order_id, amount
FROM orders
WHERE status = 'completed'
ORDER BY order_date DESC;
