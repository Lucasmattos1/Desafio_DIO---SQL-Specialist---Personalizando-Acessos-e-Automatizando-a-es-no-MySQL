-- Antes de criar o trigger, precisamos de uma tabela para armazenar as informações dos clientes removidos.
CREATE TABLE Backup_Cliente (
    Cliente_ID INT,
    Nome VARCHAR(100),
    Endereco VARCHAR(200),
    Telefone VARCHAR(20),
    DataRemocao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Este trigger é acionado antes da remoção de um cliente da tabela Cliente e insere os dados desse cliente na tabela de backup.
CREATE TRIGGER BeforeDeleteCliente
BEFORE DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO Backup_Cliente (Cliente_ID, Nome, Endereco, Telefone)
    VALUES (Cliente_ID, OLD.Nome, OLD.Endereco, OLD.Telefone);
END;

/* Explicação:
O comando BEFORE DELETE é acionado antes que o registro seja removido.
A palavra-chave OLD se refere aos valores antigos da linha que está sendo excluída.
Esse trigger garante que os dados do cliente sejam armazenados no Backup_Cliente antes da exclusão. */


/*Trigger para Atualização: BEFORE UPDATE de Salário de Colaboradores
Objetivo: Sempre que o salário de um colaborador for atualizado, o trigger deve registrar a alteração em uma tabela
de histórico para auditoria. Isso ajuda a acompanhar as mudanças salariais ao longo do tempo.
*/
-- Precisamos de uma tabela para armazenar o histórico das alterações salariais.
CREATE TABLE Historico_Salario (
    IDMecanico INT,
    SalarioAntigo DECIMAL(10, 2),
    SalarioNovo DECIMAL(10, 2),
    DataAlteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger BEFORE UPDATE para Atualização de Salário
-- Este trigger é acionado sempre que o salário de um colaborador for atualizado.
CREATE TRIGGER BeforeUpdateSalario
BEFORE UPDATE ON Mecanico
FOR EACH ROW
BEGIN
    IF OLD.Salario <> NEW.Salario THEN
        INSERT INTO Historico_Salario (IDMecanico, SalarioAntigo, SalarioNovo)
        VALUES (OLD.IDMecanico, OLD.Salario, NEW.Salario);
    END IF;
END;

/* Explicação:

O comando BEFORE UPDATE é acionado antes que o registro seja atualizado.
A comparação OLD.Salario <> NEW.Salario garante que o trigger só seja acionado se o valor do salário for realmente alterado.
Esse trigger armazena o salário antigo e o novo salário na tabela de histórico, juntamente com a data da alteração.
*/



/* Trigger para Inserção de Novos Colaboradores
Objetivo: Sempre que um novo colaborador for inserido na tabela de mecânicos, o trigger deve executar uma ação
 específica. Neste exemplo, podemos definir que, ao inserir um novo colaborador, seu salário inicial será definido
 automaticamente se não for informado.*/
 -- Trigger BEFORE INSERT para Inserção de Colaboradores
 -- Este trigger verifica se o salário foi informado durante a inserção de um novo colaborador. Se não foi informado, ele define um valor padrão.
 CREATE TRIGGER BeforeInsertMecanico
BEFORE INSERT ON Mecanico
FOR EACH ROW
BEGIN
    IF NEW.Salario IS NULL THEN
        SET NEW.Salario = 3000.00  -- Define um salário padrão de R$3000,00
    END IF;
END;

/* Explicação:

O comando BEFORE INSERT é acionado antes da inserção de um novo registro.
O trigger verifica se o campo Salario está NULL. Se estiver, define um valor padrão de R$ 3000,00.
Esse tipo de trigger pode garantir que todos os novos colaboradores tenham um salário atribuído mesmo se não 
for especificado durante a inserção.


