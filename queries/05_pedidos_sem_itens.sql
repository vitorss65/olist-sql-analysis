-- Pergunta: quais pedidos não têm itens, e em que status eles estão?
SELECT o.order_status, COUNT(*) AS total
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
GROUP BY o.order_status
ORDER BY total DESC;
