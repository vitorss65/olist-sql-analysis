-- Pergunta: como a receita de pedidos entregues evoluiu mês a mês?
SELECT LEFT(o.order_purchase_timestamp, 7) AS mes, SUM(oi.price) AS receita
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY mes
ORDER BY mes;
