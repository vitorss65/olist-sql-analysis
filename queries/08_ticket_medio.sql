-- Pergunta: qual o ticket médio dos pedidos entregues?
WITH receita_pedido AS (
  SELECT o.order_id, SUM(oi.price) AS receita
  FROM orders o
  INNER JOIN order_items oi ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY o.order_id
)
SELECT COUNT(*) AS pedidos,
       ROUND(AVG(receita), 2) AS ticket_medio,
       ROUND(MAX(receita), 2) AS maior_pedido
FROM receita_pedido;
