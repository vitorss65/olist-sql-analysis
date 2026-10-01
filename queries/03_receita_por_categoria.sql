-- Pergunta: qual é a receita total de cada categoria, da maior para a menor?
SELECT p.product_category_name, SUM(oi.price) AS receita
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY receita DESC
LIMIT 10;
