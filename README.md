# Análise de e-commerce (Olist) com SQL

Projeto de análise de dados feito em **SQL (MySQL)** sobre o dataset público de e-commerce da Olist. O objetivo é responder perguntas de negócio (receita, categorias, estados, prazos de entrega) usando JOINs, agregações, CTEs e window functions.

> Status: em andamento. As queries estão completas; os gráficos (Power BI) ainda serão adicionados.

## Dados

- **Fonte:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle).
- Os arquivos CSV **não estão neste repositório**. Para reproduzir, baixe o dataset no link acima.
- Tabelas usadas: `orders`, `order_items`, `products`, `customers` e `order_reviews`.

## Ferramentas

- MySQL 8 e MySQL Workbench
- SQL: `INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `CASE WHEN`, CTE (`WITH`) e window function (`RANK() OVER`)

## Perguntas e conclusões

### Exploração dos dados

**1. Quais colunas a tabela `orders` possui?**
Comecei olhando as 10 primeiras linhas para entender o que cada pedido guarda: identificador, cliente, status e datas de compra e entrega. (`queries/01_exploracao_e_status.sql`)

**2. Quantos pedidos existem em cada status?**
A tabela tem 99.441 pedidos. A grande maioria está como `delivered`; os demais status (cancelados, indisponíveis etc.) têm poucos pedidos. (`queries/01_exploracao_e_status.sql`)

### Receita

**3. Qual a categoria e o preço de 10 itens vendidos?**
Primeiro `INNER JOIN` do projeto: liga `order_items` (preço) e `products` (categoria) pelo `product_id`. (`queries/02_receita_por_categoria.sql`)

**4. Qual a receita total de cada categoria?**
As três categorias com maior receita são Beleza e saúde (`beleza_saude`), com R$ 1,26 milhão, Relógios e presentes (`relogios_presentes`), com R$ 1,20 milhão, e Cama, mesa e banho (`cama_mesa_banho`), com R$ 1,04 milhão. Esta query soma todos os itens, inclusive de pedidos que não foram entregues; as demais análises de receita consideram só pedidos entregues. (`queries/02_receita_por_categoria.sql`)

**5. Qual a receita por estado do cliente (pedidos entregues)?**
A receita está concentrada no Sudeste: SP, RJ e MG são os três estados com maior receita, com SP bem à frente. Usa dois JOINs encadeados (`order_items`, `orders` e `customers`). (`queries/03_receita_por_estado.sql`)

**6. Quais pedidos não têm nenhum item, e em que status estão?**
Usei `LEFT JOIN` com filtro `IS NULL`. Os pedidos sem item estão concentrados nos status `unavailable` e `canceled`, o que faz sentido: são pedidos que não viraram venda. (`queries/04_pedidos_sem_itens.sql`)

**7. Como a receita evoluiu mês a mês?**
A receita cresce ao longo de 2017 e tem um pico em novembro de 2017, provavelmente por causa da Black Friday. Entre março e maio de 2018 os valores ficam em um patamar parecido. (`queries/05_receita_por_mes.sql`)

**8. Quais foram os 5 dias de maior venda em novembro de 2017?**
Query para checar a hipótese da Black Friday. O dia 24/11/2017, data da Black Friday, teve a maior receita do mês: cerca de R$ 150 mil, mais de duas vezes o segundo melhor dia (R$ 60 mil, no dia 25). Os dias seguintes também ficam entre os cinco maiores. (`queries/05_receita_por_mes.sql`)

**9. Qual o ticket médio dos pedidos entregues?**
Com uma CTE que calcula a receita de cada pedido: 96.478 pedidos entregues, ticket médio de **R$ 137,04** e maior pedido de **R$ 13.440**. O valor considera só o preço dos itens (sem frete). Como o maior pedido é quase 100 vezes a média, poucos pedidos de valor alto puxam a média para cima. (`queries/06_ticket_medio.sql`)

**10. Quais as 3 categorias com maior receita em SP, RJ e MG?**
Usei duas CTEs e `RANK() OVER (PARTITION BY estado ...)`. As mesmas três categorias aparecem nos três estados: `cama_mesa_banho`, `beleza_saude` e `relogios_presentes`. O que muda é a líder de cada estado: `cama_mesa_banho` em SP, `relogios_presentes` no RJ e `beleza_saude` em MG. (`queries/07_top_categorias_por_estado.sql`)

### Prazo de entrega e satisfação

**11. Pedidos entregues com atraso recebem notas piores?**
Sim. Pedidos entregues depois da data estimada tiveram nota média de 2,5, contra 4,25 dos entregues no prazo. Atraso e nota baixa andam juntos, mas os dados sozinhos não provam que o atraso é a causa. Usei `CASE WHEN` para classificar cada pedido e juntei `orders` com `order_reviews`. (`queries/08_atraso_vs_nota.sql`)

## Limitações

- A receita por categoria (pergunta 4) inclui itens de pedidos não entregues; as demais análises de receita consideram só pedidos entregues.
- O ticket médio e as receitas usam o preço dos itens e não incluem o frete.
- Alguns pedidos têm mais de uma avaliação, então entram mais de uma vez na comparação de notas. O efeito é pequeno.
- "Atraso" significa entregue depois da data estimada pela Olist.
- Os últimos meses do dataset podem aparecer mais baixos porque os dados terminam ali, e não por queda real nas vendas.

## Como reproduzir

1. Baixe o dataset no Kaggle.
2. Crie um banco chamado `olist` no MySQL e importe os CSVs (`orders`, `order_items`, `products`, `customers` e `order_reviews`).
3. Execute os arquivos da pasta `queries/` na ordem numérica. Cada arquivo começa com `USE olist;`.

## Próximos passos

- Dashboard em Power BI com receita por categoria e por mês.
- Novo projeto com outra fonte de dados.
