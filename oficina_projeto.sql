-- ===============================
-- CRIAÇÃO DO BD PARA UMA OFICINA
-- ===============================
-- drop database oficina;
create database if not exists oficina;
use oficina;

-- Criar tabela cliente
create table customer(
	    idCustomer int auto_increment primary key,
        Fname varchar(10) not null,
        Minit char(3) default null,
        Lname varchar(20) not null,
        CPF char(11) not null,
        Address varchar(255) default null,
        contact char(11) not null,
        constraint unique_cpf_customer unique (CPF)
);

-- Criar tabela veículo
create table vehicle(
		idVehicle int auto_increment primary key,
        idCustomer_own int,
        plate char(7) not null,
        model varchar(30) not null,
        brand varchar(30) not null,
        constraint unique_plate unique (plate),
        constraint fk_customer_own foreign key (idCustomer_own) references customer(idCustomer)
);

-- Criar tabela equipe de mecanicos
create table Mechanics_Team(
		idMechanics int auto_increment primary key,
        Team_code varchar(30) not null,
        specialty varchar(50) default null,
        contact char(11) default null
);

-- Criar tabela avaliação
create table avaliation(
	    idavaliation int auto_increment primary key,
        idAV_vehicle int,
        idAV_customer int,
        idAV_mechanics_team int,
        type_service enum('Conserto', 'Revisão') not null,
        problem_description varchar(255) not null,
        constraint fk_customer_av foreign key (idAV_customer) references customer(idCustomer),
        constraint fk_vehicle_av foreign key (idAV_vehicle) references vehicle(idVehicle),
        constraint fk_mechanics_av foreign key (idAV_mechanics_team) references Mechanics_Team(idMechanics)
);

-- Criar tabela Ordem de Serviço
create table service_order(
		idOS int auto_increment primary key,
        id_ava int,
        number_os varchar(50),
        emission_date date not null,
        status_os enum('Finalizado', 'Em Andamento', 'Aguardando Aprovação', 'Cancelado') default 'Aguardando Aprovação',
        conclusion_date date not null,
        constraint fk_avaliation_os foreign key (id_ava) references avaliation(idavaliation)
);

-- Criar tabela Peças
create table parts(
		idparts int auto_increment primary key,
        part varchar(50) not null,
		part_value float not null
);

-- Criar tabela Peças/Ordem de Serviço
create table parts_os(
		idparts_os int auto_increment primary key,
        idOS_POS int,
        idparts_POS int,
		quantity int,
        constraint POS_fk_OS foreign key (idOS_POS) references service_order(idOS),
        constraint POS_fk_parts foreign key (idparts_POS) references parts(idparts)
);

-- Criar tabela Mão de Obra
create table labor(
		idlabor int auto_increment primary key,
        labor_type varchar(50) not null,
        hours_to_finish int not null,
        service_description varchar(255) not null,
        value_labor float not null
);

-- Criar tabela Mão de Obra/Ordem de Serviço
create table labor_os(
		idlabor_os int auto_increment primary key,
		idOS_LOS int,
        idlabor_LOS int,
        constraint fk_OS foreign key (idOS_LOS) references service_order(idOS),
        constraint fk_labor foreign key (idlabor_LOS) references labor(idlabor)
);



-- ==================
-- INSERÇÃO DE DADOS
-- ==================

