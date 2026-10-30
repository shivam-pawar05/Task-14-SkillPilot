CREATE DATABASE IF NOT EXISTS company_demo
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

USE company_demo;

CREATE TABLE IF NOT EXISTS departments (
  department_id INT AUTO_INCREMENT PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  employee_name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL UNIQUE,
  department_id INT,
  salary DECIMAL(10,2),
  hired_at DATE NOT NULL,
  CONSTRAINT fk_employees_department
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE IF NOT EXISTS orders (
  order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  customer_name VARCHAR(120) NOT NULL,
  order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  amount DECIMAL(12,2) NOT NULL,
  status ENUM('pending','completed','cancelled') NOT NULL DEFAULT 'pending'
);

CREATE TABLE IF NOT EXISTS backup_log (
  backup_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  backup_file VARCHAR(500) NOT NULL,
  backup_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status ENUM('SUCCESS','FAILED') NOT NULL,
  file_size_bytes BIGINT NULL,
  message VARCHAR(1000) NULL
);
