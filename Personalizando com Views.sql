-- View para Clientes
/* Clientes devem ver apenas suas próprias ordens de serviço, 
sem acessar informações detalhadas sobre outros clientes ou mecânicos */
/* Motivo: Essa view filtra as ordens de serviço apenas para o cliente que está logado ou para um cliente específico. 
Assim, os clientes só veem suas próprias ordens, sem expor informações de outros clientes ou mecânicos.*/


CREATE VIEW View_Cliente_Ordens AS
SELECT 
    OS.Equipe_ID, 
    OS.DataEmissão, 
    OS.DataPrevistaConclusão, 
    OS.StatusServico, 
    OS.ValorTotal
FROM 
    OrdemdeServico OS
JOIN 
    Cliente C ON OS.Cliente_ID = C.CódigoCliente
WHERE 
    C.CódigoCliente = CURRENT_USER();  -- Ou use um ID específico do cliente
    

/* View para Mecânicos
Mecânicos podem visualizar apenas as ordens de serviço atribuídas a eles e detalhes do serviço, 
mas sem acessar informações financeiras ou dados do cliente.
Motivo: Essa view permite que os mecânicos vejam apenas as ordens atribuídas a eles, incluindo detalhes dos serviços executados, 
mas sem revelar dados do cliente ou os valores financeiros da ordem de serviço. */

CREATE VIEW View_Mecanico_Ordens AS
SELECT 
    OS.Equipe_ID, 
    OS.DataEmissão, 
    OS.DataPrevistaConclusão, 
    OS.StatusServico, 
    S.Descrição AS Servico_Executado
FROM 
    OrdemdeServico OS
JOIN 
    OrdemDeServico_Servico OSS ON Equipe_ID = OSS.NúmeroOS
JOIN 
    Servico S ON OSS.CódigoServiço = S.CódigoServiço
JOIN 
    Mecanico M ON OSS.NúmeroOS = M.CódigoMecânico
WHERE 
    M.CódigoMecânico = CURRENT_USER(); -- Ou use um ID específico do mecânico


/*View para Gerentes
Gerentes devem ter acesso a uma visão geral, com informações sobre ordens de serviço, 
clientes e mecânicos, mas ainda assim sem exposição completa de detalhes financeiros sensíveis.
Motivo: Essa view permite que os gerentes tenham uma visão completa das ordens de serviço, incluindo os clientes e mecânicos responsáveis, 
mas sem revelar o valor total ou outros dados financeiros sensíveis. Isso garante que eles possam acompanhar o 
fluxo de trabalho sem acesso a informações financeiras ou pessoais detalhadas. */

CREATE VIEW View_Gerente_Ordens AS
SELECT 
    OS.Equipe_ID, 
    C.Nome AS Cliente, 
    M.Nome AS Mecanico, 
    OS.DataEmissão, 
    OS.DataPrevistaConclusão, 
    OS.StatusServico
FROM 
    OrdemdeServico OS
JOIN 
    Cliente C ON OS.Cliente_ID = C.CódigoCliente
JOIN 
    OrdemDeServico_Servico OSS ON OS.Equipe_ID = OSS.CódigoServiço
JOIN 
    Mecanico M ON OSS.ID_Mecanico = M.CódigoMecânico;
    
    -- Permitir que clientes acessem apenas View_Cliente_Ordens:
GRANT SELECT ON View_Cliente_Ordens TO 'cliente_user';

-- Permitir que mecânicos acessem apenas View_Mecanico_Ordens:
GRANT SELECT ON View_Mecanico_Ordens TO 'mecanico_user';

-- Permitir que gerentes acessem apenas View_Gerente_Ordens:
GRANT SELECT ON View_Gerente_Ordens TO 'gerente_user';