insert into customer(Fname, Minit, Lname, CPF, Address, contact)
       values ('Rodrigo', null, 'Silva', 49521548796, 'Rua Almirante Tcheck, 5241 - Centro', 21945310542),
              ('Romulo', 'V', 'Ferreira', 94031524856, 'Avenida Salazar Compadre, 125 - Tunas', 33981052156),
              ('Matias', null, 'Gonçalves', 16204862105, 'Padre Lira, 94 - Ostras', 11952048510),
              ('Marta', 'C', 'Aguillera', 61045238745, 'Aloisio Bustamante, 23 - Goiana', 11975310254),
              ('Lucas', null, 'Lanzini', 82154896325, 'Avenida Muriel, 85 - Marduck', 11999548201),
              ('Armando', null, 'Ramos', 58729437810, 'Rua Kardek, 41 - Iria', 11975184308),
              ('Olga', 'B', 'Nascimento', 27845102569, 'Goulart, 62 - Centro', 11983278984),
              ('Megan', null, 'Santana', 76945201200, 'Coimbra, 22 - Celso', 11999872051),
              ('Munis', null, 'Aragão', 30048751025, 'Monte Rei, 15 - Atlantis', 11902415628),
              ('Sergio', null, 'Van Derk', 14287539024, 'Elementar, 5 - Centro', 11945723015),
              ('Ludi', 'W', 'Mantovani', 38742036541, 'Rua Almirante Tcheck, 1745 - Centro', 21984753201),
              ('Astolfo', 'E', 'Vignolles', 75102695482, 'Rua Kardek, 28 - Iria', 11984762305),
              ('Menphis', null, 'Silveira', 27895410265, 'Manoia Cupim, 785 - Iria', 11937420158),
              ('Rodrigo', null, 'Ferreira', 19754203654, 'Padre Lira, 185 - Ostras', 11954789201),
              ('Bruno', 'V', 'Marroni', 75120654820, 'Goulart, 810 - Centro', 1198301548);

insert into vehicle (idCustomer_own, plate, model, brand) 
            values (1, 'ABC1D23', 'Gol', 'Volkswagen'),
                   (2, 'DEF4G56', 'Uno', 'Fiat'),
				   (3, 'GHI7J89', 'Onix', 'Chevrolet'),
				   (4, 'JKL0M12', 'Ka', 'Ford'),
                   (5, 'MNO3P45', 'Corolla', 'Toyota'),
                   (6, 'PQR6S78', 'HB20', 'Hyundai'),
                   (7, 'STU9V01', 'Polo', 'Volkswagen'),
                   (8, 'VWX2Y34', 'Argo', 'Fiat'),
                   (9, 'YZA5B67', 'Tracker', 'Chevrolet'),
                   (10, 'BCD8E90', 'Ecosport', 'Ford'),
                   (11, 'EFG1H23', 'Hilux', 'Toyota'),
                   (12, 'HIJ4K56', 'Creta', 'Hyundai'),
				   (13, 'KLM7N89', 'T-Cross', 'Volkswagen'),
                   (14, 'NOP0Q12', 'Pulse', 'Fiat'),
                   (15, 'QRS3T45', 'Onix Plus', 'Chevrolet');
				
insert into Mechanics_Team (Team_code, specialty, contact) 
            values ('TM-001', 'Motor e Transmissão', '11987654321'),
                   ('TM-002', 'Suspensão e Freios', '11912345678'),
                   ('TM-003', 'Elétrica Automotiva', '11999998888'),
                   ('TM-004', 'Funilaria e Pintura', '11988887777'),
                   ('TM-005', 'Ar Condicionado Automotivo', '11977776666'),
                   ('TM-006', 'Diagnóstico Eletrônico', '11966665555'),
                   ('TM-007', 'Troca de Óleo e Filtros', '11955554444'),
                   ('TM-008', 'Alinhamento e Balanceamento', '11944443333'),
                   ('TM-009', 'Mecânica Geral', '11933332222'),
                   ('TM-010', 'Inspeção Veicular', '11922221111'),
                   ('TM-011', 'Retífica de Motores', '11911110000'),
                   ('TM-012', 'Instalação de Acessórios', '11900009999'),
                   ('TM-013', 'Serviços de Guincho', '11999887766'),
                   ('TM-014', 'Customização Automotiva', '11988776655'),
                   ('TM-015', 'Manutenção Preventiva', '11977665544');
                   
select * from vehicle;
desc service_order;

