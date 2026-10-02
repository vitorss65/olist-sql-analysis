-- Pergunta: Quais os 5 dias de mais venda em Novembro de 2017?
SELECT LEFT(o.order_purchase_timestamp, 10) AS dia, SUM(oi.price) AS receita
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp LIKE '2017-11%'
GROUP BY dia
ORDER BY receita DESC
LIMIT 5;
