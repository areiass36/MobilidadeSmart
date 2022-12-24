CREATE DATABASE [MobilidadeSmart];

USE [MobilidadeSmart];

CREATE TABLE [Aluno] (
  [Numero] INT PRIMARY KEY,
  [Nome] VARCHAR(100),
  [Apelido] VARCHAR(100),
  [DataNascimento] DATETIME,
  [NumeroCarteira] VARCHAR(20),
  [Email] VARCHAR(255),
  [Senha] VARCHAR(60),
  [EnderecoId] INT
)
GO

CREATE TABLE [Contato] (
  [NumeroAluno] INT PRIMARY KEY,
  [Tipo] INT,
  [Valor] VARCHAR(60)
)
GO

CREATE TABLE [TipoContato] (
  [Id] INT PRIMARY KEY IDENTITY(1, 1),
  [Nome] VARCHAR(12)
)
GO

CREATE TABLE [Endereco] (
  [Id] INT PRIMARY KEY,
  [Numero] INT,
  [Observacao] VARCHAR(255),
  [Rua] VARCHAR(255),
  [CodigoPostal] CHAR(7)
)
GO

CREATE TABLE [CodigoPostal] (
  [CodigoPostal] CHAR(7) PRIMARY KEY,
  [Localidade] VARCHAR(255)
)
GO

CREATE TABLE [Veiculo] (
  [Id] INT PRIMARY KEY,
  [ModeloId] INT,
  [CorId] INT,
  [Placa] VARCHAR(10),
  [ZonaId] INT,
  [Bateria] TINYINT
)
GO

CREATE TABLE [VeiculoModelo] (
  [Id] INT PRIMARY KEY,
  [Nome] VARCHAR(80),
  [CategoriaVeiculo] INT
)
GO

CREATE TABLE [CategoriaVeiculo] (
  [Id] INT PRIMARY KEY,
  [Nome] VARCHAR(20)
)
GO

CREATE TABLE [Cor] (
  [Id] INT PRIMARY KEY,
  [Nome] VARCHAR(60)
)
GO

CREATE TABLE [Zona] (
  [Id] INT PRIMARY KEY,
  [EnderecoId] INT,
  [Nome] VARCHAR(60)
)
GO

CREATE TABLE [Corrida] (
  [Id] INT PRIMARY KEY,
  [VeiculoId] INT,
  [DataInicio] DATETIME,
  [DataFim] DATETIME,
  [ZonaInicio] INT,
  [ZonaFim] INT
)
GO

CREATE TABLE [CorridaAluno] (
  [CorridaId] INT,
  [NumeroAluno] INT,
  [Tipo] INT,
  PRIMARY KEY ([CorridaId], [NumeroAluno])
)
GO

CREATE TABLE [TipoAlunoCorrida] (
  [Id] INT PRIMARY KEY,
  [Nome] VARCHAR(10)
)
GO

CREATE TABLE [FilaEspera] (
  [Id] INT PRIMARY KEY,
  [NumeroAluno] INT,
  [CategoriaVeiculo] INT,
  [InicioEspera] DATETIME,
  [FimEspera] DATETIME,
  [ZonaId] INT
)
GO

CREATE TABLE [Notificacao] (
  [FilaEsperaId] INT PRIMARY KEY,
  [Mensagem] VARCHAR(255),
  [DataEnvio] DATETIME
)
GO

ALTER TABLE [Aluno] ADD FOREIGN KEY ([EnderecoId]) REFERENCES [Endereco] ([Id])
GO

ALTER TABLE [Contato] ADD FOREIGN KEY ([NumeroAluno]) REFERENCES [Aluno] ([Numero])
GO

ALTER TABLE [Contato] ADD FOREIGN KEY ([Tipo]) REFERENCES [TipoContato] ([Id])
GO

ALTER TABLE [Endereco] ADD FOREIGN KEY ([CodigoPostal]) REFERENCES [CodigoPostal] ([CodigoPostal])
GO

ALTER TABLE [Veiculo] ADD FOREIGN KEY ([ModeloId]) REFERENCES [VeiculoModelo] ([Id])
GO

ALTER TABLE [Veiculo] ADD FOREIGN KEY ([CorId]) REFERENCES [Cor] ([Id])
GO

ALTER TABLE [VeiculoModelo] ADD FOREIGN KEY ([CategoriaVeiculo]) REFERENCES [CategoriaVeiculo] ([Id])
GO

ALTER TABLE [Zona] ADD FOREIGN KEY ([EnderecoId]) REFERENCES [Endereco] ([Id])
GO

ALTER TABLE [Corrida] ADD FOREIGN KEY ([VeiculoId]) REFERENCES [Veiculo] ([Id])
GO

ALTER TABLE [Corrida] ADD FOREIGN KEY ([ZonaInicio]) REFERENCES [Zona] ([Id])
GO

ALTER TABLE [Corrida] ADD FOREIGN KEY ([ZonaFim]) REFERENCES [Zona] ([Id])
GO

ALTER TABLE [CorridaAluno] ADD FOREIGN KEY ([CorridaId]) REFERENCES [Corrida] ([Id])
GO

ALTER TABLE [CorridaAluno] ADD FOREIGN KEY ([NumeroAluno]) REFERENCES [Aluno] ([Numero])
GO

ALTER TABLE [CorridaAluno] ADD FOREIGN KEY ([Tipo]) REFERENCES [TipoAlunoCorrida] ([Id])
GO

ALTER TABLE [FilaEspera] ADD FOREIGN KEY ([NumeroAluno]) REFERENCES [Aluno] ([Numero])
GO

ALTER TABLE [FilaEspera] ADD FOREIGN KEY ([CategoriaVeiculo]) REFERENCES [CategoriaVeiculo] ([Id])
GO

ALTER TABLE [FilaEspera] ADD FOREIGN KEY ([ZonaId]) REFERENCES [Zona] ([Id])
GO

ALTER TABLE [Notificacao] ADD FOREIGN KEY ([FilaEsperaId]) REFERENCES [FilaEspera] ([Id])
GO
