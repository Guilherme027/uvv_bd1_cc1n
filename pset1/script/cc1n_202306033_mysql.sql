/* O script refere-se ao primeiro pset da disciplina Design e Desenvolvimento de
Bancos de Dados I e tem como objetivo criar:
1) Um usuário onde cuja o nome será 'guilherme';
2) O banco de dados cuja o nome será 'uvv';
3) As tabelas e suas respectivas colunas;
4) Os relacionamentos entre as tabelas;
5) As checagens das colunas;
8) Os dados de cada tabela.
*/
-- Utilizaremos o mysql(MariaDB)

 DROP DATABASE IF EXISTS uvv;
 DROP USER IF EXISTS 'guilherme'@'localhost';

/*  Comando para criar o bancos de dados e o usuário
    e dando permissão ao usuário, e colocando o mesmo
    como proprietário do bancos de dados.*/
    

CREATE USER 'guilherme'@'localhost' IDENTIFIED BY 'pset';
CREATE DATABASE uvv;
GRANT all ON uvv.* TO 'guilherme'@'localhost';
FLUSH PRIVILEGES;

-- Comando para entrar no banco de dados "uvv":

USE uvv

/* Agora iremos:
1) Criar as tabelas e suas colunas;
2) Adicionará os comentários das tabelas
   e das suas respectivas colunas;
3) Criará os relacionamentos entre as tabelas;
4) Adicionará os dados das tabelas;*/

