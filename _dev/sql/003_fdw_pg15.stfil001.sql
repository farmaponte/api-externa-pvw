CREATE TABLE fdw_pg15.stfil001 (
  ai INTEGER NOT NULL,
  controle INTEGER,
  empcodemp INTEGER NOT NULL,
  emprazsoc VARCHAR(40),
  empendemp VARCHAR(40),
  empbaiemp VARCHAR(40),
  empmunemp VARCHAR(20),
  empestemp CHAR(2),
  empcepemp VARCHAR(8),
  emptelemp VARCHAR(15),
  empfaxemp VARCHAR(15),
  empcgcemp VARCHAR(14),
  empinsest VARCHAR(15),
  emprazcom VARCHAR(40),
  empdiafec INTEGER,
  empresfec VARCHAR(10),
  empdiaent INTEGER,
  empfecele BOOLEAN,
  empgertit BOOLEAN,
  empgereti BOOLEAN,
  empdiapag CHAR(3),
  empflasel CHAR(1),
  empmsgcar VARCHAR(40),
  empmsgca2 VARCHAR(40),
  empdiufec DATE,
  empdfufec DATE,
  empdifatu DATE,
  empdffatu DATE,
  empflafec CHAR(1),
  empfunfec VARCHAR(10),
  empsenfec VARCHAR(10),
  emptipcob INTEGER,
  empimpnot BOOLEAN,
  emptipnot INTEGER,
  empbcolpg INTEGER,
  empbancob VARCHAR(40),
  empflacar BOOLEAN,
  empempcan BOOLEAN DEFAULT true,
  emptipcon INTEGER DEFAULT 0,
  empflapro BOOLEAN,
  empmespro CHAR(4),
  empnotemp TEXT,
  empobsemp VARCHAR(40),
  empdatpag DATE,
  empconemp VARCHAR(40),
  empccgemp VARCHAR(20),
  empcstemp VARCHAR(20),
  empcdaemp CHAR(5),
  empemlemp VARCHAR(60),
  empflaeti BOOLEAN,
  --empendcob VARCHAR(40),
  empbaicob VARCHAR(20),
  empmuncob VARCHAR(20),
  empestcob CHAR(2),
  empcepcob VARCHAR(8),
  emprelfec VARCHAR(12),
  empdatinc DATE,
  emplimini DATE,
  emplimfin DATE,
  empflafdp BOOLEAN,
  empualemp DATE,
  empflapvc BOOLEAN,
  empcodmat INTEGER,
  empdatalt DATE,
  empcodusu INTEGER,
  emptipdes INTEGER,
  empcvnoti BOOLEAN,
  empultfdm DATE,
  em_fechamento BOOLEAN DEFAULT false,
  auditoriaconvenio INTEGER,
  auditoriadatahoraconvenio TIMESTAMP(0) WITHOUT TIME ZONE,
  auditoriadatahora TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT 'now'::text::timestamp(6) with time zone,
  auditoriaid INTEGER,
  empemprel REAL,
  empperpro REAL,
  empperdes REAL,
  empperfec REAL,
  empempre REAL,
  empultlot REAL,
  empauxnot REAL,
  empperprom REAL,
  empcanper BOOLEAN,
  empcodmeg INTEGER,
  id INTEGER NOT NULL,
  emfechamento BOOLEAN DEFAULT false,
  empfechamento INTEGER
);

COMMENT ON COLUMN fdw_pg15.stfil001.empflasel
IS 'Agrupa as empresas por 1,2,3... para dividir o acompanhamento do fechamento entre as meninas do convenio.';

COMMENT ON COLUMN fdw_pg15.stfil001.empempcan
IS 'Empresa bloqueada (processo que pode ser revertido)';

COMMENT ON COLUMN fdw_pg15.stfil001.emptipcon
IS 'Campo em branco, sendo utilizado apartir de 01/07/2011 para indicar conta corrente.
1 = Conta corrente
0 = Empresa normal';

COMMENT ON COLUMN fdw_pg15.stfil001.empemprel
IS 'Campo vazio passando a ser utilizado em 21/05/2010 para indicar uma chave de relacionamento entre as empresas. Por exemplo
todas as empresas Farma Ponte serão relacionadas com o id da filial matriz 21;';

