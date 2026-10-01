-- Pergunta: quais colunas a tabela orders possui? 
SELECT * FROM orders LIMIT 10;

-- Pergunta: quantos pedidos existem em cada status?
SELECT order_status, COUNT(*) AS total
FROM orders
GROUP BY order_status
ORDER BY total desc;
