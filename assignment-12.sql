-- generate database
CREATE DATABASE IF NOT EXISTS `pizza_restaurant`;;

-- create customer table
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- views for each table
SELECT * FROM `customer`;
SELECT * FROM `order`;
SELECT * FROM `order_pizza`;
SELECT * FROM `pizza`;

-- populate tables with data
INSERT INTO `pizza_restaurant`.`order`
(`order_id`,
`customer_id`,
`date_time`)
VALUES
(<{order_id: }>,
<{customer_id: }>,
<{date_time: }>);

