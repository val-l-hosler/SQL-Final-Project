CREATE DATABASE IF NOT EXISTS `salon`;
USE `salon` ;

CREATE TABLE IF NOT EXISTS `customer` (
    `customer_id` INT NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(45) NOT NULL,
    `last_name` VARCHAR(45) NOT NULL,
    `phone_number` VARCHAR(12) NOT NULL,
    PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `employee` (
    `employee_id` INT NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(45) NOT NULL,
    `last_name` VARCHAR(45) NOT NULL,
    `birth_date` DATE NOT NULL,
    `phone_number` VARCHAR(12) NOT NULL,
    `hired_date` DATE NOT NULL,
    `job_title` VARCHAR(45) NOT NULL,
    `commission_percent` DECIMAL(10 , 2 ) NOT NULL,
    `hourly_rate` DECIMAL(10 , 2 ) NOT NULL,
    PRIMARY KEY (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `appointment` (
  `appointment_id` INT NOT NULL AUTO_INCREMENT,
  `appointment_date` DATETIME NOT NULL,
  `fk_customer_id` INT NOT NULL,
  `fk_employee_id` INT NOT NULL,
  PRIMARY KEY (`appointment_id`),
  INDEX `ux_1_idx` (`fk_customer_id` ASC),
  INDEX `ux_2_idx` (`fk_employee_id` ASC),
  CONSTRAINT `ux_1`
    FOREIGN KEY (`fk_customer_id`)
    REFERENCES `customer` (`customer_id`),
  CONSTRAINT `ux_2`
    FOREIGN KEY (`fk_employee_id`)
    REFERENCES `employee` (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `service` (
    `service_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `price` DECIMAL(10 , 2 ) NOT NULL,
    `time` INT NOT NULL,
    `text_description` VARCHAR(500) NOT NULL,
    PRIMARY KEY (`service_id`)
);

CREATE TABLE IF NOT EXISTS `appointment_service` (
  `appointment_service_id` INT NOT NULL AUTO_INCREMENT,
  `appointment_service_satisfaction` VARCHAR(8) NULL DEFAULT NULL,
  `appointment_service_notes` VARCHAR(500) NULL DEFAULT NULL,
  `fk_appointment_id` INT NOT NULL,
  `fk_service_id` INT NOT NULL,
  PRIMARY KEY (`appointment_service_id`),
  INDEX `ux_3_idx` (`fk_appointment_id` ASC),
  INDEX `ux_4_idx` (`fk_service_id` ASC),
  CONSTRAINT `ux_3`
    FOREIGN KEY (`fk_appointment_id`)
    REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `ux_4`
    FOREIGN KEY (`fk_service_id`)
    REFERENCES `service` (`service_id`)
);

CREATE TABLE IF NOT EXISTS `sale_product` (
    `sale_product_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `weight` DECIMAL(10 , 2 ) NULL,
    `manufacturer` VARCHAR(45) NOT NULL,
    `vendor` VARCHAR(45) NOT NULL,
    `category` VARCHAR(45) NOT NULL,
    `buy_price` DECIMAL(10 , 2 ) NOT NULL,
    `sell_price` DECIMAL(10 , 2 ) NOT NULL,
    `text_description` VARCHAR(500) NULL DEFAULT NULL,
    PRIMARY KEY (`sale_product_id`)
);

CREATE TABLE IF NOT EXISTS `purchase` (
  `purchase_id` INT NOT NULL AUTO_INCREMENT,
  `purchase_date` DATETIME NOT NULL,
  `fk_customer_id` INT NOT NULL,
  PRIMARY KEY (`purchase_id`),
  INDEX `ux_5_idx` (`fk_customer_id` ASC),
  CONSTRAINT `ux_5`
    FOREIGN KEY (`fk_customer_id`)
    REFERENCES `customer` (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `sale_product_purchase` (
  `sale_product_purchase_id` INT NOT NULL AUTO_INCREMENT,
  `quantity_purchased` INT NOT NULL,
  `fk_sale_product_id` INT NOT NULL,
  `fk_purchase_id` INT NOT NULL,
  PRIMARY KEY (`sale_product_purchase_id`),
  INDEX `ux_6_idx` (`fk_sale_product_id` ASC),
  INDEX `ux_7_idx` (`fk_purchase_id` ASC),
  CONSTRAINT `ux_6`
    FOREIGN KEY (`fk_sale_product_id`)
    REFERENCES `sale_product` (`sale_product_id`),
  CONSTRAINT `ux_7`
    FOREIGN KEY (`fk_purchase_id`)
    REFERENCES `purchase` (`purchase_id`)
);

CREATE TABLE IF NOT EXISTS `product` (
    `product_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `weight` DECIMAL(10 , 2 ) NULL,
    `manufacturer` VARCHAR(45) NOT NULL,
    `vendor` VARCHAR(45) NOT NULL,
    `category` VARCHAR(45) NOT NULL,
    `buy_price` DECIMAL(10 , 2 ) NOT NULL,
    `text_description` VARCHAR(500) NULL DEFAULT NULL,
    PRIMARY KEY (`product_id`)
);

CREATE TABLE IF NOT EXISTS `product_service` (
  `product_service_id` INT NOT NULL AUTO_INCREMENT,
  `product_service_notes` VARCHAR(500) NULL,
  `fk_product_id` INT NOT NULL,
  `fk_service_id` INT NOT NULL,
  PRIMARY KEY (`product_service_id`),
  INDEX `ux_8_idx` (`fk_product_id` ASC),
  INDEX `ux_9_idx` (`fk_service_id` ASC),
  CONSTRAINT `ux_8`
    FOREIGN KEY (`fk_product_id`)
    REFERENCES `product` (`product_id`),
  CONSTRAINT `ux_9`
    FOREIGN KEY (`fk_service_id`)
    REFERENCES `service` (`service_id`)
);

# # # # # # # # # # # INSERT STATEMENTS # # # # # # # # # # #

# CUSTOMER TABLE
INSERT INTO customer
(first_name, last_name, phone_number)
VALUES
('Valerie', 'Hosler', '724-123-4567'),
('Mary', 'Jones', '412-987-6543'),
('Jennifer', 'Butteri', '724-111-2222'),
('Lily', 'Sullivan', '724-222-3333'),
('Jackie', 'Massimi', '724-333-4444'),
('Robert', 'Massimi', '724-333-4444'),
('Jane', 'Massimi', '724-333-4444'),
('Michael', 'Richardson', '724-444-5555'),
('Jack', 'Howe', '724-555-6666'),
('Hillary', 'Clinton', '724-666-7777')
;

# EMPLOYEE TABLE
INSERT INTO employee
(first_name, last_name, birth_date, phone_number, hired_date, job_title, commission_percent, hourly_rate)
VALUES
('Barbara', 'Jones', '1970-10-31', '724-123-0000', '2018-01-01', 'Stylist', 0.50, 0.00),
('Regina', 'Holland', '1983-02-11', '724-999-9999', '2018-01-01', 'Stylist', 0.50, 0.00),
('Janet', 'Miller', '1982-10-13', '724-222-3333', '2018-01-01', 'Stylist', 0.50, 0.00),
('Michael', 'Goodman', '1970-11-02', '412-666-4444', '2018-01-01', 'Men\'s Stylist', 0.50, 0.00),
('Merideth', 'Donovan', '1990-05-01', '724-000-1234', '2018-01-01', 'Stylist', 0.50, 0.00),
('Greg', 'KilPatrick', '1990-07-08', '412-600-0000', '2019-08-20', 'Men\'s Stylist', 0.50, 0.00),
('Brittany', 'Jeffers', '1991-03-01', '412-999-1234', '2021-01-01', 'Stylist', 0.50, 0.00),
('Victoria', 'Stubbs', '1980-06-09', '724-999-8888', '2021-02-01', 'Stylist', 0.50, 0.00),
('Molly', 'Howard', '1995-08-21', '412-776-1234', '2021-02-01', 'Receptionist', 0.00, 12.00),
('Kelly', 'Williams', '1996-11-21', '412-886-1114', '2021-03-01', 'Receptionist', 0.00, 12.00)
;

# SALE_PRODUCT TABLE
INSERT INTO sale_product
(name, weight, manufacturer, vendor, category, buy_price, sell_price, text_description)
VALUES
('Hydrate Shampoo', 9, 'Purology', 'Beauty Warehouse', 'Shampoo', 28.00, 30.00, 'Hydrate Shampoo will gently protect your hair while keeping your color vibrant, luxurious and moisturized.'),
('Hydrate Conditioner', 9, 'Purology', 'Beauty Warehouse', 'Conditioner', 28.00, 30.00, 'Hydrate Condition is a daily hydrating conditioner that will protect and maximize your color retention.'),
('Hydrate Shampoo', 33.8, 'Purology', 'Beauty Warehouse', 'Shampoo', 70.00, 75.00, 'Hydrate Shampoo will gently protect your hair while keeping your color vibrant, luxurious and moisturized.'),
('Hydrate Conditioner', 33.8, 'Purology', 'Beauty Warehouse', 'Conditioner', 70.00, 75.00, 'Hydrate Condition is a daily hydrating conditioner that will protect and maximize your color retention.'),
('Hydrate Superfood Deep Treatment Mask', 33.8, 'Purology', 'Beauty Warehouse', 'Treatment Mask', 30.00, 75.00, 'Deep nourishes dry hair, infused with Coconut oil and Avocado oil that hydrates, moisturizes, and strengthens for healthier hair.'),
('Strength Cure Shampoo', 9, 'Purology', 'Beauty Warehouse', 'Shampoo', 28.00, 30.00, 'Strength Cure Shampoo is a concentrated fortifying sulfate free shampoo for damaged hair including chemical or colour damage.'),
('Strength Cure Conditioner', 9, 'Purology', 'Beauty Warehouse', 'Conditioner', 28.00, 30.00, 'Strength Cure Condition formula is made with their exclusive AntifadeComplex which detangles, strengthens and conditions to improve hair\'s touch and light reflection.'),
('Strength Cure Shampoo', 33.8, 'Purology', 'Beauty Warehouse', 'Shampoo', 70.00, 75.00, 'Strength Cure Shampoo is a concentrated fortifying sulfate free shampoo for damaged hair including chemical or colour damage.'),
('Strength Cure Conditioner', 33.8, 'Purology', 'Beauty Warehouse', 'Conditioner', 70.00, 75.00, 'Strength Cure Condition formula is made with their exclusive AntifadeComplex which detangles, strengthens and conditions to improve hair\'s touch and light reflection.'),
('Royal Treatment Rapid Shine', 5.3, 'Chi', 'Marlo Beauty Supply', 'Finishing Spray', 17.00, 20.00, 'Aerosol spray, CHI Farouk Royal Treatment Rapid Shine, formulated with White Truffle and Pearl, provides a weightless, intense shine to your finished style.')
;

# PURCHASE TABLE
INSERT INTO purchase
(purchase_date, fk_customer_id)
VALUES
('2021-03-02 12:00:15', 1),
('2021-03-02 12:00:00', 2), 
('2021-03-03 01:05:00', 3),
('2021-03-10 11:22:11', 4),
('2021-03-20 05:11:02', 5),
('2021-03-29 10:02:08', 10),
('2021-03-29 12:00:03', 7),
('2021-04-02 03:00:54', 5),
('2021-04-02 5:10:05', 2),
('2021-04-10 12:00:10', 1)
;

# SALE_PRODUCT_PURCHASE TABLE
INSERT INTO sale_product_purchase
(quantity_purchased, fk_sale_product_id, fk_purchase_id)
VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 2),
(1, 4, 2),
(1, 1, 3),
(1, 6, 4),
(1, 7, 4),
(2, 10, 5),
(1, 1, 6),
(1, 2, 6),
(1, 6, 7),
(1, 7, 7),
(1, 10, 8),
(1, 3, 9),
(1, 4, 9),
(1, 8, 10),
(1, 9, 10)
;

# APPOINTMENT TABLE
INSERT INTO appointment
(appointment_date, fk_customer_id, fk_employee_id)
VALUES
('2021-04-02 1:00:00', 5, 3),
('2021-04-02 2:00:00', 6, 3),
('2021-04-02 2:30:00', 7, 3),
('2021-04-10 10:00:00', 1, 2),
('2021-06-10 10:00:00', 1, 2),
('2021-08-10 10:00:00', 1, 2),
('2021-05-02 12:00:00', 2, 2),
('2021-05-14 1:30:00', 8, 4),
('2021-05-15 4:30:00', 10, 8),
('2021-05-16 10:30:00', 4, 5)
;

# SERVICE TABLE
INSERT INTO service 
(name, price, time, text_description)
VALUES
('Partial highlight', 80.00, 60, 'A partial-head highlight with foils.'),
('Full highlight', 120.00, 90, 'A full-head highlight with foils.'),
('Women\'s dry haircut', 40.00, 30, 'A women\'s haircut without a hair-wash.'),
('Women\'s haircut', 60.00, 60, 'A women\'s haircut with a hair-wash and blow dry.'),
('Men\'s dry haircut', 30.00, 30, 'A men\'s haircut without a hair-wash and blow dry.'),
('Men\'s haircut', 45.00, 45, 'A men\'s haircut with a hair-wash and blow dry.'),
('Men\'s shave', 15.00, 15, 'A men\'s shave with a straight razor.'),
('Men\'s beard trim', 15.00, 15, 'A men\'s beard trim.'),
('Child\'s dry haircut', 15.00, 15, 'A child\'s (1-12 year old) haircut without a hair-wash and blow dry.'),
('Child\'s haircut', 30.00, 30, 'A child\'s (1-12 year old) haircut with a hair-wash and blow dry.'),
('Curly dry haircut', 50.00, 45, 'A curly haircut without a hair-wash and blow dry.'),
('Balayage highlight', 150.00, 105, 'A full-head balayage highlight.'),
('Single-process hair dye', 60.00, 45, 'A single-process permanent hair dye.'),
('Corrective color', 175.00, 120, 'A corrective color appointment involving a double-process hair dye.'),
('Color consult', 0.00, 10, 'A color consult.')
;

# APPOINTMENT_SERVICE TABLE
INSERT INTO appointment_service
(appointment_service_satisfaction, appointment_service_notes, fk_appointment_id, fk_service_id)
VALUES
('Positive', 'Donated 10 inches to Locks of Love.', 1, 4),
('Negative', 'The customer has sensory issues and had difficulties getting his hair cut. Next time, use the chair away from other customers.', 2, 10),
('Neutral', '1 inch was cut off.', 3, 10),
('Positive', '20 volume bleach was used. The customer was obviously happy with the finished product.', 4, 1),
('Negative', '2 inches were cut off. The customer was unhappy with this amount cut off because it was too short.', 4, 4),
('Neutral', null, 5, 1),
('Neutral', null, 5, 4),
('Neutral', null, 6, 1),
('Neutral', null, 6, 4),
('Positive', null, 7, 12),
('Positive', 'The customer was extremely happy when they left and tipped 20%.', 7, 4),
('Neutral', null, 8, 5),
('Neutral', null, 8, 7),
('Neutral', null, 9, 2),
('Neutral', null, 9, 4),
('Neutral', null, 10, 3)
;

# PRODUCT TABLE
INSERT INTO product
(name, weight, manufacturer, vendor, category, buy_price, text_description)
VALUES
('Hydrate Shampoo', 9, 'Purology', 'Beauty Warehouse', 'Shampoo', 28.00, 'Hydrating shampoo for normal or color-treated hair.'),
('Hydrate Conditioner', 9, 'Purology', 'Beauty Warehouse', 'Conditioner', 28.00, 'Hydrating conditioner for normal or color-treated hair'),
('Hydrate Superfood Deep Treatment Mask', 33.80, 'Purology', 'Beauty Warehouse', 'Treatment Mask', 30.00, 'Deep treatment mask for damaged, color-treated hair.'),
('Royal Treatment Rapid Shine', 5.3, 'Chi', 'Beauty Warehouse', 'Finishing Spray', 17.00, 'Finishing spray for normal or color-treated hair.'),
('Deluxe Crinkle Nylon Cutting Cape', null, 'Pro2Pro', 'Marlo Beauty Supply', 'Apparel', 25.00, ''),
('Transform Silver Shear', null, 'Fromm Shear Artistry', 'Marlo Beauty Supply', 'Styling Tool', 40.00, 'Right-handed shears.'),
('Binge Copper Tension Thermal Brush', null, 'Cricket', 'Marlo Beauty Supply', 'Styling Tool', 35.00, '2" in diameter.'),
('White Gold Digital Salon Dryer', null, 'Hot Tools Professional', 'Marlo Beauty Supply', 'Styling Tool', 150.00, ''),
('Color Charm Powder Lightener', 16, 'Wella', 'Marlo Beauty Supply', 'Bleaches & Lighteners', 25.00, '10 volume'),
('Color Charm Powder Lightener', 16, 'Wella', 'Marlo Beauty Supply', 'Bleaches & Lighteners', 25.00, '20 volume'),
('Color Charm Powder Lightener', 16, 'Wella', 'Marlo Beauty Supply', 'Bleaches & Lighteners', 25.00, '30 volume'),
('Color Charm Powder Lightener', 16, 'Wella', 'Marlo Beauty Supply', 'Bleaches & Lighteners', 25.00, '40 volume'),
('Color Charm Permanent Liquid Haircolor', 1.4, 'Wella', 'Marlo Beauty Supply', 'Permnanet Hair Dye', 15.00, '1N/51 Black'),
('Color Charm Permanent Liquid Haircolor', 1.4, 'Wella', 'Marlo Beauty Supply', 'Permnanet Hair Dye', 15.00, '2N/211 Very Dark Brown'),
('Color Charm Permanent Liquid Haircolor', 1.4, 'Wella', 'Marlo Beauty Supply', 'Permnanet Hair Dye', 15.00, '3A/148 Dark Ash Brown'),
('Color Charm Permanent Liquid Haircolor', 1.4, 'Wella', 'Marlo Beauty Supply', 'Permnanet Hair Dye', 15.00, '3N/311 Dark Brown'),
('Color Charm Permanent Liquid Haircolor', 1.4, 'Wella', 'Marlo Beauty Supply', 'Permnanet Hair Dye', 15.00, '3RV/367 Black Cherry'),
('Color Charm Permanent Liquid Haircolor', 1.4, 'Wella', 'Marlo Beauty Supply', 'Permnanet Hair Dye', 15.00, '4A/237 Medium Ash Brown'),
('Color Charm Permanent Liquid Haircolor', 1.4, 'Wella', 'Marlo Beauty Supply', 'Permnanet Hair Dye', 15.00, '4G/257 Dark Golden Brown'),
('Color Charm Permanent Liquid Haircolor', 1.4, 'Wella', 'Marlo Beauty Supply', 'Permnanet Hair Dye', 15.00, '4N/411 Medium Brown')
;

# PRODUCT_SERVICE TABLE
INSERT INTO product_service
(product_service_notes, fk_product_id, fk_service_id)
VALUES
('Use after haircut.', 4, 3),
('', 5, 3),
('', 6, 3),
('Use before haircut.', 1, 4),
('Use after shampooing hair.', 2, 4),
('Use after haircut.', 4, 4),
('', 5, 4),
('', 6, 4),
('', 7, 4),
('Use the cool setting if a customer\'s hair is damaged.', 8, 4)
;

# # # # # # # # # # # # SQL QUESTIONS/STATEMENTS # # # # # # # # # # # #

# Question 1: How could a stakeholder look up a customer’s future appointments?

SELECT 
    CONCAT(c.last_name, ', ', c.first_name) AS 'Customer Name',
    a.appointment_date
FROM
    customer AS c
        INNER JOIN
    appointment AS a ON c.customer_id = a.fk_customer_id
WHERE
    CONCAT(c.last_name, ', ', c.first_name) = 'Hosler, Valerie';
    
# # # # # #

# Question 2: How could a stakeholder identify the price of a specific service?
    
SELECT 
    price
FROM
    service AS s
WHERE
    s.name = 'Partial highlight';

# # # # # #

# Question 3: How could a stakeholder look up a customer’s phone number?

SELECT 
    phone_number
FROM
    customer AS c
WHERE
    CONCAT(c.last_name, ', ', c.first_name) = 'Hosler, Valerie';
    
# # # # # #

# Question 4: How could a stakeholder easily sort a sale_product by its category?

SELECT 
    sp.name AS 'Name',
    sp.manufacturer AS 'Manufacturer',
    sp.category AS 'Category',
    sp.weight AS 'Weight in Ounces',
    sp.sell_price AS 'Sale Price',
    sp.text_description AS 'Product Description'
FROM
    sale_product AS sp
ORDER BY sp.category;

# # # # # #

# Question 5: How could a stakeholder find notes about how a specific customer reacted to services they’ve previously received?

SELECT 
    CONCAT(c.last_name, ', ', c.first_name) as 'Customer Name',
    a.appointment_date AS 'Appointment Date',
    s.name AS 'Service',
    a_s.appointment_service_notes AS 'Service Notes'
FROM
    customer AS c
        INNER JOIN
    appointment AS a ON c.customer_id = a.fk_customer_id
        INNER JOIN
    appointment_service AS a_s ON a.appointment_id = a_s.fk_appointment_id
        INNER JOIN
    service AS s ON s.service_id = a_s.fk_service_id
WHERE
    CONCAT(c.last_name, ', ', c.first_name) = 'Massimi, Robert';

# # # # # #

# Question 6: How could a stakeholder easily see patterns in customer’s reactions to appointment services?
    
SELECT 
    CONCAT(e.last_name, ', ', e.first_name) as 'Employee who Performed Service',
    a.appointment_date AS 'Appointment Date',
    s.name AS 'Service',
    a_s.appointment_service_satisfaction AS 'Satisfaction Rating',
    a_s.appointment_service_notes AS 'Service Notes'
FROM
    appointment AS a 
        INNER JOIN
    appointment_service AS a_s ON a.appointment_id = a_s.fk_appointment_id
		INNER JOIN
	employee AS e ON e.employee_id = a.fk_employee_id
        INNER JOIN
    service AS s ON s.service_id = a_s.fk_service_id
WHERE
    a_s.appointment_service_satisfaction = 'Negative';

# # # # # #

# Question 7: How could a stakeholder make a monthly report with the scheduled employees’ commissions/salaries?

SELECT 
    CONCAT(e.last_name, ', ', e.first_name) AS 'Employee Name',
    CAST(SUM(s.price * (e.commission_percent)) AS DECIMAL (10 , 2 )) AS 'Monthly Pay'
FROM
    employee AS e
        INNER JOIN
    appointment AS a ON e.employee_id = a.fk_employee_id
        INNER JOIN
    appointment_service AS a_s ON a.appointment_id = a_s.fk_appointment_id
        INNER JOIN
    service AS s ON s.service_id = a_s.fk_service_id
WHERE
    a.appointment_date BETWEEN '2021-04-01 00:00:00' AND '2021-05-01 00:00:00'
GROUP BY CONCAT(e.last_name, ', ', e.first_name);

# # # # # #

# Question 8: How could a stakeholder make a monthly report showing how many total appointments an employee has scheduled?

SELECT 
    CONCAT(e.last_name, ', ', e.first_name) AS 'Employee Name',
    (SELECT 
            COUNT(a.appointment_id)
        FROM
            appointment AS a
        WHERE
            a.fk_employee_id = e.employee_id
                AND a.appointment_date BETWEEN '2021-04-01 00:00:00' AND '2021-05-01 00:00:00') AS 'Number of Appointments in April 2021'
FROM
    employee AS e;
    
# # # # # #

# Question 9: How could a stakeholder determine how much a particular customer needs to pay for all of an appointment’s services?

SELECT 
    SUM(s.price) AS 'Appointment Service Payment Amount'
FROM
    service AS s
        INNER JOIN
    appointment_service AS a_s ON s.service_id = a_s.fk_service_id
        INNER JOIN
    appointment AS a ON a.appointment_id = a_s.fk_appointment_id
WHERE
    a.fk_customer_id IN (SELECT 
            c.customer_id
        FROM
            customer AS c
        WHERE
            CONCAT(c.last_name, ', ', c.first_name) = 'Hosler, Valerie')
        AND a.appointment_date = '2021-04-10 10:00:00';
        
# # # # # #

# Question 10: How could a stakeholder count how many times a sales product has been sold over a specific amount of time?

# Part 1

SELECT 
    sp.name AS 'Sale Product Name',
    COUNT(sp.sale_product_id) AS 'Number of Products Sold'
FROM
    sale_product AS sp
        INNER JOIN
    sale_product_purchase AS spp ON sp.sale_product_id = spp.fk_sale_product_id
        INNER JOIN
    purchase AS p ON p.purchase_id = spp.fk_purchase_id
GROUP BY sp.sale_product_id
HAVING COUNT(sp.sale_product_id) > 0;

# # # 

# Part 2

SELECT 
    sp.name AS 'Product That Has Never Sold'
FROM
    sale_product AS sp
        LEFT JOIN
    sale_product_purchase AS spp ON spp.fk_sale_product_id = sp.sale_product_id
WHERE
    spp.fk_sale_product_id IS NULL;
    
# # # # # #

# Question 11: How could a stakeholder find the vendor for a particular product?

SELECT 
    p.name AS 'Product Name', p.vendor AS 'Vendor Name'
FROM
    product AS p
WHERE
    p.name = 'Color Charm Permanent Liquid Haircolor'
LIMIT 1;