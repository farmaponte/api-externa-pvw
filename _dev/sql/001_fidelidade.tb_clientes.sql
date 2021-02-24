create user postgres with createdb password 'docker1234';

CREATE SCHEMA fidelidade AUTHORIZATION postgres;

ALTER SCHEMA fidelidade
  OWNER TO postgres;

CREATE TABLE fidelidade.tb_clientes (
  id SERIAL,
  num_cartao BIGINT,
  tb_tipo_fidelidade_id INTEGER,
  id_convenio INTEGER,
  nome VARCHAR(80) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  rg VARCHAR(15),
  endereco VARCHAR(50),
  numero INTEGER,
  complemento VARCHAR(60),
  bairro VARCHAR(50),
  cep INTEGER,
  id_cidade INTEGER,
  ddd1 CHAR(4),
  fone1 VARCHAR(20),
  ddd2 CHAR(4),
  fone2 VARCHAR(20),
  ddd3 CHAR(4),
  celular VARCHAR(20),
  email VARCHAR(80),
  sexo CHAR(1),
  nascimento DATE,
  filial INTEGER,
  auditoriadatahora TIMESTAMP WITHOUT TIME ZONE DEFAULT 'now'::text::date,
  cartao_emitido BOOLEAN,
  loteria INTEGER,
  tb_status_cliente_id INTEGER DEFAULT 0,
  tb_status_venda_id INTEGER DEFAULT 0,
  tb_usuario_id INTEGER,
  tb_clientes_sorocred_id INTEGER,
  tratamento VARCHAR(500),
  dth_alteracao TIMESTAMP(0) WITHOUT TIME ZONE,
  dth_verificacao TIMESTAMP(0) WITHOUT TIME ZONE,
  logradouro VARCHAR(50),
  status VARCHAR(1),
  tb_envio_dotz_id INTEGER,
  vendedor INTEGER,
  cartao_orcamento BOOLEAN,
  tb_tipo_fidelidade_grupo_id INTEGER DEFAULT 1,
  dth_emissao_cartao DATE,
  inativacao_tb_usuario_id INTEGER,
  entidade INTEGER,
  convenio_cartao INTEGER,
  cartao_integracao BOOLEAN DEFAULT false,
  tipo_integracao INTEGER,
  cpf_gerado BOOLEAN DEFAULT false,
  CONSTRAINT tb_cadastro_clientes_pkey PRIMARY KEY(id)/*,
  CONSTRAINT tb_clientes_fk FOREIGN KEY (tb_envio_dotz_id)
    REFERENCES fidelidade.tb_envio_layouts_dotz(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT tb_clientes_fk_status_cliente FOREIGN KEY (tb_status_cliente_id)
    REFERENCES fidelidade.tb_status(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT tb_clientes_fk_status_venda FOREIGN KEY (tb_status_venda_id)
    REFERENCES fidelidade.tb_status(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT tb_clientes_fk_tipo_fidelidade FOREIGN KEY (tb_tipo_fidelidade_id)
    REFERENCES fidelidade.tb_tipo_fidelidade(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE*/
);

COMMENT ON COLUMN fidelidade.tb_clientes.num_cartao
IS 'Numeracao do novo cartao fidelidade; (numero que esta pré-impresso no cartao)';

COMMENT ON COLUMN fidelidade.tb_clientes.tb_tipo_fidelidade_id
IS 'Tipo de cartão (midia) que o cliente possui
relacionado com a tabela tb_tipo_fidelidade';

COMMENT ON COLUMN fidelidade.tb_clientes.id_convenio
IS 'campo ai na tabela stfil002 do pgsql-ext; referencia uma ligação entre o fidelidade e o id do conveniado quando existir';

COMMENT ON COLUMN fidelidade.tb_clientes.filial
IS 'filial em que foi realizado o cadastro';

COMMENT ON COLUMN fidelidade.tb_clientes.auditoriadatahora
IS 'Data/Hora em que foi realizado o cadastro do cliente.';

COMMENT ON COLUMN fidelidade.tb_clientes.cartao_emitido
IS 'indica se ja possui cartao emitido (compatibilidade com os cartoes antigos por cpf que necessitavam de impressao)';

COMMENT ON COLUMN fidelidade.tb_clientes.tb_status_cliente_id
IS 'fk com a tabela fidelidade.tb_status_cliente';

COMMENT ON COLUMN fidelidade.tb_clientes.tb_status_venda_id
IS 'fk com a tabela fidelidade.tb_status_venda';

COMMENT ON COLUMN fidelidade.tb_clientes.tb_usuario_id
IS 'id do usuario que cadastrou o cliente';

