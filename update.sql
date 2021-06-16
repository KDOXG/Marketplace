-- Mudar status do Produto com ID 1
UPDATE unidade SET status='Nao disponivel' WHERE anuncioID=1;

-- Mudar endereço do usuário com ID 1
UPDATE usuario SET endereco='{
  "endereco": {
    "rua": "Rua Anglo",
    "numero": "666",
    "complemento": "Prédio",
    "cep": "77001216",
    "cidade": "Roma",
    "bairro": "Lindóia",
    "estado": "AM",
    "pais": "Argentina"
  }
}' WHERE id=2;

-- Mudar status do Pedido para Aprovada
UPDATE pedido SET status='Aprovada',dataAprovacao='2020-06-09 21:53:00' WHERE id=1;

-- Mudar status do Pedido para Cancelado
UPDATE pedido SET status='Cancelada',dataPedidoDevolucao=CURRENT_TIMESTAMP(0) WHERE id=1;

-- Mudar status do Pedido para Concluido
UPDATE pedido SET status='Concluido',dataConclusao=CURRENT_TIMESTAMP(0) WHERE id=1;

-- Muda o Preço do produto no Lote
UPDATE lote SET preco='69.24' WHERE anuncioID=1;

-- Associa um cupom ao pedido
UPDATE pedido SET cupomUsuarioID=1 WHERE id=1;