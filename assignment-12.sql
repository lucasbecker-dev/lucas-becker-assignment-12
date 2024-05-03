-- generate database
CREATE DATABASE IF NOT EXISTS `pizza_restaurant`;

-- create customer table
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
  `phone_number` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
);

-- create order table which has a one-to-many relationship with the customer table
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id_idx` (`customer_id`),
  CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
);

-- create pizza table
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`pizza` (
  `pizza_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`pizza_id`)
);

-- create order_pizza JOIN table for many-to-many relationship between order and pizza tables
CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`order_pizza` (
  `order_id` int NOT NULL,
  `pizza_id` int NOT NULL,
  `count` int NOT NULL,
  PRIMARY KEY (`order_id`,`pizza_id`),
  KEY `pizza_id_idx` (`pizza_id`),
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  CONSTRAINT `pizza_id` FOREIGN KEY (`pizza_id`) REFERENCES `pizza` (`pizza_id`)
);

-- views for each table
SELECT * FROM `pizza_restaurant`.`customer`;
SELECT * FROM `pizza_restaurant`.`order`;
SELECT * FROM `pizza_restaurant`.`order_pizza`;
SELECT * FROM `pizza_restaurant`.`pizza`;

-- populate tables with data
INSERT INTO `pizza_restaurant`.`customer` (`first_name`, `last_name`, `phone_number`)
VALUES
('Trevor', 'Page', '226-555-4982'),
('John', 'Doe', '555-555-9498');

INSERT INTO `pizza_restaurant`.`order` (`customer_id`, `date_time`)
VALUES
(1, '2023-09-10 09:47:00'),
(2, '2023-09-10 13:20:00'),
(1, '2023-09-10 09:47:00'),
(2, '2023-10-10 10:37:00');

INSERT INTO `pizza_restaurant`.`pizza` (`name`, `price`)
VALUES
('Pepperoni & Cheese', 7.99),
('Vegetarian', 9.99),
('Meat Lovers', 14.99),
('Hawaiian', 12.99);

INSERT INTO `pizza_restaurant`.`order_pizza` (`order_id`, `pizza_id`, `count`) 
VALUES
(1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(2, 3, 2),
(3, 3, 1),
(3, 4, 1),
(4, 2, 3),
(4, 4, 1);