insert into avaliation (idAV_vehicle, idAV_customer, idAV_mechanics_team, type_service, problem_description) 
       values (1, 1, 1, 'revisão', 'Revisão de rotina com verificação de óleo e filtros.'),
              (2, 2, 2, 'conserto', 'Barulho estranho ao frear e pedal com pouca resposta.'),
              (3, 3, 3, 'revisão', 'Verificar luz de injeção acesa e realizar diagnóstico eletrônico.'),
              (4, 4, 4, 'conserto', 'Amassado na porta dianteira esquerda e pintura arranhada.'),
              (5, 5, 1, 'revisão', 'Revisão geral do motor e verificar nível de fluidos.'),
              (6, 6, 5, 'conserto', 'Ar condicionado não está gelando e faz um barulho estranho.'),
			  (7, 7, 2, 'revisão', 'Verificar suspensão, pois o carro está instável em curvas.'),
			  (8, 8, 3, 'conserto', 'Farol dianteiro direito não acende.'),
              (9, 9, 1, 'revisão', 'Solicitar troca de óleo, filtro de óleo e filtro de ar.'),
              (10, 10, 8, 'conserto', 'Sentindo vibração no volante e o carro puxando para a direita.'),
              (11, 11, 3, 'revisão', 'Verificar bateria e sistema de carga.'),
              (12, 12, 5, 'conserto', 'Ventilador do ar condicionado não está funcionando.'),
              (13, 13, 2, 'revisão', 'Verificar condição dos pneus e realizar rodízio.'),
              (14, 14, 4, 'conserto', 'Pequenos riscos na pintura do para-choque traseiro.'),
              (15, 15, 1, 'revisão', 'Revisão completa do veículo antes de uma viagem longa.');
              
insert into service_order (number_os, id_ava, emission_date, status_os, conclusion_date) 
       values ('OS-20250325-001', 1, '2025-03-25', 'Em Andamento', '2025-03-27'),
              ('OS-20250325-002', 2, '2025-03-25', 'Aguardando Aprovação', '2025-03-26'),
              ('OS-20250325-003', 3, '2025-03-25', 'Finalizado', '2025-03-25'),
              ('OS-20250325-004', 4, '2025-03-25', 'Em Andamento', '2025-03-29'),
              ('OS-20250325-005', 5, '2025-03-25', 'Finalizado', '2025-03-25'),
              ('OS-20250325-006', 6, '2025-03-25', 'Aguardando Aprovação', '2025-03-27'),
              ('OS-20250325-007', 7, '2025-03-25', 'Em Andamento', '2025-03-28'),
              ('OS-20250325-008', 8, '2025-03-25', 'Finalizado', '2025-03-26'),
              ('OS-20250325-009', 9, '2025-03-25', 'Em Andamento', '2025-03-27'),
              ('OS-20250325-010', 10, '2025-03-25', 'Aguardando Aprovação', '2025-03-26'),
              ('OS-20250325-011', 11, '2025-03-25', 'Finalizado', '2025-03-25'),
              ('OS-20250325-012', 12, '2025-03-25', 'Em Andamento', '2025-03-30'),
              ('OS-20250325-013', 13, '2025-03-25', 'Finalizado', '2025-03-26'),
              ('OS-20250325-014', 14, '2025-03-25', 'Em Andamento', '2025-03-28'),
              ('OS-20250325-015', 15, '2025-03-25', 'Aguardando Aprovação', '2025-03-26');
              
