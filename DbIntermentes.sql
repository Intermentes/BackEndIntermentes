CREATE DATABASE Banco_Intermentes;
USE Banco_Intermentes;

CREATE TABLE Tb_Pacientes (
  Pk_Id_Cpf_Paciente VARCHAR(11) NOT NULL,
  Senha_Paciente VARCHAR(200) NOT NULL,
  Etnia_Paciente ENUM('Negro', 'Branco', 'Pardo', 'Amarelo', 'Indigena') NOT NULL,
  Nome_Completo_Paciente VARCHAR(255) NOT NULL,
  Genero_Paciente ENUM('Masculino', 'Feminino', 'Mulher Trans', 'Homem Trans') NOT NULL,
  Data_Nascimento_Paciente DATE NOT NULL,
  Email_Paciente VARCHAR(255) NOT NULL,
  Celular_Paciente VARCHAR(20) NOT NULL,
  Contato_Emergencia VARCHAR(20),
  
  CONSTRAINT Pk_Id_Cpf_Paciente PRIMARY KEY (Pk_Id_Cpf_Paciente)
);

CREATE TABLE Tb_Profissional (
  Pk_Id_Cpf_Profissional VARCHAR(11) NOT NULL,
  Nome_Profissional VARCHAR(100),
  Telefone_Celular_Profissional VARCHAR(15),
  CRP VARCHAR(10),
  Especialidade VARCHAR(100),
  Genero_Profissional VARCHAR(20),
  Email_Profissional VARCHAR(100),
  Pontos_Sociais INT,
  Formacao_Academica TEXT,
  Data_Nascimento_Profissional DATE,
  Biografia_Profissional TEXT,
  Foto_Profissional BLOB,
  Etnia_Profissional VARCHAR(50),
  Historico_Profissional TEXT,
  Senha_Profissional VARCHAR(255),
  Avaliacoes_Dos_Pacientes TEXT,
  Avaliacao_Geral FLOAT,
  Agenda_Profissional TEXT,
  Subcategorias TEXT,
  Data_Validade_Cartao_CVV VARCHAR(5),
  Num_Cartao VARCHAR(16),
  Nome_Completo_Titular VARCHAR(100),
  Data_Expiracao DATE,
  Metodo_Pagamento ENUM('Credito', 'Debito'),
  
  CONSTRAINT Pk_Id_Cpf_Profissional PRIMARY KEY (Pk_Id_Cpf_Profissional)
);

CREATE TABLE Tb_Agendamento (
  Pk_Id_Consulta INT PRIMARY KEY AUTO_INCREMENT,
  Data DATE NOT NULL,
  Hora TIME NOT NULL,
  Fk_Id_Cpf_Paciente VARCHAR(11) NOT NULL,
  Fk_Id_Cpf_Profissional VARCHAR(11) NOT NULL,
  
  CONSTRAINT Fk_Id_Cpf_Paciente FOREIGN KEY (Fk_Id_Cpf_Paciente) REFERENCES Tb_Pacientes(Pk_Id_Cpf_Paciente),
  CONSTRAINT Fk_Id_Cpf_Profissional FOREIGN KEY (Fk_Id_Cpf_Profissional) REFERENCES Tb_Profissional(Pk_Id_Cpf_Profissional)
);

CREATE TABLE Tb_Pagamento (
  Pk_Id_Meio_Pagamento INT AUTO_INCREMENT NOT NULL,
  Valor DOUBLE NOT NULL,
  Data DATE NOT NULL,
  Fk_Id_Cpf_Paciente VARCHAR(11) NOT NULL,
  Fk_Id_Agendamento INT,
  Fk_Id_Profissional INT,
  
  CONSTRAINT Pk_Id_Meio_Pagamento PRIMARY KEY (Pk_Id_Meio_Pagamento),
  
  CONSTRAINT Fk_Id_Cpf_Paciente FOREIGN KEY (Fk_Id_Cpf_Paciente) REFERENCES Tb_Pacientes(Pk_Id_Cpf_Paciente),
  CONSTRAINT Fk_Id_Agendamento FOREIGN KEY (Fk_Id_Agendamento) REFERENCES Tb_Agendamento(Pk_Id_Consulta),
  CONSTRAINT Fk_Id_Profissional FOREIGN KEY (Fk_Id_Profissional) REFERENCES Tb_Profissional(Pk_Id_Cpf_Profissional)
);

CREATE TABLE Tb_Rembolso (
  Pk_Id_Rembolso INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Fk_Id_Pagamento INT NOT NULL,
  Fk_Id_Cpf_Paciente VARCHAR(11) NOT NULL,
  Metodo_Pagamento ENUM('Credito', 'Debito', 'Pix') NOT NULL,
  Motivo VARCHAR(255) NOT NULL,
  
  CONSTRAINT Fk_Id_Pagamento FOREIGN KEY (Fk_Id_Pagamento) REFERENCES Tb_Pagamento(Pk_Id_Meio_Pagamento),
  CONSTRAINT Fk_Id_Cpf_Paciente FOREIGN KEY (Fk_Id_Cpf_Paciente) REFERENCES Tb_Pacientes(Pk_Id_Cpf_Paciente)
);

ALTER TABLE Tb_Profissional ADD Fk_Id_Rembolso INT;
ALTER TABLE Tb_Profissional ADD CONSTRAINT Fk_Id_Rembolso FOREIGN KEY (Fk_Id_Rembolso) REFERENCES Tb_Rembolso(Pk_Id_Rembolso);
