
-- Ver todas as avaliações que o usuário já fez

SELECT avaliacao.* FROM avaliacao
JOIN usuario ON avaliacao.usuarioid = usuario.id
ORDER BY avaliacao.dataPublicacao DESC;
WHERE pedido.usuarioid = 1;

-- Todos os anuncios com valor entre 1000 e 2000 do produto de ean 11107463

SELECT * FROM anuncio
JOIN unidade ON anuncio.id = unidade.anuncioid
JOIN produto ON produto.ean = anuncio.produtoean
WHERE unidade.preco BETWEEN 1000 AND 2000
AND produto.ean = 11107463;

-- Todos os itens em um pedido, sem ter efetivado a compra

SELECT produto.ean, pedido.moeda, produto.nome, 
produto.marca, produto.categoria, produto.midia,
vende.preco, transportadora.nome, transportadora.id, 
transportadora.apilink
FROM pedido
JOIN vende ON pedido.id = vende.pedidoId
JOIN anuncio ON anuncio.id = vende.anuncioid
JOIN produto ON produto.ean anuncio.produtoean
JOIN transportadora ON transportadora.id vende.transportadoraid
WHERE pedido.id = 4

-- Todas as informações de um pedido com cupom de desconto fixo, sem ter efetivado a compra

SELECT pedido.id, pedido.status, pedido.moeda, 
(SELECT count(*) FROM vende WHERE pedidoId=pedido.id) AS numitens, SUM(preco) AS valortotal, 
fixo.desconto AS cupomDesconto, SUM(preco)-fixo.desconto AS valortotaldesconto
FROM pedido
JOIN cuponsUsuario ON pedido.cupomUsuarioID = cuponsUsuario.id
JOIN vende ON pedido.id = vende.pedidoId
JOIN cupom ON cupom.id = cuponsUsuario.cupomid
JOIN fixo ON fixo.cupomID = cupom.id
WHERE pedido.id = 4
GROUP BY pedido.id, pedido.status, pedido.moeda, fixo.desconto;

-- Todas as informações de um pedido com cupom de desconto em porcentagem, sem ter efetivado a compra

SELECT pedido.id, pedido.status, pedido.moeda, 
(SELECT count(*) FROM vende WHERE pedidoId=pedido.id) AS numitens, SUM(preco) AS valortotal, 
porcentagem.desconto AS cupomDesconto, 
(SUM(preco)-itemdesconto.valororiginal)+itemdesconto.valororiginal*porcentagem.desconto AS valortotaldesconto
FROM pedido
JOIN cuponsUsuario ON pedido.cupomUsuarioID = cuponsUsuario.id
JOIN vende ON pedido.id = vende.pedidoId
JOIN cupom ON cupom.id = cuponsUsuario.cupomid
JOIN porcentagem ON porcentagem.cupomID = cupom.id
JOIN anuncio ON anuncio.id = vende.anuncioid
JOIN (
    SELECT anuncio.produtoean AS ean, vende.preco AS valororiginal 
    FROM pedido
    JOIN cuponsUsuario ON pedido.cupomUsuarioID = cuponsUsuario.id
    JOIN cupom ON cupom.id = cuponsUsuario.cupomid
    JOIN vende ON vende.pedidoId = pedido.id
    JOIN anuncio ON anuncio.id = vende.anuncioid
    WHERE anuncio.produtoean = cupom.produtoean AND pedido.id = 4
) AS itemdesconto ON anuncio.produtoean = cupom.produtoean
WHERE pedido.id = 4
GROUP BY pedido.id, pedido.status, pedido.moeda, porcentagem.desconto, itemdesconto.valororiginal;