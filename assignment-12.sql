-- generate database
CREATE DATABASE IF NOT EXISTS `pizza_restaurant`;

-- set default database
USE `pizza_restaurant`;

-- create customer table
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `phone_number` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
);

-- create order table which has a one-to-many relationship with the customer table
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id_idx` (`customer_id`),
  CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
);

-- create pizza table
CREATE TABLE IF NOT EXISTS `pizza` (
  `pizza_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`pizza_id`)
);

-- create order_pizza JOIN table for many-to-many relationship between order and pizza tables
CREATE TABLE IF NOT EXISTS `order_pizza` (
  `order_id` int NOT NULL,
  `pizza_id` int NOT NULL,
  `count` int NOT NULL,
  PRIMARY KEY (`order_id`,`pizza_id`),
  KEY `pizza_id_idx` (`pizza_id`),
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  CONSTRAINT `pizza_id` FOREIGN KEY (`pizza_id`) REFERENCES `pizza` (`pizza_id`)
);

-- views for each table
-- SELECT * FROM `customer`;
-- SELECT * FROM `order`;
-- SELECT * FROM `order_pizza`;
-- SELECT * FROM `pizza`;

-- populate tables with data
INSERT INTO `customer` (`name`, `phone_number`)
VALUES
('Trevor Page', '226-555-4982'),
('John Doe', '555-555-9498');

INSERT INTO `order` (`customer_id`, `date_time`)
VALUES
(1, '2023-09-10 09:47:00'),
(2, '2023-09-10 13:20:00'),
(1, '2023-09-10 09:47:00'),
(2, '2023-10-10 10:37:00');

INSERT INTO `pizza` (`name`, `price`)
VALUES
('Pepperoni & Cheese', 7.99),
('Vegetarian', 9.99),
('Meat Lovers', 14.99),
('Hawaiian', 12.99);

INSERT INTO `order_pizza` (`order_id`, `pizza_id`, `count`) 
VALUES
(1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(2, 3, 2),
(3, 3, 1),
(3, 4, 1),
(4, 2, 3),
(4, 4, 1);
-- end populating tables with data

-- Q4: Now the restaurant would like to know which customers are spending the 
-- most money at their establishment. Write a SQL query which will tell them how 
-- much money each individual customer has spent at their restaurant
SELECT c.`name` AS 'Customer', 
	SUM(p.price * op.count) AS 'Total'
FROM `customer` c
JOIN `order` o ON c.`customer_id` = o.`customer_id`
JOIN `order_pizza` op ON op.`order_id` = o.`order_id`
JOIN `pizza` p ON p.`pizza_id` = op.`pizza_id`
GROUP BY c.`customer_id`;

-- Q5: Modify the query from Q4 to separate the orders not just by customer, but
-- also by date so they can see how much each customer is ordering on which date.
SELECT c.`name` AS 'Customer', 
	DATE(o.`date_time`) as 'Date',
	SUM(p.price * op.count) AS 'Total'
FROM `customer` c
JOIN `order` o ON c.`customer_id` = o.`customer_id`
JOIN `order_pizza` op ON op.`order_id` = o.`order_id`
JOIN `pizza` p ON p.`pizza_id` = op.`pizza_id`
GROUP BY c.`customer_id`, o.`date_time`;

