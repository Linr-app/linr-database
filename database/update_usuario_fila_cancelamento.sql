UPDATE UsuarioFila SET hora_saida_restaurante = $1, desistiu_da_fila = TRUE WHERE id_usuario_fila = $2;
