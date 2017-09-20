INSERT INTO restaurante
(nome, endereco, descricao, site, telefone, hora_funcionamento_inicio, hora_funcionamento_fim, forma_pagamento, informacao_adicional)
VALUES
  ($1, $2, $3, $4, $5, $6, $7, $8, $9);
