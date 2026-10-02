-- Pergunta: quais as 3 categorias com mais receita em SP, RJ e MG (pedidos entregues)?
WITH receita_estado_categoria AS (
  SELECT c.customer_state AS estado,
         p.product_category_name AS categoria,
         SUM(oi.price) AS receita
  FROM order_items oi
  INNER JOIN orders o ON oi.order_id = o.order_id
  INNER JOIN customers c ON o.customer_id = c.customer_id
  INNER JOIN products p ON oi.product_id = p.product_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_state, p.product_category_name
),
ranking AS (
  SELECT estado, categoria, receita,
         RANK() OVER (PARTITION BY estado ORDER BY receita DESC) AS posicao
  FROM receita_estado_categoria
)
SELECT estado, categoria, ROUND(receita, 2) AS receita, posicao
FROM ranking
WHERE posicao <= 3
  AND estado IN ('SP', 'RJ', 'MG')
ORDER BY estado, posicao;
