SELECT *
FROM Usuario
LEFT JOIN UsuarioCadastrado
ON Usuario.id_usuario=UsuarioCadastrado.id_usuario
ORDER BY Usuario.id_usuario
AS T1;

SELECT UsuarioFila.id_usuario_fila, UsuarioFila.id_fila, UsuarioFila.hora_entrada_fila,
UsuarioFila.qtd_pessoas, UsuarioFila.tem_reserva, T1.id_usuario, T1.nome, T1.telefone, T1.email
FROM UsuarioFila
INNER JOIN T1
ON UsuarioFila.id_usuario=T1.id_usuario
ORDER BY UsuarioFila.id_usuario_fila
WHERE id_fila  =  $1 AND UsuarioFila.hora_entrada_atendimento = NULL
AS T2;

SELECT COUNT (id_usuario_fila)
FROM T2
WHERE id_usuario = $1