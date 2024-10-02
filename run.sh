#!/bin/bash

printf "  ________  ________  ___  ___  _____ ______   ________  ________  ________   \n";  
printf "|\   ___ \|\   __  \|\  \|\  \|\   _ \  _   \|\_____  \|\   __  \|\   __  \   \n"; 
printf "\ \  \_|\ \ \  \|\  \ \  \ \  \ \  \ \__\ \  \||___/  /\ \  \|\  \ \  \|\  \  \n";
printf " \ \  \  \ \ \   __  \ \  \ \  \ \  \||__| \  \   /  / /\ \   __  \ \   ____\ \n";
printf "  \ \  \_|\ \ \  \ \  \ \  \|\  \ \  \    \ \  \ /  /_/__\ \  \ \  \ \  \___| \n";
printf "   \ \_______\ \__\ \__\ \_______\ \__\    \ \__\|________\ \__\ \__\ \__\    \n";
printf "    \|_______|\|__|\|__|\|_______|\|__|     \|__|\|_______|\|__|\|__|\|__|    \n";
                                                                                                                                                         
printf "                    © Daumzap contato: contato@daumzap.com.br\n";

printf "\n"
printf "\n"

if ! command -v jq &> /dev/null
then
    echo "jq não encontrado, instalando..."
    sudo apt-get update
    sudo apt-get install -y jq
fi

API_URL="https://www.daumzap.com.br/api/v1/validateKey"
TEMP_DIR=$(mktemp -d)
SCRIPT_ENC="system.enc"

APP_SH_PATH="$TEMP_DIR/install-daumzap/variables/_app.sh"

# Solicitar a chave do cliente
read -p "Insira sua chave de acesso: " client_key

# Enviar a chave do cliente para a API e obter a chave de descriptografia
RESPONSE=$(curl -s --max-time 10 -X POST -H "Content-Type: application/json" -d "{\"client_key\":\"$client_key\"}" $API_URL)

if [ $? -ne 0 ]; then
    echo "Sem resposta do servidor, verifique sua conexão com internet. Se o problema continuar, solicite suporte nos canais de atendimentos"
    exit 1
fi

DECRYPT_KEY=$(echo $RESPONSE | jq -r '.decrypt_key')

if [ "$DECRYPT_KEY" == "null" ]; then
    echo "Chave inválida."
    exit 1
fi

# Descriptografar e descompactar os scripts usando a chave retornada
echo "Descriptografando e descompactando os scripts..."
if openssl enc -d -aes-256-cbc -pbkdf2 -salt -in "$SCRIPT_ENC" -out "$TEMP_DIR/project.tar.gz" -k "$DECRYPT_KEY"; then
    echo "OK"
else
    echo "Falha!"
    exit 1
fi

# Descompactar o arquivo
if tar -xzf "$TEMP_DIR/project.tar.gz" -C "$TEMP_DIR"; then
    echo "OK"
else
    echo "Falha!"
    exit 1
fi

# Ajustar permissões dos arquivos no diretório temporário
chmod -R 755 "$TEMP_DIR"

# Verificar se o script de instalação está presente
INSTALL_SCRIPT="$TEMP_DIR/install-daumzap/install_system"

if [ ! -f "$INSTALL_SCRIPT" ]; then
    echo "ERRO ARCHIVES"
    exit 1
fi

# Verificar se a chave já existe no arquivo _app.sh e atualizar
if grep -q "^client_key=" "$APP_SH_PATH"; then
    # Substituir o valor existente de client_key
    sed -i "s|^client_key=.*|client_key=\"$client_key\"|" "$APP_SH_PATH"
else
    # Adicionar client_key se ela não existir
    echo "client_key=\"$client_key\"" >> "$APP_SH_PATH"
fi

# Executar o script principal de instalação com permissões elevadas
echo "Executando o script instalação..."
sudo bash "$INSTALL_SCRIPT"

# Limpar o diretório temporário após a execução
rm -rf "$TEMP_DIR"

echo "Instalação concluída com sucesso."