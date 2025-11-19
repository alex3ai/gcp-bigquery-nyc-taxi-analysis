-- Arquivo destinado a armazenar todas as consultas SQL utilizadas no projeto
-- (BigQuery SQL Standard).

--Consulta 1: Volume de Viagens por Empresa (Vendor)
-- Pergunta: Como as viagens se distribuem entre as duas principais empresas?
-- Validação inicial dos dados.
SELECT
  VendorID,
  COUNT(1) AS total_viagens
FROM
  `static-sentinel-440121-a9.nyc_taxi_data.trips_yellow_2023_01`
GROUP BY
  VendorID;

--Consulta 2: Horários de Pico e Impacto no Faturamento
-- Pergunta: Qual a hora do dia com mais viagens e como o faturamento se comporta?
-- Essencial para alocação de motoristas.
SELECT
  EXTRACT(HOUR FROM tpep_pickup_datetime) AS hora_do_dia,
  COUNT(1) AS total_viagens,
  ROUND(AVG(total_amount), 2) AS faturamento_medio
FROM
  `static-sentinel-440121-a9.nyc_taxi_data.trips_yellow_2023_01`
GROUP BY
  hora_do_dia
ORDER BY
  hora_do_dia ASC;

--Consulta 3: Rotas Mais Populares
-- Pergunta: Quais são os 10 trajetos (zona de embarque -> zona de desembarque) mais comuns?
-- Útil para planejamento estratégico e marketing.
SELECT
  PULocationID,
  DOLocationID,
  COUNT(1) AS total_viagens
FROM
  `static-sentinel-440121-a9.nyc_taxi_data.trips_yellow_2023_01`
WHERE
  PULocationID IS NOT NULL AND DOLocationID IS NOT NULL
GROUP BY
  1, 2 -- Boa prática: usar números de posição para agrupar
ORDER BY
  total_viagens DESC
LIMIT 10;

--Consulta 4: Tendência de Faturamento com Média Móvel
-- Pergunta: Qual a tendência do faturamento diário, suavizando as variações do fim de semana?
-- Análise avançada com Window Functions.

--CTE para agregar os dados por dia.
WITH faturamento_diario AS (
  SELECT
    EXTRACT(DATE FROM tpep_pickup_datetime) AS dia,
    SUM(total_amount) AS faturamento_total
  FROM
    `static-sentinel-440121-a9.nyc_taxi_data.trips_yellow_2023_01`
  GROUP BY
    dia
)
--Calcular a média móvel de 7 dias sobre o resultado agregado.
SELECT
  dia,
  ROUND(faturamento_total, 2) AS faturamento_total,
  ROUND(
    AVG(faturamento_total) OVER (
      ORDER BY dia
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW -- Média dos 6 dias anteriores mais o dia atual
    ), 2
  ) AS media_movel_7dias
FROM
  faturamento_diario
ORDER BY
  dia;