COMMENT ON COLUMN fdw_pg15.stfil001.empcanper
IS 'Empresa cancelada permanentemente; (nao pode ser revertida)';

COMMENT ON COLUMN fdw_pg15.stfil001.emfechamento
IS 'indica se a empresa esta em processo de fechamento. Pode ser utilizado para detectar se ocorreu algum erro, pois ao final do fechamento o flag e alterado novamente.
True  => empresa em processo de fechamento
False => empresa não esta em processo de fechamento';

COMMENT ON COLUMN fdw_pg15.stfil001.empfechamento
IS 'Agrupa os pdvs no fechamento';

ALTER TABLE fdw_pg15.stfil001
  OWNER TO postgres;
  
INSERT INTO fdw_pg15.stfil001 ("ai", "controle", "empcodemp", "emprazsoc", "empbaiemp", "empmunemp", "empestemp", "empcepemp", "emptelemp", "empfaxemp", "empcgcemp", "empinsest", "emprazcom", "empdiafec", "empresfec", "empdiaent", "empfecele", "empgertit", "empgereti", "empdiapag", "empflasel", "empmsgcar", "empmsgca2", "empdiufec", "empdfufec", "empdifatu", "empdffatu", "empflafec", "empfunfec", "empsenfec", "emptipcob", "empimpnot", "emptipnot", "empbcolpg", "empbancob", "empflacar", "empempcan", "emptipcon", "empflapro", "empmespro", "empnotemp", "empobsemp", "empdatpag", "empconemp", "empccgemp", "empcstemp", "empcdaemp", "empemlemp", "empflaeti", "empbaicob", "empmuncob", "empestcob", "empcepcob", "emprelfec", "empdatinc", "emplimini", "emplimfin", "empflafdp", "empualemp", "empflapvc", "empcodmat", "empdatalt", "empcodusu", "emptipdes", "empcvnoti", "empultfdm", "em_fechamento", "auditoriaconvenio", "auditoriadatahoraconvenio", "auditoriadatahora", "auditoriaid", "empemprel", "empperpro", "empperdes", "empperfec", "empempre", "empultlot", "empauxnot", "empperprom", "empcanper", "empcodmeg", "id", "emfechamento", "empfechamento")
VALUES 
  (3619, NULL, 2373, E'HOTEL DO KK LTDA EPP', E'CENTRO', E'ITU', E'SP', E'13300083', E'(11) 4013-9000', E'(11) 4013-9005', E'71872634000182', E'387089289117', E'HOTEL KK', 19, NULL, 24, False, False, False, E'04 ', E'1', E'VENDA LIVRE', E'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, False, NULL, NULL, NULL, NULL, False, 0, NULL, NULL, E'ENCERRAMENTO PERIODO DE COMPRAS: 19\nVENDA LIVRE\n@@@\n\nGUSTAVO@HOTELKK.COM.BR\nFINANCEIRO@HOTELKK.COM.BR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, E'CENTRO', E'ITU', E'SP', E'13300083', NULL, E'2012-06-25', NULL, NULL, False, NULL, False, 2373, NULL, NULL, NULL, False, NULL, False, NULL, NULL, E'2020-10-07 13:41:10', 7685, 2373, NULL, NULL, NULL, NULL, NULL, NULL, NULL, False, 55361, 3087, False, 2373),
  (4689, NULL, 3231, E'IPANEMA DISTRIBUIDORA', E'IPANEMA DO MEIO', E'SOROCABA', E'SP', E'18052775', E'', E'', E'18728531000160', E'669779670114', E'IPANEMA ATACADISTA', 15, NULL, 20, NULL, NULL, NULL, E'03 ', E'1', E'VENDA LIVRE', E'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, False, 0, NULL, NULL, E'CAIXA POSTAL -1580\n\nENCERRAMENTO PERIODO DE COMPRAS: 15\n\n\nVENDA LIVRE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, E'IPANEMA DO MEIO', E'SOROCABA', E'SP', E'18052592', NULL, E'2017-05-26', NULL, NULL, NULL, NULL, NULL, 3231, NULL, NULL, NULL, NULL, NULL, False, NULL, NULL, E'2020-07-07 15:31:41', 2532, 921, NULL, NULL, NULL, NULL, NULL, NULL, NULL, False, NULL, 4071, False, 3231);