CREATE TABLE produtos (
produto_id                NUMERIC (38)  NOT NULL ,
nome                      VARCHAR (255) NOT NULL ,
preco_unitario            NUMERIC (10,2)         ,
detalhes                  LONGBLOB               ,
imagem                    LONGBLOB               ,
imagem_mime_type          VARCHAR (512)          ,
imagem_arquivo            VARCHAR (512)          ,
imagem_charset            VARCHAR (512)          ,
imagem_ultima_atualizacao DATE                   ,
PRIMARY KEY (produto_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna
"preco_unitario" que poderá só adicionar os preços acima de 0 */

ALTER TABLE produtos
ADD CONSTRAINT ck_preco_unitario_produtos
CHECK (preco_unitario > 0);

ALTER TABLE produtos COMMENT
'A tabela "produtos" armazenará
dados dos devidos produtos.';

ALTER TABLE produtos MODIFY COLUMN produto_id NUMERIC(38) COMMENT
'A coluna "produto_id" será um identificador único
da tabela "produtos", onde mostrará
um id único de cada produto.';

ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(255) COMMENT
'A coluna "nome" armazenará
nomes dos  produtos á venda.';

ALTER TABLE produtos MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT
'A coluna "preco_unitario" armazenará
os preços de cada produto.';

ALTER TABLE produtos MODIFY COLUMN detalhes BLOB COMMENT
'A coluna "detalhes" armazenará os detalhes de
cada um dos produtos, ou seja, será bem detalhado
nas informações de cada produto';

ALTER TABLE produtos MODIFY COLUMN imagem BLOB COMMENT
'A coluna "imagem"armazenará e
organizará as imagens de cada produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_mime_type VARCHAR(512) COMMENT
'A coluna "imagem_mime_type", irá armazenar
o tipo de arquivo de cada produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_arquivo VARCHAR(512) COMMENT
'A coluna "imagem_arquivo,
armazenará o arquivo digitalizado.';

ALTER TABLE produtos MODIFY COLUMN imagem_charset VARCHAR(512) COMMENT
'A coluna "imagem_charset" irá armazenar
os caracteres para exibição dos produtos';

ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao DATE COMMENT
'A coluna "imagem_ultima_atualizacao",
armazenará as datas das ultimas atualizações
da imagem de cada produto.';


CREATE TABLE lojas (
loja_id                 NUMERIC (38)  NOT NULL ,
nome                    VARCHAR (255) NOT NULL ,
endereco_web            VARCHAR (100)          ,
endereco_fisico         VARCHAR (512)          ,
latitude                NUMERIC                ,
longitude               NUMERIC                ,
logo                    LONGBLOB               ,
logo_mime_type          VARCHAR (512)          ,
logo_arquivo            VARCHAR (512)          ,
logo_charset            VARCHAR (512)          ,
logo_ultima_atualizacao DATE                   ,
PRIMARY KEY (loja_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para as colunas
"endereco_fisico" e "endereco_web" onde um dos dois não pode ser nulo. */

ALTER TABLE lojas
ADD CONSTRAINT ck_endereco_fisico_web_lojas
CHECK (endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);

ALTER TABLE lojas COMMENT
'A tabela "lojas" será um meio utilizado
para coloca dados referente as lojas
físicas e onlines, como endereço,
latitude, longitude e etc.';

ALTER TABLE lojas MODIFY COLUMN loja_id NUMERIC(38) COMMENT
'A coluna "loja_id" será um identificador único
para a tabela "lojas" onde será
uma Primary Key.';

ALTER TABLE lojas MODIFY COLUMN nome VARCHAR(255) COMMENT
'A coluna "nome" armazenará
os nomes das lojas.';

ALTER TABLE lojas MODIFY COLUMN endereco_web VARCHAR(100) COMMENT
'A coluna "endereco_web" armazenará URLs
que são considerados endereços na
internet, para achar a devida loja.';

ALTER TABLE lojas MODIFY COLUMN endereco_fisico VARCHAR(512) COMMENT
'A coluna "endereco_fisico" armazenará os endereços
físicos das lojas, ou seja, mostrará onde
a devida loja se localiza.';

ALTER TABLE lojas MODIFY COLUMN latitude NUMERIC COMMENT
'A coluna "latitude" armazenará"
as latitudes de cada uma das lojas.';

ALTER TABLE lojas MODIFY COLUMN longitude NUMERIC COMMENT
'A coluna "longitude" armazenará
a longitude de cada uma das lojas.';

ALTER TABLE lojas MODIFY COLUMN logo BLOB COMMENT
'A coluna "logo" armazenará
as logos de cada uma da lojas.';

ALTER TABLE lojas MODIFY COLUMN logo_mime_type VARCHAR(512) COMMENT
'A coluna "logo_mime_type", irá armazenar
e mostrar o tipo de arquivo de cada logo.';

ALTER TABLE lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT
'A coluna "logo_arquivo", armazenará
a imagem da logo digitalmente.';

ALTER TABLE lojas MODIFY COLUMN logo_charset VARCHAR(512) COMMENT
'A coluna "logo_charset", armazenará os
caracteres para a exibição de cada logo.';

ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao DATE COMMENT
'A coluna "logo_ultima_atualizacao",
armazenará as datas das ultimas atualizações.';


CREATE TABLE estoques (
estoque_id          NUMERIC(38) NOT NULL,
loja_id             NUMERIC(38) NOT NULL,
produto_id          NUMERIC(38) NOT NULL,
quantidade          NUMERIC(38) NOT NULL,
PRIMARY KEY (estoque_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna
"quantidade" que poderá só adicionar a quantidade acima de 0.*/

ALTER TABLE estoques
ADD CONSTRAINT ck_quantidade_estoques
CHECK (quantidade > 0);

ALTER TABLE estoques COMMENT
'A coluna "estoques" armazenará os produtos
que estão localizados no estoque.';

ALTER TABLE estoques MODIFY COLUMN estoque_id NUMERIC(38) COMMENT
'A coluna "estoque" armazenará e informará
o id de cada estoque, onde será a
Primary Key da tabela "estoques"';

ALTER TABLE estoques MODIFY COLUMN loja_id NUMERIC(38) COMMENT
'A coluna "loja_id" será um identificador único
para a tabela "lojas" onde será uma Primary Key.';

ALTER TABLE estoques MODIFY COLUMN produto_id NUMERIC(38) COMMENT
'A coluna "produto_id" será um identificador
único da tabela "produtos",
onde mostrará um id único de cada produto.';

ALTER TABLE estoques MODIFY COLUMN quantidade NUMERIC(38) COMMENT
'A coluna "quantidade" armazenará e informará
a quantidade de produtos que estão em estoque.';


CREATE TABLE clientes (
cliente_id            NUMERIC(38)  NOT NULL,
nome                  VARCHAR(255) NOT NULL,
email                 VARCHAR(255) NOT NULL,
telefone1             VARCHAR(20)          ,
telefone2             VARCHAR(20)          ,
telefone3             VARCHAR(20)          ,
PRIMARY KEY (cliente_id)
);

ALTER TABLE clientes COMMENT
'A tabela "clientes" identificará
os clientes e o meios de contato com os mesmo.';

ALTER TABLE clientes MODIFY COLUMN cliente_id NUMERIC(38) COMMENT
'A primeira coluna receberá o nome "cliente_id" onde
será um meio de organizar e localizar os clientes,
por ela será a "Primary Key", ou seja,
chave primária que recebe esse nome,
pois é o identificador único dessa tabela.';

ALTER TABLE clientes MODIFY COLUMN nome VARCHAR(255) COMMENT
'A coluna "nome" será um meio de organizar
e identificar os clientes, onde
será de muita utilidade.';

ALTER TABLE clientes MODIFY COLUMN email VARCHAR(255) COMMENT
'A coluna "email" irá aparecer o email
dos devidos clientes cadastrados no banco de dados.';

ALTER TABLE clientes MODIFY COLUMN telefone1 VARCHAR(20) COMMENT
'A coluna "telefone" será um meio para entrar em
contato se necessário com o cliente, não será
obrigatório, mas será de suma importância.';

ALTER TABLE clientes MODIFY COLUMN telefone2 VARCHAR(20) COMMENT
'A coluna "telefone2" terá a mesma definição
que a coluna "telefone1" , mas dará a
possibilidade do cliente adicionar mais
um número de telefone em vez de um único';

ALTER TABLE clientes MODIFY COLUMN telefone3 VARCHAR(20) COMMENT
'A coluna "telefone3" terá a mesma definição que as
demais colunas com o ínicio "telefone",
onde disponibilizará para o
cliente adicionar mais um número de telefone.';


CREATE TABLE envios (
envio_id             NUMERIC(38)  NOT NULL,
loja_id              NUMERIC(38)  NOT NULL,
cliente_id           NUMERIC(38)  NOT NULL,
endereco_entrega     VARCHAR(512) NOT NULL,
status               VARCHAR(15)  NOT NULL,
PRIMARY KEY (envio_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna "status"
que poderá só adicionar os dados com os termos "criado, enviado,
transito, entregue".*/

ALTER TABLE envios
ADD CONSTRAINT ck_status_envios
CHECK (status in
                ('criado'  ,
                 'enviado' ,
                 'transito',
                 'entregue')
                );

ALTER TABLE envios COMMENT
'A tabela "envios" mostrará informações
sobre o envios dos devidos pedidos efetuados.';

ALTER TABLE envios MODIFY COLUMN envio_id NUMERIC(38) COMMENT
'A coluna "envio_id" armazenará e informará
o id de cada envio feito ou que será feito,
ela será uma Primary Key da tabela envios.';

ALTER TABLE envios MODIFY COLUMN loja_id NUMERIC(38) COMMENT
'A coluna "loja_id" será um identificador
único para a tabela "lojas" onde será uma Primary Key.';

ALTER TABLE envios MODIFY COLUMN cliente_id NUMERIC(38) COMMENT
'A primeira coluna receberá o nome "cliente_id"
onde será um meio de organizar e localizar os clientes,
por ela será a "Primary Key", ou seja,
chave primária que recebe esse nome,
pois é o identificador único dessa tabela.';

ALTER TABLE envios MODIFY COLUMN endereco_entrega VARCHAR(512) COMMENT
'A coluna "endereco_entrega" armazenrá o endereço
de cada entrega que foi feita ou será feita.';

ALTER TABLE envios MODIFY COLUMN status VARCHAR(15) COMMENT
'A coluna "status" armazenará e informará o
estágio dos envios em tempo real.';


CREATE TABLE pedidos (
pedido_id             NUMERIC(38)  NOT NULL,
cliente_id            NUMERIC(38)  NOT NULL,
loja_id               NUMERIC(38)  NOT NULL,
data_hora             DATETIME     NOT NULL,
status                VARCHAR(15)  NOT NULL,
PRIMARY KEY (pedido_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna "status"
que poderá só adicionar os dados com os termos "cancelado, completo,
aberto, pago, reembolsado, enviado".*/

ALTER TABLE pedidos
ADD CONSTRAINT ck_status_pedidos
CHECK (status in
                 ('cancelado'  ,
                  'completo'   ,
                  'aberto'     ,
                  'pago'       ,
                  'reembolsado',
                  'enviado')
                  );

ALTER TABLE pedidos COMMENT
'Na tabela "pedidos" identificará os
pedidos dos devidos clientes e
será armazenado no banco de dados.';

ALTER TABLE pedidos MODIFY COLUMN pedido_id NUMERIC(38) COMMENT
'A coluna "pedido_id" será um meio para identificar os pedidos,
sendo um  único para cada um pedido, ele
será uma "primary key", onde será o único
identificador  dessa tabela que não pode ser repetido.';

ALTER TABLE pedidos MODIFY COLUMN cliente_id NUMERIC(38) COMMENT
'A primeira coluna receberá o nome "cliente_id" onde será um meio
de organizar e localizar os clientes, por ela será a
"Primary Key", ou seja, chave primária que recebe esse nome,
pois é o identificador único dessa tabela.';

ALTER TABLE pedidos MODIFY COLUMN loja_id NUMERIC(38) COMMENT
'A coluna "loja_id" será um identificador
único para a tabela "lojas" onde será uma Primary Key.';

ALTER TABLE pedidos MODIFY COLUMN data_hora TIMESTAMP COMMENT
'A coluna "data_hora" mostrará a data e
hora que foi efetuado o pedido de um certo produto.';

ALTER TABLE pedidos MODIFY COLUMN status VARCHAR(15) COMMENT
'A coluna "status" mostrará de forma
fácil a situação atual de qualquer pedido.';


CREATE TABLE pedidos_itens (
pedido_id                 NUMERIC(38)   NOT NULL,
produto_id                NUMERIC(38)   NOT NULL,
numero_da_linha           NUMERIC(38)   NOT NULL,
preco_unitario            DECIMAL(10,2) NOT NULL,
quantidade                NUMERIC(38)   NOT NULL,
envio_id                  NUMERIC(38)           ,
PRIMARY KEY (pedido_id, produto_id)
);

/* Adicionando uma CHECK CONSTRAINT, ou seja, uma condição lógica 
onde terá uma restrição de checagem, que vai ser para a coluna
"preco_unitario" e "quantidade"  que poderá só adicionar os preços
e a quantidade acima de 0. */

ALTER TABLE pedidos_itens
ADD CONSTRAINT ck_preco_unitario_pedidos_itens
CHECK (preco_unitario > 0);

ALTER TABLE pedidos_itens
ADD CONSTRAINT ck_quantidade_pedidos_itens
CHECK (quantidade > 0);


ALTER TABLE pedidos_itens COMMENT
'A tabela "pedidos_itens" armazenará
e mostrará os itens que foram pedidos.';

ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id NUMERIC(38) COMMENT
'A coluna "pedido_id" será um meio para identificar os pedidos,
sendo um  único para cada um pedido, ele será uma
"primary key", onde será o único identificador
dessa tabela que não pode ser repetido.';

ALTER TABLE pedidos_itens MODIFY COLUMN produto_id NUMERIC(38) COMMENT
'A coluna "produto_id" será
um identificador único da tabela "produtos",
onde mostrará um id único de cada produto.';

ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha NUMERIC(38) COMMENT
'A coluna "numero_da_linha" será usado como
identificador sequencial para cada item registrado,
armazenará sequencialmente e organizadamente cada item.';

ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario DECIMAL(10, 2) COMMENT
'A coluna "preco_unitario" mostrará o
preço de cada um dos produtos.';

ALTER TABLE pedidos_itens MODIFY COLUMN quantidade NUMERIC(38) COMMENT
'A coluna "quantidade" armazenará e informará a
quantidade de quantos itens estão em estoque.';

ALTER TABLE pedidos_itens MODIFY COLUMN envio_id NUMERIC(38) COMMENT
'A coluna "envio_id" armazenará e informará o
id de cada envio feito ou que será feito,
ela será uma Primary Key da tabela envios.';


ALTER TABLE pedidos_itens
ADD CONSTRAINT pfk_produtos_pedidos_itens
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE estoques
ADD CONSTRAINT fk_produtos_estoques
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos
ADD CONSTRAINT fk_lojas_pedidos
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios
ADD CONSTRAINT fk_lojas_envios
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE estoques
ADD CONSTRAINT fk_lojas_estoques
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos
ADD CONSTRAINT fk_clientes_pedidos
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios
ADD CONSTRAINT fk_clientes_envios
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens
ADD CONSTRAINT fk_envios_pedidos_itens
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens
ADD CONSTRAINT fk_pedidos_pedidos_itens 
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