COMMENT ON COLUMN fidelidade.tb_clientes.tb_clientes_sorocred_id
IS 'fk com a tabela fidelidade.tb_clientes_sorocred';

COMMENT ON COLUMN fidelidade.tb_clientes.tratamento
IS 'Campo preenchido ao coletar as aferições (controle de glicemia, ect) do cliente.';

COMMENT ON COLUMN fidelidade.tb_clientes.dth_alteracao
IS 'Data da ultima alteração do cadastro do cliente';

COMMENT ON COLUMN fidelidade.tb_clientes.dth_verificacao
IS 'Data de verificação do cadastro';

COMMENT ON COLUMN fidelidade.tb_clientes.vendedor
IS 'Código do vendedor que efetuou o cadastro';

COMMENT ON COLUMN fidelidade.tb_clientes.cartao_orcamento
IS 'indica se o cartão será utilizado apenas para orçamentos, não gerando a conclusão do processo no caixa';

COMMENT ON COLUMN fidelidade.tb_clientes.dth_emissao_cartao
IS 'data de impressão do cartão';

COMMENT ON COLUMN fidelidade.tb_clientes.inativacao_tb_usuario_id
IS 'Usuário que fez a inativação do cliente.';

COMMENT ON COLUMN fidelidade.tb_clientes.entidade
IS 'PBS_FARMAPONTE_DADOS.DBO.ENTIDADES
PROCFIT - MSSQL';

COMMENT ON COLUMN fidelidade.tb_clientes.convenio_cartao
IS 'PBS_FARMAPONTE_DADOS.DBO.ENTIDADES_CONVENIOS_CARTOES
PROCFIT - MSSQL';

COMMENT ON COLUMN fidelidade.tb_clientes.cartao_integracao
IS 'Indica se é cadastro utilizado para integrações de outras origens.';

COMMENT ON COLUMN fidelidade.tb_clientes.tipo_integracao
IS '1 - Ifood';

COMMENT ON COLUMN fidelidade.tb_clientes.cpf_gerado
IS 'Indica se o cadastro foi feito pelo Prevenda Web, onde o cliente optou por não se fidelizar, gerando assim um cadastro nessa tabela com um número de cpf gerado a partir do número do cartão-convênio informado';

CREATE INDEX tb_clientes_idx ON fidelidade.tb_clientes
  USING btree (tb_tipo_fidelidade_grupo_id);

CREATE UNIQUE INDEX tb_clientes_idx_cpf ON fidelidade.tb_clientes
  USING btree (cpf COLLATE pg_catalog."default");

CREATE INDEX tb_clientes_idx_filial ON fidelidade.tb_clientes
  USING btree (filial);

CREATE UNIQUE INDEX tb_clientes_idx_id_convenio ON fidelidade.tb_clientes
  USING btree (id_convenio);

CREATE UNIQUE INDEX tb_clientes_idx_num_cartao ON fidelidade.tb_clientes
  USING btree (num_cartao);

CREATE INDEX tb_clientes_idx_tipo_integracao ON fidelidade.tb_clientes
  USING btree (tipo_integracao);

ALTER TABLE fidelidade.tb_clientes
  OWNER TO postgres;

INSERT INTO fidelidade.tb_clientes ("id", "num_cartao", "tb_tipo_fidelidade_id", "id_convenio", "nome", "cpf", "rg", "endereco", "numero", "complemento", "bairro", "cep", "id_cidade", "ddd1", "fone1", "ddd2", "fone2", "ddd3", "celular", "email", "sexo", "nascimento", "filial", "auditoriadatahora", "cartao_emitido", "loteria", "tb_status_cliente_id", "tb_status_venda_id", "tb_usuario_id", "tb_clientes_sorocred_id", "tratamento", "dth_alteracao", "dth_verificacao", "logradouro", "status", "tb_envio_dotz_id", "vendedor", "cartao_orcamento", "tb_tipo_fidelidade_grupo_id", "dth_emissao_cartao", "inativacao_tb_usuario_id", "entidade", "convenio_cartao", "cartao_integracao", "tipo_integracao", "cpf_gerado")
VALUES 
  (421097, 278450, 6, 509832, E'CELSO ALEXANDRE PALMA JUNIOR', E'41024274810', E'', E'CHILE', 1015, NULL, E'VILA BARCELONA', 18025280, 595, NULL, NULL, NULL, NULL, NULL, NULL, NULL, E'M', E'1994-05-17', 19, E'2014-08-02 00:00:00', True, NULL, 0, 0, 591, NULL, NULL, E'2021-01-12 13:09:05', NULL, NULL, NULL, NULL, NULL, NULL, 1, E'2017-07-19', NULL, 155068, 218208, False, NULL, False);