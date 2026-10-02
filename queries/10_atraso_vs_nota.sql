SELECT
  CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
       THEN 'atrasado' ELSE 'no prazo' END AS situacao,
  COUNT(*) AS pedidos,
  ROUND(AVG(r.review_score), 2) AS nota_media
FROM orders o
INNER JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_delivered_customer_date <> ''
GROUP BY situacao
ORDER BY situacao;
