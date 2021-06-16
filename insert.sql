/*
Nesse exemplo, consideramos:
Usuário com ID: 1 -> Vendedor
Usuário com ID: 2 -> Consumidor
*/
-- Cadastrar um vendedor pessoa jurídica
-- Cadastra o usuário
INSERT INTO usuario (email, senha, nome, dataNascimento, endereco)
VALUES ('ceo@mylittlepringles.com','acesso123','My Little Pringles', '1980-02-10','{
  "endereco": {
    "rua": "Rua Equestria",
    "numero": "255",
    "complemento": "casa",
    "cep": "77001212",
    "cidade": "Uruguaiana",
    "bairro": "Lindóia",
    "estado": "RS",
    "pais": "Brasil"
  }
}');
/*
A tabela *usuario* tem uma propriedade que auto incrementa o ID dos usuários, 
nesse exemplo, vamos considerar que o INSERT acima criou o usuário com ID: 1 e iremos usar nas relações futuras.
*/

-- Cadastra o vendedor e associa
INSERT INTO vendedor (usuarioID) VALUES (1);

-- Cadastra pessoa jurídica e associa
INSERT INTO PessoaJuridica (usuarioID, cnpj, razaoSocial)
VALUES (1, '51191547000152', 'Empresa Secreta do Manual do Mundo LTDA');

-- Criar um anúncio de lote
-- Cadastra o produto
INSERT INTO produto (ean, nome, categoria, marca)
VALUES (5554443322212,'Sabor Applejack','Bebida','My Little Pringles');

-- Cadastra o anúncio
INSERT INTO anuncio (dataPublicacao, produtoEan, usuarioID)
VALUES (CURRENT_TIMESTAMP(0), 5554443322212, 1);

-- Cadastra Lote e associa
INSERT INTO lote (anuncioID, preco, quantidadeLote, estoque, status)
VALUES (1, 15, 50, 0, 'Disponivel');

-- Cadastrar o transporte de um produto
-- Cadastra o usuário
INSERT INTO usuario (email, senha, nome, telefone, dataNascimento, endereco)
VALUES ('joojliano@gmail.com', 'senhasecreta854', 'Juliano Afonso Fukuda', '5522988477745', '1944-11-09', '{
  "endereco": {
    "rua": "Rua Sao Luiz",
    "numero": "222",
    "complemento": "casa",
    "cep": "96425280",
    "cidade": "Bagé",
    "bairro": "Centro",
    "estado": "RS",
    "pais": "Brasil"
  }
}');
/*
A tabela *usuario* tem uma propriedade que auto incrementa o ID dos usuários, 
nesse exemplo, vamos considerar que o INSERT acima criou o usuário com ID: 2 e iremos usar nas relações futuras.
*/

-- Cadastra o usuário consumidor e associa
INSERT INTO consumidor (usuarioID, cpf, cartoes)
VALUES (2, '79721723150', '{
    "cartoes":{
        "numero": "5284 9154 7087 2628",
        "data_validade": "10/06/2022",
        "cvv": "909"
    }
}');
-- Cadastra a transportadora
INSERT INTO transportadora (cnpj, nome, endereco, telefone, cidades)
VALUES ('82650737000114', 'Ollé Teleportes', 'Rua Gomes Carneiro, 777', '5567984739399', '{
  "BRA":{
    "RS": ["Pelotas","Capão do Leão","Santana do Livramento"],
    "SP": ["São Paulo","Santos"],
    "RJ": ["Rio de Janeiro","Angra dos Reis"]
  }
}');
/*
A tabela *transportadora* tem uma propriedade que auto incrementa o ID das transportadoras, 
nesse exemplo, vamos considerar que o INSERT acima criou a transportadora com ID: 2 e iremos usar nas relações futuras.
*/

-- Cadastrar o transportado
INSERT INTO transportado (anuncioID, transportadoraID)
VALUES (1, 1);

-- Cadastrar o pedido
INSERT INTO pedido (status, dataEmissao, moeda, custoEnvio, consumidorID) 
VALUES ('Pendente',CURRENT_TIMESTAMP(0),'BRL', 55.99, 2);
/*
A tabela *pedido* tem uma propriedade que auto incrementa o ID dos pedidos, 
nesse exemplo, vamos considerar que o INSERT acima criou o pedido com ID: 1 e iremos usar nas relações futuras.
*/

-- Cadastrar a venda
INSERT INTO vende (transportadoraID, anuncioID, pedidoID, preco)
VALUES (1, 1, 1, 70.99);

-- Cria um Cupom
INSERT INTO cupom (nome, duracao, usuarioID)
VALUES ('Black Friday','2021-11-30 23:59:59',1);
/*
A tabela *Cupom* tem uma propriedade que auto incrementa o ID dos cupons, 
nesse exemplo, vamos considerar que o INSERT acima criou o cupom com ID: 1 e iremos usar nas relações futuras.
*/

-- Vincula o cupom criado ao desconto por porcentagem
INSERT INTO Porcentagem (cupomID, desconto)
VALUES (1,45);

-- Vincula o cupom ao um usuário
INSERT INTO CuponsUsuario (usuarioID, cupomID)
VALUES (1,1);