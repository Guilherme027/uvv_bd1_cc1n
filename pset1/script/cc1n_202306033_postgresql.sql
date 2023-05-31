/* O script refere-se ao primeiro pset da disciplina Design e Desenvolvimento de
Bancos de Dados I e tem como objetivo criar:
1) Um usuário onde cuja o nome será 'guilherme';
2) O banco de dados cuja o nome será 'uvv';
3) O esquema onde receberá o nome de 'lojas';
4) As tabelas e suas respectivas colunas;
5) Os relacionamentos entre as tabelas;
6) As checagens das colunas;
7) Os dados de cada tabela.
*/

/* Utilizaremos o postgresql como o
SGBD(Sistema de Gerenciamento de Banco de Dados)*/

-- Comando para apagar o banco de dados e o usuário, se os mesmos existem

DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS guilherme;

-- Comando para criar usuário guilherme dentro do postgresql.

CREATE USER guilherme WITH
CREATEDB
CREATEROLE
ENCRYPTED
PASSWORD
'pset';

-- Comando para criar o banco de dados “uvv”  e colocando o usuário “guilherme” como proprietario:

CREATE DATABASE uvv
WITH
OWNER =             guilherme
TEMPLATE =          template0
ENCODING =          "UTF8"
LC_COLLATE =        'pt_BR.UTF-8'
LC_CTYPE =          'pt_BR.UTF-8'
ALLOW_CONNECTIONS = true
;

/* Comando para entrar no banco de dados “uvv”
com o usuário "guilherme" sem precisa
digitar a senha */

\c "dbname=uvv user=guilherme password=pset"

/* Comando para criar o esquema "lojas" do
banco de dados "uvv" e autorizando
o usuário a utilizar o esquema.*/

CREATE SCHEMA lojas AUTHORIZATION guilherme;

-- Comando para alterar o esquema padrão para lojas:

ALTER USER guilherme
SET search_path TO lojas, "$user", public;

/* A partir de agora:
 1) Criará as tabelas do banco de dados "uvv";
 2) Adicionará as devidas colunas nas suas respectivas tabelas;
 3) Adicionará os comentários das tabelas e colunas;
 4) Criará os relacionamentos entre as tabelas;
 5) Adicionará as restrições de checagem se for preciso;
 6) E adicionará os dados.
 */