insert into parts (part, part_value) 
       values ('Filtro de óleo', 35.00),
              ('Filtro de ar', 45.00),
			  ('Filtro de combustível', 60.00),
              ('Jogo de pastilhas de freio dianteiro', 180.00),
              ('Disco de freio dianteiro (unitário)', 150.00),
              ('Amortecedor dianteiro (unitário)', 220.00),
              ('Lâmpada do farol (unitária)', 50.00),
			  ('Bateria automotiva', 350.00),
              ('Pneu (unitário)', 400.00),
              ('Óleo de motor (litro)', 25.00),
              ('Fluido de freio (500ml)', 30.00),
              ('Filtro de ar condicionado', 70.00),
              ('Vela de ignição (unitária)', 40.00),
              ('Correia dentada', 120.00),
              ('Tensor da correia dentada', 80.00),
			  ('Bomba de combustível', 280.00),
              ('Radiador', 450.00),
              ('Ventilador do radiador', 190.00),
              ('Alternador', 550.00),
			  ('Motor de partida', 380.00),
              ('Bobina de ignição (unitária)', 90.00),
              ('Sensor de oxigênio', 160.00),
              ('Catalisador', 800.00),
              ('Escapamento completo', 650.00),
              ('Embreagem (kit completo)', 700.00),
              ('Caixa de direção hidráulica', 950.00),
              ('Bieleta da suspensão (unitária)', 60.00),
              ('Terminal de direção (unitário)', 75.00),
              ('Coxim do motor (unitário)', 110.00),
              ('Retrovisor externo completo', 250.00);

insert into parts_os (idOS_POS, idparts_POS, quantity) 
       values (1, 1, 1), -- OS 1 (Revisão): Filtro de óleo
              (1, 2, 1), -- OS 1 (Revisão): Filtro de ar
			  (1, 10, 4), -- OS 1 (Revisão): Óleo de motor (4 litros)
              (2, 4, 1), -- OS 2 (Freios): Jogo de pastilhas dianteiro
              (2, 11, 1), -- OS 2 (Freios): Fluido de freio
              (3, 3, 1), -- OS 3 (Diagnóstico): Filtro de combustível (pode ser uma causa)
              (4, 15, 1), -- OS 4 (Funilaria): Retrovisor externo completo
              (5, 1, 1), -- OS 5 (Revisão Motor): Filtro de óleo
              (5, 10, 4), -- OS 5 (Revisão Motor): Óleo de motor
              (6, 12, 1), -- OS 6 (Ar Condicionado): Filtro de ar condicionado
              (7, 5, 2), -- OS 7 (Suspensão): Disco de freio dianteiro (2 unidades)
              (8, 8, 1), -- OS 8 (Elétrica): Bateria automotiva
              (9, 1, 1),  -- OS 9 (Troca de Óleo): Filtro de óleo
              (9, 10, 4), -- OS 9 (Troca de Óleo): Óleo de motor
              (9, 2, 1),  -- OS 9 (Troca de Óleo): Filtro de ar
              (10, 8, 2), -- OS 10 (Alinhamento): Bieleta da suspensão (2 unidades)
              (11, 8, 1), -- OS 11 (Elétrica): Bateria automotiva (pode ser a causa da verificação)
              (12, 12, 1), -- OS 12 (Ar Condicionado): Filtro de ar condicionado (pode ser a causa)
              (13, 4, 1), -- OS 13 (Pneus): Jogo de pastilhas (verificação durante rodízio)
              (14, NULL, NULL), -- OS 14 (Pintura): Não necessariamente requer peças (mão de obra)
              (15, 1, 1), -- OS 15 (Revisão Geral): Filtro de óleo
              (15, 2, 1), -- OS 15 (Revisão Geral): Filtro de ar
              (15, 3, 1), -- OS 15 (Revisão Geral): Filtro de combustível
              (15, 10, 4); -- OS 15 (Revisão Geral): Óleo de motor

