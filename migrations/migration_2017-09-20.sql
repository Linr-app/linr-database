-- -----------------------------------------------------
-- Schema linr_sc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS linr_sc;

-- -----------------------------------------------------
-- Table linr_sc.Restaurante
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS linr_sc.Restaurante (
  id_restaurante            BIGSERIAL PRIMARY KEY,
  nome                      TEXT        NOT NULL,
  endereco                  TEXT        NOT NULL,
  descricao                 TEXT        NOT NULL,
  site                      TEXT        NOT NULL,
  telefone                  VARCHAR(15) NOT NULL,
  hora_funcionamento_inicio TIME [7]    NULL,
  hora_funcionamento_fim    TIME [7]    NULL,
  forma_pagamento           TEXT []     NULL,
  informacao_adicional      TEXT        NULL
);

-- -----------------------------------------------------
-- Table linr_sc.Fila
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS linr_sc.Fila (
  id_fila                   BIGSERIAL PRIMARY KEY,
  id_restaurante            BIGINT REFERENCES linr_sc.Restaurante ON DELETE CASCADE ON UPDATE RESTRICT,
  hora_funcionamento_inicio TIME NOT NULL,
  hora_funcionamento_fim    TIME NOT NULL
);

-- -----------------------------------------------------
-- Table linr_sc.UsuarioAdm
-- -----------------------------------------------------
CREATE TYPE linr_sc.TIPOUSUARIOADM AS ENUM ('dono', 'garcom');

CREATE TABLE IF NOT EXISTS linr_sc.UsuarioAdm (
  id_mesa_adm    BIGSERIAL PRIMARY KEY,
  id_restaurante BIGINT REFERENCES linr_sc.Restaurante ON DELETE CASCADE ON UPDATE CASCADE,
  nome           TEXT                   NOT NULL,
  email          TEXT                   NOT NULL,
  senha          TEXT                   NOT NULL,
  tipo           linr_sc.TIPOUSUARIOADM NOT NULL
);

-- -----------------------------------------------------
-- Table linr_sc.Categoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS linr_sc.Categoria (
  id_categoria BIGSERIAL PRIMARY KEY,
  nome         TEXT NOT NULL UNIQUE,
  descricao    TEXT NOT NULL
);

-- -----------------------------------------------------
-- Table linr_sc.Mesa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS linr_sc.Mesa (
  id_mesa        INT UNIQUE,
  id_restaurante INT     NOT NULL REFERENCES linr_sc.Restaurante ON DELETE CASCADE ON UPDATE CASCADE,
  capacidade     INT     NOT NULL,
  ocupada        BOOLEAN NOT NULL,
  PRIMARY KEY (id_mesa, id_restaurante)
);

-- -----------------------------------------------------
-- Table linr_sc.RestauranteCategoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS linr_sc.RestauranteCategoria (
  id_restaurante BIGINT REFERENCES linr_sc.Restaurante,
  id_categoria   BIGINT REFERENCES linr_sc.Categoria,
  PRIMARY KEY (id_restaurante, id_categoria)
);

-- -----------------------------------------------------
-- Table linr_sc.UsuarioCadastrado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS linr_sc.UsuarioCadastrado (
  id_usuario_cadastrado BIGSERIAL PRIMARY KEY,
  nome                  TEXT        NOT NULL,
  email                 TEXT        NOT NULL,
  telefone              VARCHAR(15) NOT NULL,
  senha                 VARCHAR(36) NOT NULL
);

CREATE UNIQUE INDEX email_index
  ON linr_sc.UsuarioCadastrado (email ASC);

-- -----------------------------------------------------
-- Table linr_sc.UsuarioFila
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS linr_sc.UsuarioFila (
  id_usuario_fila          BIGSERIAL PRIMARY KEY,
  id_fila                  BIGINT REFERENCES linr_sc.Fila ON DELETE RESTRICT ON UPDATE RESTRICT,
  hora_entrada_fila        TIMESTAMP NOT NULL,
  hora_entrada_atendimento TIMESTAMP NULL,
  hora_saida_restaurante   TIMESTAMP NULL,
  qtd_pessoas              INT       NOT NULL,
  tem_reserva              BOOLEAN   NOT NULL DEFAULT FALSE,
  desistiu_da_fila         BOOLEAN   NOT NULL DEFAULT FALSE
);

-- -----------------------------------------------------
-- Table linr_sc.UsuarioTemporario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS linr_sc.UsuarioTemporario (
  id_usuario_temporario BIGSERIAL PRIMARY KEY,
  is_usuario_fila       BIGINT REFERENCES linr_sc.UsuarioFila ON DELETE RESTRICT ON UPDATE RESTRICT,
  nome                  TEXT        NOT NULL,
  telefone              VARCHAR(15) NULL
);

-- -----------------------------------------------------
-- Table linr_sc.UsuarioFila_Usuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS linr_sc.UsuarioFila_UsuarioCadastrado (
  id_usuario_cadastrado BIGINT REFERENCES linr_sc.UsuarioCadastrado,
  id_usuario_fila       BIGINT REFERENCES linr_sc.UsuarioFila,
  PRIMARY KEY (id_usuario_cadastrado, id_usuario_fila)
);