-- Comando para criar a tabela "produtos":
CREATE TABLE lojas.produtos (
produto_id                   NUMERIC (38)  NOT NULL,
nome                         VARCHAR (255) NOT NULL,
preco_unitario               NUMERIC (10,2)        ,
detalhes                     BYTEA                 ,
imagem                       BYTEA                 ,
imagem_mime_type             VARCHAR (512)         ,
imagem_arquivo               VARCHAR (512)         ,
imagem_charset               VARCHAR (512)         ,
imagem_ultima_atualizacao    DATE                  ,
CONSTRAINT pk_produtos
PRIMARY KEY (produto_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna
"preco_unitario" que poderá só adicionar os preços acima de 0 */

ALTER TABLE lojas.produtos
ADD CONSTRAINT ck_preco_unitario_produtos
CHECK (preco_unitario > 0);

COMMENT ON TABLE lojas.produtos                            IS
'A tabela "produtos" armazenará
dados dos devidos produtos.'
;

COMMENT ON COLUMN lojas.produtos.produto_id                IS
'A coluna "produto_id" será um identificador
único da tabela "produtos", onde mostrar
á um id único de cada produto.'
;

COMMENT ON COLUMN lojas.produtos.nome                      IS
'A coluna "nome" armazenará nomes
dos  produtos á venda.'
;

COMMENT ON COLUMN lojas.produtos.preco_unitario            IS
'A coluna "preco_unitario" armazenará
os preços de cada produto.'
;

COMMENT ON COLUMN lojas.produtos.detalhes                  IS
'A coluna "detalhes" armazenará os detalhes de
cada um dos produtos, ou seja, será bem
detalhado nas informações de cada produto'
;

COMMENT ON COLUMN lojas.produtos.imagem                    IS
'A coluna "imagem" armazenará e organizará
as imagens de cada produto.'
;

COMMENT ON COLUMN lojas.produtos.imagem_mime_type          IS
'A coluna "imagem_mime_type", irá armazenar
o tipo de arquivo de cada produto.'
;

COMMENT ON COLUMN lojas.produtos.imagem_arquivo            IS
'A coluna "imagem_arquivo, armazenará
o arquivo digitalizado.'
;

COMMENT ON COLUMN lojas.produtos.imagem_charset            IS
'A coluna "imagem_charset" irá armazenar os
caracteres para exibição dos produtos'
;

COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS
'A coluna "imagem_ultima_atualizacao",
armazenará as datas das ultimas atualizações
da imagem de cada produto.'
;

-- Comando para criar a tabela "lojas":
CREATE TABLE lojas.lojas (
loja_id                     NUMERIC (38)  NOT NULL,
nome                        VARCHAR (255) NOT NULL,
endereco_web                VARCHAR (100)         ,
endereco_fisico             VARCHAR (512)         ,
latitude                    NUMERIC               ,
longitude                   NUMERIC               ,
logo                        BYTEA                 ,
logo_mime_type              VARCHAR (512)         ,
logo_arquivo                VARCHAR(512)          ,
logo_charset                VARCHAR(512)          ,
logo_ultima_atualizacao     DATE                  ,
CONSTRAINT pk_lojas
PRIMARY KEY (loja_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para as colunas
"endereco_fisico" e "endereco_web" onde um dos dois não pode ser nulo. */

ALTER TABLE lojas.lojas
ADD CONSTRAINT ck_endereco_fisico_web_lojas
CHECK (endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);

COMMENT ON TABLE lojas.lojas                  IS
'A tabela "lojas" será um meio utilizado
para coloca dados referente as lojas
físicas e onlines, como endereço,
latitude, longitude e etc.'
;

COMMENT ON COLUMN lojas.lojas.loja_id         IS
'A coluna "loja_id" será um identificador
único para a tabela "lojas"
onde será uma Primary Key.'
;

COMMENT ON COLUMN lojas.lojas.nome            IS
'A coluna "nome" armazenará
os nomes das lojas.'
;

COMMENT ON COLUMN lojas.lojas.endereco_web    IS
'A coluna "endereco_web" armazenará URLs que são
considerados endereços na internet, para achar a devida loja.'
;

COMMENT ON COLUMN lojas.lojas.endereco_fisico IS
'A coluna "endereco_fisico" armazenará
os endereços físicos das lojas, ou seja,
mostrará onde a devida loja se localiza.'
;

COMMENT ON COLUMN lojas.lojas.latitude        IS
'A coluna "latitude" armazenará" as
latitudes de cada uma das lojas.'
;

COMMENT ON COLUMN lojas.lojas.longitude       IS
'A coluna "longitude" armazenará a
longitude de cada uma das lojas.'
;

COMMENT ON COLUMN lojas.lojas.logo            IS
'A coluna "logo" armazenará as
logos de cada uma da lojas.'
;

COMMENT ON COLUMN lojas.lojas.logo_mime_type  IS
'A coluna "logo_mime_type", irá armazenar e
mostrar o tipo de arquivo de cada logo'
;

COMMENT ON COLUMN lojas.lojas.logo_arquivo    IS
'A coluna "logo_arquivo",
armazenará a imagem da logo digitalmente.'
;

COMMENT ON COLUMN lojas.lojas.logo_charset    IS
'A coluna "logo_charset",
armazenará os caracteres para a exibição de cada logo.'
;

COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS
'A coluna "logo_ultima_atualizacao",
armazenará as datas das ultimas atualizações.';

-- Comando para criar a tabela "estoques":
CREATE TABLE lojas.estoques (
estoque_id                  NUMERIC (38) NOT NULL,
loja_id                     NUMERIC (38) NOT NULL,
produto_id                  NUMERIC (38) NOT NULL,
quantidade                  NUMERIC (38) NOT NULL,
CONSTRAINT pk_estoques
PRIMARY KEY (estoque_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna
"quantidade" que poderá só adicionar a quantidade acima de 0.*/

ALTER TABLE lojas.estoques
ADD CONSTRAINT ck_quantidade_estoques
CHECK (quantidade > 0);

COMMENT ON TABLE lojas.estoques IS
'A coluna "estoques" armazenará os
produtos que estão localizados no estoque.'
;

COMMENT ON COLUMN lojas.estoques.estoque_id IS
'A coluna "estoque" armazenará e informará
o id de cada estoque, onde será a
Primary Key da tabela "estoques"'
;

COMMENT ON COLUMN lojas.estoques.loja_id IS
'A coluna "loja_id" é uma
PK(primary key)da tabela "lojas"
e se tornou uma FK(foreign key)
da tabela "estoques" .'
;

COMMENT ON COLUMN lojas.estoques.produto_id IS
'A coluna "produto_id" é uma PK
(primary key) da tabela "produtos"
e se tornou uma FK(foreign key) da tabela "envios" .'
;

COMMENT ON COLUMN lojas.estoques.quantidade IS
'A coluna "quantidade" armazenará e informará a
quantidade de produtos que estão em estoque.'
;

-- Comando para criar a tabela "clientes":
CREATE TABLE lojas.clientes (
cliente_id                  NUMERIC (38)  NOT NULL,
nome                        VARCHAR (255) NOT NULL,
email                       VARCHAR (255) NOT NULL,
telefone1                   VARCHAR (20)          ,
telefone2                   VARCHAR (20)          ,
telefone3                   VARCHAR (20)          ,
CONSTRAINT pk_clientes
PRIMARY KEY (cliente_id)
);

COMMENT ON TABLE lojas.clientes IS
'A tabela "clientes" identificará os
clientes e o meios de contato com os mesmo.'
;

COMMENT ON COLUMN lojas.clientes.cliente_id IS
'A primeira coluna receberá o nome "cliente_id"
onde será um meio de organizar e localizar os clientes,
por ela será a "Primary Key", ou seja,
chave primária que recebe esse nome,
pois é o identificador único dessa tabela.'
;

COMMENT ON COLUMN lojas.clientes.nome IS
'A coluna "nome" será um meio de organizar e
identificar os clientes, onde será de muita utilidade.'
;

COMMENT ON COLUMN lojas.clientes.email IS
'A coluna "email" irá aparecer o email dos
devidos clientes cadastrados no banco de dados.'
;

COMMENT ON COLUMN lojas.clientes.telefone1 IS
'A coluna "telefone" será um meio para
entrar em contato se necessário com o cliente,
não será obrigatório, mas será de suma importância.'
;

COMMENT ON COLUMN lojas.clientes.telefone2 IS
'A coluna "telefone2" terá a mesma definição que a
coluna "telefone1" , mas dará a possibilidade
do cliente adicionar mais um número de telefone em vez de um único'
;

COMMENT ON COLUMN lojas.clientes.telefone3 IS
'A coluna "telefone3" terá a mesma definição
que as demais colunas com o ínicio "telefone",
onde disponibilizará para o cliente adicionar
mais um número de telefone.';

-- Comando para criar a tabela "envios":
CREATE TABLE lojas.envios (
envio_id                    NUMERIC (38)  NOT NULL,
loja_id                     NUMERIC (38)  NOT NULL,
cliente_id                  NUMERIC (38)  NOT NULL,
endereco_entrega            VARCHAR (512) NOT NULL,
status                      VARCHAR (15)  NOT NULL,
CONSTRAINT pk_envios
PRIMARY KEY (envio_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna "status"
que poderá só adicionar os dados com os termos "criado, enviado,
transito, entregue".*/

ALTER TABLE lojas.envios
ADD CONSTRAINT ck_status_envios
CHECK (status in
                ('criado'  ,
                 'enviado' ,
                 'transito',
                 'entregue')
                );

COMMENT ON TABLE lojas.envios IS
'A tabela "envios" mostrará informações
sobre o envios dos devidos pedidos efetuados.'
;

COMMENT ON COLUMN lojas.envios.envio_id IS
'A coluna "envio_id" armazenará e informará o id
de cada envio feito ou que será feito,
ela será uma Primary Key da tabela envios.'
;

COMMENT ON COLUMN lojas.envios.loja_id IS
'A coluna "loja_id" é uma PK(primary key) da tabela "lojas"
e se tornou uma FK(foreign key) da tabela "envios" .'
;

COMMENT ON COLUMN lojas.envios.cliente_id IS
'A coluna "cliente_id" é uma PK(primary key) da tabela "clientes"
e se tornou uma FK(foreign key) da tabela "envios" .'
;

COMMENT ON COLUMN lojas.envios.endereco_entrega IS
'A coluna "endereco_entrega" armazenrá
o endereço de cada entrega que foi feita ou será feita.'
;

COMMENT ON COLUMN lojas.envios.status IS
'A coluna "status" armazenará e
informará o estágio dos envios em tempo real.'
;

-- Comando para criar a tabela "pedidos":
CREATE TABLE lojas.pedidos (
pedido_id                   NUMERIC (38) NOT NULL,
cliente_id                  NUMERIC (38) NOT NULL,
loja_id                     NUMERIC (38) NOT NULL,
data_hora                   TIMESTAMP    NOT NULL,
status                      VARCHAR (15) NOT NULL,
CONSTRAINT pk_pedidos
PRIMARY KEY (pedido_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna "status"
que poderá só adicionar os dados com os termos "cancelado, completo,
aberto, pago, reembolsado, enviado".*/

ALTER TABLE lojas.pedidos
ADD CONSTRAINT ck_status_pedidos
CHECK (status in
                 ('cancelado'  ,
                  'completo'   ,
                  'aberto'     ,
                  'pago'       ,
                  'reembolsado',
                  'enviado')
                  );

COMMENT ON TABLE lojas.pedidos IS
'Na tabela "pedidos" identificará os
pedidos dos devidos clientes e
será armazenado no banco de dados.'
;

COMMENT ON COLUMN lojas.pedidos.pedido_id IS
'A coluna "pedido_id" será um meio para
identificar os pedidos, sendo um  único
para cada um pedido, ele será uma "primary key",
onde será o único identificador
dessa tabela que não pode ser repetido.'
;

COMMENT ON COLUMN lojas.pedidos.cliente_id IS
'A coluna "cliente_id" é uma
PK(primary key)da tabela "cliente"
e se tornou uma FK(foreign key) da tabela "pedidos" .'
;

COMMENT ON COLUMN lojas.pedidos.loja_id IS
'A coluna "loja_id" é uma
PK(primary key) da tabela "lojas"
e se tornou uma FK(foreign key)
da tabela "pedidos" .'
;

COMMENT ON COLUMN lojas.pedidos.data_hora IS
'A coluna "data_hora" mostrará a data e hora
que foi efetuado o pedido de um certo produto.'
;

COMMENT ON COLUMN lojas.pedidos.status IS
'A coluna "status" mostrará de
forma fácil a situação atual de qualquer pedido.'
;

-- Comando para criar a tabela "pedidos_itens":
CREATE TABLE lojas.pedidos_itens (
pedido_id                   NUMERIC (38)   NOT NULL,
produto_id                  NUMERIC (38)   NOT NULL,
numero_da_linha             NUMERIC (38)   NOT NULL,
preco_unitario              NUMERIC (10,2) NOT NULL,
quantidade                  NUMERIC (38)   NOT NULL,
envio_id                    NUMERIC(38)            ,
CONSTRAINT pk_pedidos_itens
PRIMARY KEY (pedido_id, produto_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna
"preco_unitario" e "quantidade"  que poderá só adicionar os preços
e a quantidade acima de 0. */

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT ck_preco_unitario_pedidos_itens
CHECK (preco_unitario > 0);

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT ck_quantidade_pedidos_itens
CHECK (quantidade > 0);

COMMENT ON TABLE lojas.pedidos_itens IS
'A tabela "pedidos_itens" armazenará e
mostrará os itens que foram pedidos.'
;

COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS
'A coluna "pedido_id" é uma
PK(primary key) da tabela "pedidos"
e se tornou uma PFK(primary-foreign key)
da tabela "pedidos_itens" .'
;

COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS
'A coluna "produto_id" é uma
PK(primary key) da tabela "produtos"
e se tornou uma PFK(primary-foreign key)
da tabela "pedidos_itens".'
;

COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS
'A coluna "numero_da_linha" será usado como
identificador sequencial para cada item registrado,
armazenará sequencialmente e organizadamente cada item.'
;

COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS
'A coluna "preco_unitario" mostrará o
preço de cada um dos produtos.'
;

COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS
'A coluna "quantidade" armazenará e informará a quantidade
de quantos itens estão em estoque.'
;

COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS
'A coluna "envio_id" é uma
PK(primary key) da tabela "envios"
e se tornou uma FK(foreign key)
da tabela "pedidos_itens".'
;

/* Comando que criar as FK(FOREIGN KEY), ou seja,
os relacionamentos entre as tabelas seja identificados
ou não identificados.*/


ALTER TABLE          lojas.pedidos_itens
ADD CONSTRAINT       pfk_produtos_pedidos_itens
FOREIGN KEY          (produto_id)
REFERENCES           lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE          lojas.estoques
ADD CONSTRAINT       fk_produtos_estoques
FOREIGN KEY          (produto_id)
REFERENCES           lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE          lojas.pedidos
ADD CONSTRAINT       fk_lojas_pedidos
FOREIGN KEY          (loja_id)
REFERENCES           lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE          lojas.envios
ADD CONSTRAINT       fk_lojas_envios
FOREIGN KEY          (loja_id)
REFERENCES           lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE          lojas.estoques
ADD CONSTRAINT       fk_lojas_estoques
FOREIGN KEY          (loja_id)
REFERENCES           lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE          lojas.pedidos
ADD CONSTRAINT       fk_clientes_pedidos
FOREIGN KEY          (cliente_id)
REFERENCES           lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE          lojas.envios
ADD CONSTRAINT       fk_clientes_envios
FOREIGN KEY          (cliente_id)
REFERENCES           lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE          lojas.pedidos_itens
ADD CONSTRAINT       fk_envios_pedidos_itens
FOREIGN KEY          (envio_id)
REFERENCES           lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE          lojas.pedidos_itens
ADD CONSTRAINT       pfk_pedidos_pedidos_itens
FOREIGN KEY          (pedido_id)
REFERENCES           lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