insert into labor (labor_type, hours_to_finish, service_description, value_labor)
                 values('Troca de óleo da transmissão automática', 2.0, 'Substituição do fluido da transmissão automática.', 200.00),
                         ('Limpeza de bicos injetores', 2.5, 'Limpeza dos bicos injetores para melhor desempenho do motor.', 250.00),
                         ('Regulagem de válvulas', 3.0, 'Ajuste da folga das válvulas do motor.', 300.00),
                         ('Retífica de motor (parcial)', 20.0, 'Serviço de retífica parcial do motor, incluindo troca de anéis e brunimento dos cilindros.', 2000.00),
                         ('Retífica de motor (completa)', 40.0, 'Serviço completo de retífica do motor, incluindo usinagem de peças e substituição de componentes.', 4000.00),
                         ('Troca da bomba d\'água', 3.5, 'Substituição da bomba d\'água do sistema de arrefecimento.', 350.00),
                         ('Troca da válvula termostática', 1.5, 'Substituição da válvula termostática do sistema de arrefecimento.', 150.00),
                         ('Revisão do sistema de freio ABS', 2.0, 'Diagnóstico e revisão dos componentes do sistema de freio ABS.', 220.00),
                         ('Troca de rolamentos de roda (unitário)', 2.0, 'Substituição de um rolamento de roda.', 200.00),
                         ('Instalação de sensor de estacionamento', 2.0, 'Instalação de um sistema de sensores de estacionamento.', 250.00),
                         ('Instalação de câmera de ré', 1.5, 'Instalação de uma câmera de ré.', 200.00),
                         ('Higienização do ar condicionado', 1.0, 'Limpeza e higienização do sistema de ar condicionado para eliminar odores e bactérias.', 120.00),
                         ('Teste de compressão do motor', 1.0, 'Teste para verificar a compressão dos cilindros do motor.', 100.00),
                         ('Remoção e instalação de câmbio', 8.0, 'Serviço de remoção e reinstalação da caixa de câmbio.', 800.00),
                         ('Serviço de solda (pequeno)', 1.0, 'Pequenos serviços de solda em componentes do veículo.', 150.00);
select * from labor;
insert into labor_os (idOS_LOS, idlabor_LOS) 
       values (1, 1),  -- OS 1 (Revisão): Troca de óleo e filtros
              (1, 13), -- OS 1 (Revisão): Revisão geral do veículo
              (2, 2),  -- OS 2 (Freios): Troca de pastilhas de freio dianteiro
              (3, 6),  -- OS 3 (Diagnóstico): Diagnóstico eletrônico
              (4, 10), -- OS 4 (Funilaria): Serviço de funilaria (pequeno reparo)
              (4, 11), -- OS 4 (Funilaria): Serviço de pintura (pequena área)
			  (5, 1),  -- OS 5 (Revisão Motor): Troca de óleo e filtros (inclui verificação de fluidos)
              (5, 13), -- OS 5 (Revisão Motor): Revisão geral do veículo
              (6, 7),  -- OS 6 (Ar Condicionado): Carga de gás do ar condicionado
              (7, 3),  -- OS 7 (Suspensão): Troca de discos de freio dianteiro
              (8, 8),  -- OS 8 (Elétrica): Troca de bateria
              (9, 1),  -- OS 9 (Troca de Óleo): Troca de óleo e filtros
              (10, 4), -- OS 10 (Alinhamento): Alinhamento de direção
              (10, 5), -- OS 10 (Alinhamento): Balanceamento de rodas
              (11, 6), -- OS 11 (Elétrica): Diagnóstico eletrônico (para verificar sistema de carga)
              (12, 7), -- OS 12 (Ar Condicionado): Carga de gás do ar condicionado (pode ser a solução)
              (13, 5), -- OS 13 (Pneus): Balanceamento de rodas (com rodízio)
              (14, 11), -- OS 14 (Pintura): Serviço de pintura (pequena área)
              (15, 1), -- OS 15 (Revisão Geral): Troca de óleo e filtros
              (15, 13); -- OS 15 (Revisão Geral): Revisão geral do veículo
              
              
              
-- ========================================
-- RECUPERAÇÃO SIMPLES COM SELECT STATMENT
-- ========================================

-- Recuperando dados dos clientes
select concat(Fname, ' ', Lname) as Customer, CPF, Address, contact from customer;



-- ===========================
-- FILTROS COM WHERE STATMENT
-- ===========================

select concat(Fname, ' ', Lname) as Cliente, CPF, contact as Contato, status_os as Status_Serviço from customer c 
			inner join avaliation av on c.idCustomer = av.idAV_customer
            inner join service_order os on av.idavaliation = os.id_ava
            where status_os = 'Finalizado';


