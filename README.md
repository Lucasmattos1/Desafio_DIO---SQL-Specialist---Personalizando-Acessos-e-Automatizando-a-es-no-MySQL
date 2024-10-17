# Descrição do Projeto
Este projeto foi desenvolvido para gerenciar e controlar a execução de ordens de serviço em uma oficina mecânica. Ele contém a modelagem de dados, triggers para automação de processos, views para personalizar acessos e procedures para a manipulação de dados. O sistema abrange funcionalidades como controle de clientes, veículos, mecânicos e serviços executados.

# Estrutura do Projeto
Modelagem de Dados : O projeto contém um diagrama ER que define as principais entidades do sistema, como Clientes, Mecânicos, Ordens de Serviço, Serviços e Peças.

# Views:
View_Cliente_Ordens: Restringe o acesso dos clientes para que visualizem apenas suas próprias ordens de serviço. 
View_Mecanico_Ordens: Restringe os mecânicos para visualizarem apenas as ordens atribuídas a eles. 
View_Gerente_Ordens: Permite aos gerentes uma visão mais ampla das ordens de serviço, mas sem expor detalhes financeiros.

# Triggers:
Before Delete: Gatilho que armazena informações de clientes removidos. 
Before Update: Gatilho que registra o histórico de alterações salariais. 
Before Insert: Gatilho que define um salário padrão para novos colaboradores.
