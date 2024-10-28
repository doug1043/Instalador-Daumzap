![Daumzap](/images/banner.png "Daumzap")

## Descrição

O **Instalador Daumzap** oferece várias opções de instalação, seja para servidores VPS, locais ou usando Docker com tunelamento via CloudFlare.

### Recursos:

- Instalação automática e fácil
- Configuração para VPS ou ambientes locais
- Tunelamento CloudFlare integrado para segurança adicional

## Instruções de Instalação


### 🔽 **Download do Script de Instalação**

No terminal do seu servidor, execute os seguintes comandos:

bash

Copiar código
```
git clone https://github.com/doug1043/Instalador-Daumzap.git
cd Instalador-Daumzap
sudo chmod +x run.sh
sudo ./run.sh
```

----------

### 🛠 **Execução do Script**

Após executar o comando `sudo ./run.sh`, o script solicitará as seguintes informações:

#### 1. **Inserir senha para o usuário Deploy e Banco de Dados**

-   **Mensagem**: "Insira senha para o usuário Deploy e Banco de Dados (Não utilizar caracteres especiais)"
-   **Explicação**: Aqui, você define uma senha para o usuário _Deploy_, que será criado no seu servidor e onde o sistema será instalado.

#### 2. **Nome da Instância/Empresa**

-   **Mensagem**: "Informe um nome para a Instância/Empresa (Não utilizar espaços ou caracteres especiais, Utilize letras minúsculas)"
-   **Explicação**: Este nome será usado para definir a pasta do projeto e, no caso de instalação local, também será o nome do domínio personalizado.

#### 3. **Quantidade de Conexões/WhatsApp**

-   **Mensagem**: "Informe a Qtde de Conexões/Whats que a instância poderá cadastrar"
-   **Explicação**: Define quantas conexões de WhatsApp o sistema poderá suportar. Recomenda-se um valor acima de 100.

#### 4. **Quantidade de Usuários/Atendentes**

-   **Mensagem**: "Informe a Qtde de Usuários/Atendentes que a instância poderá cadastrar"
-   **Explicação**: Define o número máximo de atendentes. Recomenda-se acima de 100, mas este valor pode ser alterado posteriormente nas configurações.

----------

### 🌐 **Seleção do Protocolo**

O script perguntará qual protocolo usar:

yaml

Copiar código
```
`🔗 Selecione o protocolo a ser usado:
1) HTTP
2) HTTPS
Digite o número correspondente ao protocolo desejado:` 
```

-   **Nota**: Para instalações locais, escolha sempre HTTP. Para instalações com acesso externo (via VPS ou tunelamento), escolha HTTPS.

----------

### 🌍 **Configuração de Domínios**

-   **Frontend/Painel**: "Digite o domínio do FRONTEND/PAINEL"
-   **Backend/API**: "Digite o domínio do BACKEND/API"

Caso a instalação seja local, o script também pedirá:

-   **Domínio Base**: "Digite o domínio base (por exemplo: suamarca.com)"

O script irá gerar automaticamente os subdomínios necessários (por exemplo, `api.suamarca.com` e `chat.suamarca.com`).

----------

### 🔌 **Configuração de Portas**

-   **Frontend**: "Digite a porta do FRONTEND"
-   **Backend**: "Digite a porta do BACKEND"
-   **Redis/Agendamento**: "Digite a porta do REDIS/AGENDAMENTO MSG" (porta padrão: 6379)

----------

### 🖧 **Configuração de Rede**

Se a instalação for local ou com tunelamento, será solicitado o nome da interface de rede:

-   **Mensagem**: "Interfaces de rede e seus endereços IP atuais"
-   **Explicação**: Digite o nome da interface de rede conectada à internet (por exemplo, _eth0_ ou _wlan0_ para Wi-Fi).

----------

### ☁️ **Tunelamento Cloudflare**

Caso a instalação utilize tunelamento via Cloudflare, o script solicitará:

-   **TOKEN do tunelamento CloudFlare**: "Informe o TOKEN do tunel CloudFlare"
-   **Link do CloudFlare**: "Insira o link de download do CloudFlare"

Além disso, é necessário verificar se o túnel está ativo diretamente no site da CloudFlare.

----------

### 🐳 **Instalação via Docker**

Se a escolha for a geração de imagens Docker, o script criará os arquivos necessários:

-   O conteúdo do arquivo `docker-compose.yaml` será gerado na pasta `/home/deploy`
-   O arquivo `.env` também estará disponível nesta pasta.

Após a criação, basta acessar o Portainer e importar o conteúdo do arquivo `docker-compose.yaml` junto com o `.env` para iniciar o sistema via Docker.

----------

Essas informações detalham cada passo necessário para a instalação do sistema, seja em VPS, localmente, com tunelamento Cloudflare ou via Docker.

## Projeto

Acesse o diretório do projeto disponível no GitHub:  
[Whaticket-Daumzap](https://github.com/doug1043/Whaticket-Daumzap)

## Suporte:

Para mais informações, clique [aqui](https://daumzap.com.br "Daumzap") ou entre em contato por e-mail: contato@daumzap.com.br
