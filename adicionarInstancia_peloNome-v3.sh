#! /bin/sh
domain='meudominio.com' ## Adicione o seu dominio
subDomain='meusubdominio' ## Adicione o seu sub dominio 
numberSequencial3Digites='001'  ## Adcione um numero Sequencial com 3 digitos não pode repetir de 000 a 999
mysqlTablePassword="minhasenhamysql!" ## Adicone a senha que deseja utilizar para tabela do mysql
mysqlRootPassword="senharootmysql"	## Adicone a senha de root para o mysql 





instName="${subDomain}"
backendName="${instName}api"
backendPort="9${numberSequencial3Digites}"
frontendPort="3${numberSequencial3Digites}"






echo 'please enter mysql root user password'cd 

mysql -u root -p${mysqlRootPassword} -B -N -e "
    CREATE USER '${instName}'@'%' IDENTIFIED BY '${mysqlTablePassword}';
    CREATE DATABASE ${instName} character set UTF8mb4 collate utf8mb4_bin;
    GRANT ALL PRIVILEGES ON ${instName}.* TO ${instName}@'%';
    FLUSH PRIVILEGES;
"
sudo -H -u deploy bash -c "cp -r /home/deploy/setup/whaticket/ /home/deploy/${instName}" 
cat > /home/deploy/${instName}/backend/.env << EOF1
NODE_ENV=
BACKEND_URL=https://$backendName.$domain
FRONTEND_URL=https://$instName.$domain
PROXY_PORT=443
PORT=$backendPort
DB_DIALECT=mysql
DB_HOST=127.0.0.1
DB_USER=$instName
DB_PASS=$mysqlTablePassword
DB_NAME=$instName
JWT_SECRET=3123123213123
JWT_REFRESH_SECRET=75756756756
EOF1

sudo -H -u deploy bash -c "npm install --prefix /home/deploy/${instName}/backend"
sudo -H -u deploy bash -c "npm run build --prefix /home/deploy/${instName}/backend"
cd /home/deploy/${instName}/backend/
npx sequelize db:migrate
npx sequelize db:seed:all


cd /home/deploy/${instName}/frontend
sudo -H -u deploy bash -c "npm install"

cat > /home/deploy/${instName}/frontend/.env << EOF1

REACT_APP_BACKEND_URL = https://$backendName.$domain

EOF1

cat > /home/deploy/${instName}/frontend/server.js<< EOF1


//simple express server to run frontend production build;
const express = require("express");
const path = require("path");
const app = express();
app.use(express.static(path.join(__dirname, "build")));
app.get("/*", function (req, res) {
	res.sendFile(path.join(__dirname, "build", "index.html"));
});
app.listen($frontendPort);

EOF1

cd /home/deploy/${instName}/frontend
sudo -H -u deploy bash -c "npm run build"
cd /home/deploy/${instName}/backend/
sudo -H -u deploy bash -c "pm2 start dist/server.js --name ${instName}-port-${frontendPort}"
cd /home/deploy/${instName}/frontend/
sudo -H -u deploy bash -c "pm2 start server.js --name ${backendName}-port-${backendPort}"
sudo -H -u deploy bash -c "pm2 save"




cat > /etc/nginx/sites-available/${instName}-port-${frontendPort} << EOF1

server {
server_name $instName.$domain;

  location / {
    proxy_pass http://127.0.0.1:$frontendPort;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-Proto \$scheme;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_cache_bypass \$http_upgrade;
  }
}




EOF1

cat > /etc/nginx/sites-available/${backendName}-port-${backendPort} << EOF1

server {
  server_name $backendName.$domain;

  location / {
    proxy_pass http://127.0.0.1:$backendPort;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-Proto \$scheme;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_cache_bypass \$http_upgrade;
}
}

EOF1

sudo ln -s /etc/nginx/sites-available/${instName}-port-${frontendPort} /etc/nginx/sites-enabled
sudo ln -s /etc/nginx/sites-available/${backendName}-port-${backendPort} /etc/nginx/sites-enabled


sudo nginx -t
sudo service nginx restart

echo "please set the domain to your vps IP :$backendName.$domain"
echo "please set the domain to your vps IP :$instName.$domain"
