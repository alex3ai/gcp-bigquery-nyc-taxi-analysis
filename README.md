# 📊 Análise de Viagens de Táxi NYC 2023 - Arquitetura de Dados em GCP

[![GCP](https://img.shields.io/badge/Google_Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)](https://cloud.google.com/)
[![BigQuery](https://img.shields.io/badge/BigQuery-F58000?style=for-the-badge&logo=google-bigquery&logoColor=white)](https://cloud.google.com/bigquery)
[![SQL](https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Looker Studio](https://img.shields.io/badge/Looker_Studio-01B98D?style=for-the-badge&logo=google&logoColor=white)](https://lookerstudio.google.com/)

---

## 1. Visão Geral do Projeto

Este projeto demonstra a criação de um pipeline de dados analíticos completo (End-to-End) na nuvem utilizando serviços do Google Cloud Platform (GCP).

* **O que:** Análise exploratória de milhões de registros de viagens de táxi amarelo de Nova York (dataset de Janeiro/2023).
* **O Objetivo:** Demonstrar proficiência em arquitetura de dados moderna (ELT) e extrair insights acionáveis sobre padrões de viagem e tarifação.

---

## 2. Arquitetura e Fluxo de Dados (ELT)

O pipeline segue um padrão de **Extract, Load, Transform (ELT)**, desacoplando o armazenamento do processamento para otimizar custos e performance.

1.  **Extract & Load (E/L):** O dataset original no formato **Parquet** é armazenado no **Cloud Storage (GCS)**, que atua como o **Data Lake/Staging Area** do projeto. O formato Parquet foi escolhido para otimizar a leitura colunar e reduzir o volume de dados processados.
2.  **Load (L):** Os dados são carregados do GCS para o **BigQuery**, o Data Warehouse do GCP, onde são armazenados e ficam prontos para consulta.
3.  **Transform (T):** A transformação (agregação, cálculos, etc.) é realizada **dentro** do BigQuery usando consultas SQL (Passo 3).
4.  **Visualização:** O BigQuery é conectado diretamente ao **Looker Studio** para a criação de um dashboard interativo (Passo 4).

### ⚙️ Configuração Inicial

* **Projeto GCP:** Criado um projeto isolado (`portfolio-taxi-nyc-...`) com as APIs de **Cloud Storage** e **BigQuery** habilitadas, seguindo a melhor prática de modularidade e controle de recursos.
* **Ingestão de Dados:** O arquivo `yellow_tripdata_2023-01.parquet` foi carregado para o bucket do GCS e, subsequentemente, para o dataset `nyc_taxi_data` no BigQuery.

---

## 🏛️ Análise e Estimativa de Custos (FinOps)

Um aspecto crucial em projetos de nuvem é a gestão de custos. Embora este projeto tenha um custo efetivo de **$0.00** por se enquadrar no **Nível Gratuito (Free Tier) do Google Cloud**, a análise abaixo detalha como os custos seriam calculados em um cenário real, demonstrando uma mentalidade orientada a FinOps.

A arquitetura do projeto (`GCS -> BigQuery -> Looker Studio`) foi desenhada para ser extremamente eficiente em custos.

| Serviço | Componente de Custo | Uso no Projeto | Estimativa de Custo Mensal |
| :--- | :--- | :--- | :--- |
| **Cloud Storage (GCS)** | Armazenamento | ~50 MB (0.05 GB) para o arquivo `.parquet` | $0.00 (Nível gratuito inclui 5 GB/mês) |
| | Operações (Classe A/B) | ~10-20 operações (upload, leitura pelo BQ) | $0.00 (Nível gratuito inclui milhares de operações)|
| **BigQuery** | Armazenamento (Storage) | ~50 MB de dados na tabela | $0.00 (Nível gratuito inclui 10 GB/mês) |
| | Processamento (Análise) | ~200-300 MB processados em todas as queries | $0.00 (Nível gratuito inclui 1 TB/mês) |
| **Looker Studio** | Visualização | 1 Dashboard conectado via BigQuery | $0.00 (O Looker Studio é gratuito) |
| **Custo Total Estimado** | | | **~$0.00** |

#### **Conclusão da Análise**

O custo para a ingestão, armazenamento, análise e visualização dos dados deste projeto é efetivamente nulo, graças ao generoso Nível Gratuito do GCP. Mesmo que o volume de dados aumentasse 100 vezes (para 5 GB), o custo ainda permaneceria próximo de zero.

Para validar estas estimativas, foi utilizada a **Calculadora de Preços do Google Cloud**. O uso de ferramentas oficiais para o planejamento e previsão de custos demonstra uma habilidade essencial e muito valorizada no mercado, validando a arquitetura como uma solução altamente escalável e de baixo custo para pipelines de dados analíticos.

---

## 3. Análise e Insights (SQL)

*(Esta seção será preenchida no próximo passo, contendo os Key Findings e o link para o Dashboard.)*