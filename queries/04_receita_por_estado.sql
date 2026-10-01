-- Pergunta: qual a receita por estado do cliente, só de pedidos entregues?
SELECT c.customer_state, SUM(oi.price) AS receita
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY receita DESC;
