-- Pergunta: Qual é a categoria e o preço de 10 itens vendidos?
SELECT oi.order_id, p.product_category_name, oi.price
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
LIMIT 10;
