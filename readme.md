***Criei um instalador rápido que utilizo para subir minhas múltiplas instancias de whaticket e gostaria de compartilhar com a comunidade, facilita muito o processo de subir uma instancia nova***
- Cria o banco de dados de forma automática
- Configura o nginx de forma automática
- Configura o serviço PM2 de forma automática
- Você pode utilizar com o repositório de sua preferência procure e altere esta linha no arquivo preparaVpsNova.sh sudo -H -u deploy bash -c "git clone https://github.com/canove/whaticket whaticket"
só precisa informar este parâmetros:

_domain='meudominio.com'_ ## Adicione o seu domínio

_subDomain='meusubdominio'_ ## Adicione o seu sub domínio 

_numberSequencial3Digites='001'_  ## Adicione um número Sequencial com 3 dígitos não pode repetir de 000 a 999

_mysqlTablePassword="minhasenhamysql!"_ ## Adicione a senha que deseja utilizar para tabela do mysql_

**Realizado testes na VPS digital Ocean com 2gb de memoria _maquinas com menos de 2gb de memoria não roda o build do frontend_**
        digite no prompt de comando da sua VPS:

> git clone https://github.com/altemirjosecoelho/whaticket-mult-Intalador-rapido-vps.git instalador
> 
> cd instalador
> 
> sudo chmod +x preparaVpsNova.sh
> 
> sudo chmod +x  adicionarInstancia_peloNome-v3.sh
> 
> sudo nano preparaVpsNova.sh  ##Altere a variavel de acordo com a senha da sua preferencia 
        
        mysqlRootPassword use letras maiusculas minusculas e numeros evite usar / e @

Crtl+x para sair do editor de texto y para salvar

>sudo ./preparaVpsNova.sh
 
        digite uma senha para o usuario deploy que vamos criar durante a instalação
        
        repita a senha
        
        precione enter para todas as opções
        
        Full Name []:
        
        Room Number []:
        
        Work Phone []:
        
        Home Phone []:
        
        Other []:

Is the information correct? [Y/n] >>>>> digite Y nesta opção

>cd /home/deploy/setup

>sudo nano adicionarInstancia.sh      ##altere as variaveis de sua preferencia dominio subdominio etc

        domain='meudominio.com' ## Adicione o seu dominio
        
        subDomain='meusubdominio' ## Adicione o seu sub dominio não pode repetir 
        
        numberSequencial3Digites='001'  ## Adcione um numero Sequencial com 3 digitos não pode repetir de 000 a 999
        
        mysqlTablePassword="minhasenhadatabelamysql" ## Adicone a senha que deseja utilizar para tabela do mysql
        
        mysqlRootPassword="minhasenhaderootmysql"	## Adicone a senha de root para o mysql 

>sudo ./adicionarInstancia.sh

##para adicionar mais uma instancia é só repetir

>cd /home/deploy/setup

>sudo nano adicionarInstancia.sh      ##altere as variaveis de sua preferencia dominio subdominio etc

        domain='meudominio.com' ## Adicione o seu dominio
        
        subDomain='meusubdominio' ## Adicione o seu sub dominio não pode repetir 
        
        numberSequencial3Digites='001'  ## Adcione um numero Sequencial com 3 digitos não pode repetir de 000 a 999
        
        mysqlTablePassword="minhasenhadatabelamysql" ## Adicone a senha que deseja utilizar para tabela do mysql
        
        mysqlRootPassword="minhasenhaderootmysql"	## Adicone a senha de root para o mysql 

>sudo ./adicionarInstancia.sh


utilize o cloudflare apontando o ip para os subdomio que aparece ao final do comando
