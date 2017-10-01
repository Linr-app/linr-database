SELECT * FROM UsuarioFila_UsuarioCadastrado
  INNER JOIN UsuarioCadastrado
  ON (UsuarioFila_UsuarioCadastrado.id_usuario_cadastrado = UsuarioCadastrado.id_usuario_cadastrado)
  AS T1;


  SELECT UsuarioFila.id_usuario_fila, UsuarioFila.id_fila, UsuarioFila.hora_entrada_fila,
  UsuarioFila.qtd_pessoas, UsuarioFila.tem_reserva, T1.id_usuario_cadastrado, T1.nome, T1.telefone, T1.email
  FROM UsuarioFila
  LEFT JOIN T1
  ON UsuarioFila.id_usuario_fila=T1.id_usuario_fila
  ORDER BY UsuarioFila.id_usuario_fila
  AS T2;


  SELECT UsuarioFila.id_usuario_fila, UsuarioFila.id_fila, UsuarioFila.hora_entrada_fila,
  UsuarioFila.qtd_pessoas, UsuarioFila.tem_reserva, UsuarioTemporario.*
  FROM UsuarioFila
  LEFT JOIN UsuarioTemporario
  ON UsuarioFila.id_usuario_fila=UsuarioTemporario.id_usuario_fila
  ORDER BY UsuarioFila.id_usuario_fila
  AS T3;


  SELECT id_usuario_fila, nome, telefone FROM T2 WHERE nome!=NULL union
  SELECT id_usuario_fila, nome, telefone FROM T3 WHERE nome!=NULL
  AS T4;


  SELECT id_usuario_fila, hora_entrada_fila, qtd_pessoas, tem_reserva, id_usuario_cadastrado, T4.nome, T4.telefone, T1.email
  FROM T2
  INNER JOIN T3 ON (T2.id_usuario_fila = T3.id_usuario_fila)
  INNER JOIN T4 ON (T3.id_usuario_fila = T4.id_usuario_fila)
  WHERE id_fila  =  $1
  AS T5;
