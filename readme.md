apos descompactar a pasta acesse a pasta que comtem os arquivos preparaVpsNova.sh e adicionarInstancia_peloNome-v3.sh

execute os comandos

>chmod x preparaVpsNova.sh

>nano preparaVpsNova.sh  ##Altere a variavel de acordo com a senha da sua preferencia mysqlRootPassword

>./preparaVpsNova.sh

>chmod x  adicionarInstancia_peloNome-v3.sh

>cp adicionarInstancia_peloNome-v3.sh /home/deploy/setup

>cd /home/deploy/setup

>nano adicionarInstancia_peloNome-v3.sh ##altere as variaveis de sua preferencia dominio subdominio etc

>./adicionarInstancia_peloNome-v3.sh

utilize o cloudflare apontando o ip para os subdomio que aparece ao final do comando
