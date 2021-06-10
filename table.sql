CREATE TABLE IF NOT EXISTS Produto (
    ean numeric PRIMARY KEY,
    nome varchar (50) UNIQUE NOT NULL,
    categoria varchar (50) NOT NULL, 
    marca varchar (50) NOT NULL,
    descricao text
);

CREATE TABLE IF NOT EXISTS Transportadora (
    id serial PRIMARY KEY, 
    cnpj varchar(14) UNIQUE NOT NULL, 
    nome varchar(50) NOT NULL, 
    endereco varchar(500) NOT NULL, 
    telefone varchar(20) NOT NULL, 
    cidades text
);

-- <Usuário>
CREATE TABLE IF NOT EXISTS Usuario (
    id serial PRIMARY KEY, 
    email varchar(50) UNIQUE NOT NULL, 
    senha varchar(50) NOT NULL, 
    nome varchar(50) NOT NULL, 
    telefone varchar(20), 
    dataNascimento date NOT NULL, 
    endereco varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Consumidor(
    usuarioID serial PRIMARY KEY, 
    cpf varchar(11) UNIQUE NOT NULL, 
    cartoes text,
    FOREIGN KEY (usuarioID) REFERENCES usuario (id)
);

CREATE TABLE IF NOT EXISTS Vendedor(
    usuarioID serial PRIMARY KEY,
    FOREIGN KEY (usuarioID) REFERENCES usuario (id)
);

CREATE TABLE IF NOT EXISTS PessoaFisica (
    usuarioID serial PRIMARY KEY, 
    cpf varchar(11) UNIQUE NOT NULL,
    FOREIGN KEY (usuarioID) REFERENCES vendedor (usuarioID)
);

CREATE TABLE IF NOT EXISTS PessoaJuridica (
    usuarioID serial PRIMARY KEY, 
    cnpj varchar(14) UNIQUE NOT NULL, 
    razaoSocial varchar(50) NOT NULL,
    FOREIGN KEY (usuarioID) REFERENCES vendedor (usuarioID)
);
-- </Usuário>

CREATE TABLE IF NOT EXISTS Anuncio (
    id serial PRIMARY KEY, 
    dataPublicacao timestamp NOT NULL, 
    produtoEan numeric NOT NULL,
    usuarioID integer NOT NULL,
    FOREIGN KEY (produtoEan) REFERENCES produto (ean),
    FOREIGN KEY (usuarioID) REFERENCES vendedor (usuarioID)
);

CREATE TABLE IF NOT EXISTS Unidade (
    anuncioID integer PRIMARY KEY, 
    preco float NOT NULL,
    estoque int NOT NULL,
    desconto float, 
    status varchar,
    CHECK(status IN ('Disponivel', 'Pouco estoque', 'Nao disponivel')),
    FOREIGN KEY (anuncioID) REFERENCES anuncio (id)
);

CREATE TABLE IF NOT EXISTS Lote (
    anuncioID integer PRIMARY KEY, 
    preco float NOT NULL, 
    quantidadeLote int NOT NULL, 
    estoque int NOT NULL, 
    desconto float, 
    status varchar,
    CHECK(status IN ('Disponivel', 'Pouco estoque', 'Nao disponivel')),
    FOREIGN KEY (anuncioID) REFERENCES anuncio (id)
);

CREATE TABLE IF NOT EXISTS Avaliacao (
    id serial PRIMARY KEY, 
    nota integer NOT NULL, 
    revisao text NOT NULL, 
    midia text, 
    DataPublicacao timestamp NOT NULL, 
    usuarioID integer NOT NULL, 
    anuncioID integer NOT NULL,
    FOREIGN KEY (usuarioID) REFERENCES usuario (id),
    FOREIGN KEY (anuncioID) REFERENCES anuncio (id)
);

CREATE TABLE IF NOT EXISTS Cupom (
    id serial PRIMARY KEY, 
    nome varchar(50) NOT NULL, 
    duracao timestamp, 
    produtoEan integer, 
    usuarioID integer NOT NULL,
    FOREIGN KEY (usuarioID) REFERENCES pessoajuridica (usuarioID),
    FOREIGN KEY (produtoEan) REFERENCES produto (ean)
);

CREATE TABLE IF NOT EXISTS Porcentagem (
    cupomID serial PRIMARY KEY, 
    desconto float NOT NULL,
    FOREIGN KEY (cupomID) REFERENCES cupom (id)
);

CREATE TABLE IF NOT EXISTS Fixo (
    cupomID serial PRIMARY KEY,
    desconto float NOT NULL,
    FOREIGN KEY (cupomID) REFERENCES cupom (id)
);

CREATE TABLE IF NOT EXISTS CuponsUsuario (
    id integer,
    usuarioID integer NOT NULL, 
    cupomID integer NOT NULL,
    PRIMARY KEY (id)
    -- PRIMARY KEY (usuarioID, cupomID),
    FOREIGN KEY (usuarioID) REFERENCES consumidor (usuarioID),
    FOREIGN KEY (cupomID) REFERENCES cupom (id)
);

CREATE TABLE IF NOT EXISTS Transportado (
    anuncioID integer NOT NULL, 
    transportadoraID integer NOT NULL,
    PRIMARY KEY (anuncioID, transportadoraID),
    FOREIGN KEY (anuncioID) REFERENCES anuncio (id),
    FOREIGN KEY (transportadoraID) REFERENCES transportadora (id)
);

CREATE TABLE IF NOT EXISTS Pedido (
    id serial PRIMARY KEY, 
    status varchar NOT NULL, 
    dataEmissao timestamp, 
    dataAprovacao timestamp, 
    dataPedidoDevolucao timestamp, 
    dataDevolucao timestamp, 
    dataConclusao timestamp, 
    moeda varchar(20) NOT NULL, 
    custoEnvio float, 
    cupomUsuarioID integer, 
    consumidorID integer NOT NULL, 
    CHECK (
        status IN ('Pendente', 'Cancelada', 'Aprovada', 'Nota Fiscal', 'Em transito', 'Entregue', 'Devolvido', 'Concluido') 
    ),
    FOREIGN KEY (cupomUsuarioID) REFERENCES cuponsusuario (id), 
    FOREIGN KEY (consumidorID) REFERENCES consumidor (usuarioID)
);

CREATE TABLE IF NOT EXISTS Vende (
    transportadoraID integer NOT NULL, 
    anuncioID integer NOT NULL, 
    pedidoID integer NOT NULL, 
    PRIMARY KEY (transportadoraID,anuncioID,pedidoID),
    preco float NOT NULL,
    FOREIGN KEY (anuncioID) REFERENCES anuncio (id),
    FOREIGN KEY (transportadoraID) REFERENCES transportadora (id),
    FOREIGN KEY (pedidoID) REFERENCES pedido (id)
);    
