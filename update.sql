-- Mudar status do Produto 1
UPDATE unidade SET status='Nao disponivel' WHERE anuncioID=1;

-- Mudar endereço do ID 1
UPDATE usuario SET endereco='Alguma rua, 101' WHERE id=2;

-- Mudar status do Pedido para Aprovada
UPDATE pedido SET status='Aprovada',dataAprovacao='2020-06-09 21:53:00' WHERE id=1;

-- Mudar status do Pedido para Cancelado
UPDATE pedido SET status='Cancelada',dataPedidoDevolucao=CURRENT_TIMESTAMP(0) WHERE id=1;

-- Mudar status do Pedido para Concluido
UPDATE pedido SET status='Concluido',dataConclusao=CURRENT_TIMESTAMP(0) WHERE id=1;
