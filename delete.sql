-- Apagar um Pedido com ID 1
DELETE FROM pedido WHERE id=1;

-- Apagar transportadora com ID 1
DELETE FROM transportadora WHERE id=1;

-- Remove o usuário com ID 1 como vendedor (e consecutivamente PessoaJuridica)
DELETE FROM Vendedor WHERE usuarioID=1;
DELETE FROM PessoaJuridica WHERE usuarioID=1;