-- ================================================================================
-- CRIE EXPRESSÕES PARA GERAR ATRIBUTOS DERIVADOS / ORDER BY / PESPECTIVA COMPLEXA
-- ================================================================================

-- Recuperando infos relevantes do cliente como: identificação, veículo e situação, equipe designada, serviços, peças, e seus respectivos valores
select concat(Fname, ' ', Lname) as Cliente, number_os as OS, type_service as Serviço, v.model as Modelo, v.plate as Placa, m.Team_code as Equipe, 
m.specialty as Especialidade, l.labor_type as Mão_de_Obra, l.value_labor as Valor_Mão_de_Obra, p.part as Peça, p.part_value as Valor_Peça, 
sum(p.part_value + l.value_labor) as Valor_Total
	   from customer c
       inner join service_order os on c.idCustomer = os.idOS
       inner join avaliation ava on ava.idavaliation = os.id_ava
       inner join labor_os lo on lo.idOS_LOS = os.idOS
       inner join labor l on l.idlabor = lo.idlabor_LOS
       inner join parts_os pos on pos.idOS_POS = os.idOS
       inner join parts p on p.idparts = pos.idparts_POS
       inner join vehicle v on v.idCustomer_own = c.idCustomer
       inner join mechanics_team m on m.idMechanics = ava.idAV_mechanics_team 
       group by c.idCustomer, c.Fname, c.Lname, number_os, type_service, model, plate, labor_type, value_labor, part, part_value;

-- Recuperando Total pago pelo cliente
WITH LaborTotal AS (
    SELECT
        lo.idOS_LOS,
        SUM(l.value_labor) AS TotalLabor
    FROM labor_os lo
    INNER JOIN labor l ON lo.idlabor_LOS = l.idlabor
    GROUP BY lo.idOS_LOS
),
PartsTotal AS (
    SELECT
        pos.idOS_POS,
        SUM(p.part_value) AS TotalParts
    FROM parts_os pos
    INNER JOIN parts p ON pos.idparts_POS = p.idparts
    GROUP BY pos.idOS_POS
)
SELECT
    concat(c.Fname, ' ', c.Lname) AS Cliente,
    SUM(COALESCE(lt.TotalLabor, 0) + COALESCE(pt.TotalParts, 0)) AS Valor_Total_Cliente
FROM customer c
INNER JOIN service_order os ON c.idCustomer = os.idOS
LEFT JOIN LaborTotal lt ON os.idOS = lt.idOS_LOS
LEFT JOIN PartsTotal pt ON os.idOS = pt.idOS_POS
GROUP BY c.idCustomer, c.Fname, c.Lname;


-- ===============
-- HAVING STATMENT
-- ===============

-- Filtrando clientes com o valor de mão de obra acima de 1000,00
select concat(Fname, ' ', Lname) as Cliente, number_os as OS, type_service as Serviço, v.model as Modelo, v.plate as Placa, 
m.Team_code as Equipe, m.specialty as Especialidade, l.labor_type as Mão_de_Obra, l.value_labor as Valor_Mão_de_Obra, p.part as Peça, 
p.part_value as Valor_Peça, sum(p.part_value + l.value_labor) as Valor_Total
	   from customer c
       inner join service_order os on c.idCustomer = os.idOS
       inner join avaliation ava on ava.idavaliation = os.id_ava
       inner join labor_os lo on lo.idOS_LOS = os.idOS
       inner join labor l on l.idlabor = lo.idlabor_LOS
       inner join parts_os pos on pos.idOS_POS = os.idOS
       inner join parts p on p.idparts = pos.idparts_POS
       inner join vehicle v on v.idCustomer_own = c.idCustomer
       inner join mechanics_team m on m.idMechanics = ava.idAV_mechanics_team 
       group by c.idCustomer, c.Fname, c.Lname, number_os, type_service, model, plate, labor_type, value_labor, part, part_value
       having l.value_labor > 1000;

