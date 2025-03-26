# Banco de Dados para Oficina Mecânica

Este repositório contém o script SQL para a criação do banco de dados de uma oficina mecânica. O objetivo deste banco de dados é armazenar informações sobre clientes, veículos, serviços, peças, mão de obra e ordens de serviço.

## Estrutura do Banco de Dados

O banco de dados é composto pelas seguintes tabelas:

### `customer`

Armazena informações sobre os clientes da oficina.

| Coluna        | Tipo        | Atributos           | Descrição                               |
|---------------|-------------|----------------------|-------------------------------------------|
| `idCustomer`  | INT         | AUTO_INCREMENT, PRIMARY KEY | Identificador único do cliente          |
| `Fname`       | VARCHAR(10) | NOT NULL             | Primeiro nome do cliente                 |
| `Minit`       | CHAR(3)     | DEFAULT NULL         | Inicial do nome do meio do cliente       |
| `Lname`       | VARCHAR(20) | NOT NULL             | Sobrenome do cliente                    |
| `CPF`         | CHAR(11)    | NOT NULL, UNIQUE     | Cadastro de Pessoa Física do cliente     |
| `Address`     | VARCHAR(255)| DEFAULT NULL         | Endereço do cliente                      |
| `contact`     | CHAR(11)    | NOT NULL             | Número de contato do cliente             |

### `vehicle`

Armazena informações sobre os veículos dos clientes.

| Coluna           | Tipo        | Atributos           | Descrição                                  |
|------------------|-------------|----------------------|----------------------------------------------|
| `idVehicle`      | INT         | AUTO_INCREMENT, PRIMARY KEY | Identificador único do veículo             |
| `idCustomer_own` | INT         |                      | ID do cliente proprietário (FOREIGN KEY para `customer`) |
| `plate`          | CHAR(7)     | NOT NULL, UNIQUE     | Placa do veículo                             |
| `model`          | VARCHAR(30) | NOT NULL             | Modelo do veículo                            |
| `brand`          | VARCHAR(30) | NOT NULL             | Marca do veículo                             |

### `Mechanics_Team`

Armazena informações sobre as equipes de mecânicos.

| Coluna        | Tipo        | Atributos           | Descrição                               |
|---------------|-------------|----------------------|-------------------------------------------|
| `idMechanics` | INT         | AUTO_INCREMENT, PRIMARY KEY | Identificador único da equipe de mecânicos |
| `Team_code`   | VARCHAR(30) | NOT NULL             | Código da equipe de mecânicos            |
| `specialty`   | VARCHAR(50) | DEFAULT NULL         | Especialidade da equipe                   |
| `contact`     | CHAR(11)    | DEFAULT NULL         | Número de contato da equipe              |

### `avaliation`

Armazena informações sobre as avaliações dos veículos para serviços.

| Coluna                | Tipo        | Atributos           | Descrição                                                   |
|-----------------------|-------------|----------------------|---------------------------------------------------------------|
| `idavaliation`        | INT         | AUTO_INCREMENT, PRIMARY KEY | Identificador único da avaliação                           |
| `idAV_vehicle`        | INT         |                      | ID do veículo avaliado (FOREIGN KEY para `vehicle`)          |
| `idAV_customer`       | INT         |                      | ID do cliente da avaliação (FOREIGN KEY para `customer`)      |
| `idAV_mechanics_team` | INT         |                      | ID da equipe de mecânicos (FOREIGN KEY para `Mechanics_Team`) |
| `type_service`        | ENUM('Conserto', 'Revisão') | NOT NULL             | Tipo de serviço (Conserto ou Revisão)                   |
| `problem_description` | VARCHAR(255)| NOT NULL             | Descrição do problema relatado pelo cliente                  |

### `service_order`

Armazena informações sobre as ordens de serviço.

| Coluna            | Tipo        | Atributos           | Descrição                                               |
|-------------------|-------------|----------------------|-----------------------------------------------------------|
| `idOS`            | INT         | AUTO_INCREMENT, PRIMARY KEY | Identificador único da ordem de serviço              |
| `id_ava`          | INT         |                      | ID da avaliação associada (FOREIGN KEY para `avaliation`) |
| `number_os`       | VARCHAR(50) |                      | Número da ordem de serviço                             |
| `emission_date`   | DATE        | NOT NULL             | Data de emissão da ordem de serviço                    |
| `status_os`       | ENUM('Finalizado', 'Em Andamento', 'Aguardando Aprovação', 'Cancelado') | DEFAULT 'Aguardando Aprovação' | Status da ordem de serviço                         |
| `conclusion_date` | DATE        | NOT NULL             | Data de conclusão da ordem de serviço                   |

### `parts`

Armazena informações sobre as peças utilizadas nos serviços.

| Coluna      | Tipo        | Atributos           | Descrição                        |
|-------------|-------------|----------------------|-----------------------------------|
| `idparts`   | INT         | AUTO_INCREMENT, PRIMARY KEY | Identificador único da peça      |
| `part`      | VARCHAR(50) | NOT NULL             | Nome da peça                      |
| `part_value`| FLOAT       | NOT NULL             | Valor unitário da peça            |

### `parts_os`

Relaciona as peças utilizadas em cada ordem de serviço.

| Coluna       | Tipo | Atributos           | Descrição                                     |
|--------------|------|----------------------|-------------------------------------------------|
| `idparts_os` | INT  | AUTO_INCREMENT, PRIMARY KEY | Identificador único da relação peça/OS        |
| `idOS_POS`   | INT  |                      | ID da ordem de serviço (FOREIGN KEY para `service_order`) |
| `idparts_POS`| INT  |                      | ID da peça (FOREIGN KEY para `parts`)          |
| `quantity`   | INT  |                      | Quantidade da peça utilizada                   |

### `labor`

Armazena informações sobre os tipos de mão de obra.

| Coluna             | Tipo        | Atributos           | Descrição                                    |
|--------------------|-------------|----------------------|-----------------------------------------------|
| `idlabor`          | INT         | AUTO_INCREMENT, PRIMARY KEY | Identificador único do tipo de mão de obra |
| `labor_type`       | VARCHAR(50) | NOT NULL             | Tipo de serviço de mão de obra               |
| `hours_to_finish`  | INT         | NOT NULL             | Horas necessárias para completar o serviço     |
| `service_description`| VARCHAR(255)| NOT NULL             | Descrição detalhada do serviço de mão de obra |
| `value_labor`      | FLOAT       | NOT NULL             | Valor da hora de trabalho                     |

### `labor_os`

Relaciona os serviços de mão de obra em cada ordem de serviço.

| Coluna      | Tipo | Atributos           | Descrição                                          |
|-------------|------|----------------------|------------------------------------------------------|
| `idlabor_os`| INT  | AUTO_INCREMENT, PRIMARY KEY | Identificador único da relação mão de obra/OS      |
| `idOS_LOS`  | INT  |                      | ID da ordem de serviço (FOREIGN KEY para `service_order`) |
| `idlabor_LOS`| INT  |                      | ID do serviço de mão de obra (FOREIGN KEY para `labor`) |

## Como Utilizar

1.  Certifique-se de ter um servidor de banco de dados MySQL instalado e em execução.
2.  Execute o script `oficina_db.sql` (ou o nome do arquivo que você salvar) no seu cliente MySQL (por exemplo, MySQL Workbench, linha de comando).

   ```sql
   mysql -u seu_usuario -p < oficina_db.sql

OBS: Este é um projeto de banco de dados com fins didáticos.
