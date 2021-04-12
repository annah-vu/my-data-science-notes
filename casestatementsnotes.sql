USE chipotle;
SELECT * FROM orders;

-- create buckets or bins for my items
SELECT item_name,
CASE 
WHEN item_name LIKE '%chicken%' THEN 'Chicken Items'
WHEN item_name LIKE '%beef%' THEN 'Beef Item'
WHEN item_name LIKE '%veggie%' THEN 'Veggie Item'
WHEN item_name LIKE '%beef%' THEN 'Beef Item'
WHEN item_name LIKE '%barbacoa%' OR '%carnitas%' OR '%steak%' THEN 'Specialty Item'
WHEN item_name LIKE '%chips%' THEN 'Side'
ELSE 'Other'
END AS item_type
FROM orders;

-- how many different items do I have for each item type category?
SELECT 
CASE 
WHEN item_name LIKE '%chicken%' THEN 'Chicken Items'
WHEN item_name LIKE '%beef%' THEN 'Beef Item'
WHEN item_name LIKE '%veggie%' THEN 'Veggie Item'
WHEN item_name LIKE '%beef%' THEN 'Beef Item'
WHEN item_name LIKE '%barbacoa%' OR 
item_name LIKE '%carnitas%' OR item_name LIKE '%steak%' THEN 'Specialty Item'
WHEN item_name LIKE '%chips%' THEN 'Side'
ELSE 'Other'
END AS item_type,
count(*) AS count_of_records
FROM orders
GROUP BY item_type
ORDER BY count_of_records DESC;

-- filter my return set to specialty items and only see which item in this category is most popular
SELECT 
CASE 
WHEN item_name LIKE '%chicken%' THEN 'Chicken Items'
WHEN item_name LIKE '%beef%' THEN 'Beef Item'
WHEN item_name LIKE '%veggie%' THEN 'Veggie Item'
WHEN item_name LIKE '%beef%' THEN 'Beef Item'
WHEN item_name LIKE '%barbacoa%' 
	OR item_name LIKE '%carnitas%'
	 OR item_name LIKE '%steak%' THEN 'Specialty Item'
WHEN item_name LIKE '%chips%' THEN 'Side'
ELSE 'Other'
END AS item_type,
count(*) AS count_of_records
FROM orders
GROUP BY item_type, item_name
HAVING item_type = 'Specialty Item'
ORDER BY count_of_records DESC;

-- create buckets for quantity to create a new categorical variable
-- what values do I have in quantity
SELECT DISTINCT quantity 
FROM orders;

SELECT item_name,
CASE WHEN quantity = 1 THEN 'single item'
WHEN quantity BETWEEN 2 AND 5 THEN 'family and friends'
WHEN quantity BETWEEN 6 AND 9 THEN 'small gathering'
WHEN quantity >9 THEN 'party'
ELSE 'other'
END AS quant_cats
FROM orders;

SELECT 
CASE WHEN quantity = 1 THEN 'single item'
WHEN quantity BETWEEN 2 AND 5 THEN 'family and friends'
WHEN quantity BETWEEN 6 AND 9 THEN 'small gathering'
WHEN quantity >9 THEN 'party'
ELSE 'other'
END AS quant_cats,
count(*) AS count_of_records
FROM orders
GROUP BY quant_cats
ORDER BY count_of_records DESC;