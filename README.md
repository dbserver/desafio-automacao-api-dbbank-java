![Logo](logo.png)

# Desafio Automação DBBank

A API [DBBank](https://bugbank.netlify.app) simula um módulo financeiro, possibilitando registros de contas de usuário que também funcionam como contas bancárias capazes de efetuar transferências de valores monetários para outras contas também registradas.

## Getting started

### Pré-requisitos

- [Git](https://git-scm.com/downloads)

> [!NOTE]
> Em ambientes Windows, confirmar também o correto funcionamento do Git Bash.

### Obtendo o boilerplate Java

O [boilerplate Java para automação de testes de APIs](https://github.com/dbserver/boilerplate-automacao-api-java) contém um conjunto inicial de recursos que possibilitam um rápido e simplificado início de construção de testes automatizados.

Ele é obtido via o script `get_boilerplate.sh`, que também atualiza este arquivo README com as informações sobre configurações necessárias e instruções de execução.

#### 1. Via terminal de comandos (Linux e MacOS)

Tornar o script `get_boilerplate.sh` executável
```shell
chmod +x get_boilerplate.sh
```

Executar o script `get_boilerplate.sh`
```shell
./get_boilerplate.sh
```

#### 2. Via Git Bash (Windows)

Executar o script `get_boilerplate.sh`
```shell
./get_boilerplate.sh
```

## Desafio

### 1. Automation Request

#### Caso de Teste (TC - Test Case):

Registro de uma nova conta de usuário

#### Descrição:

Validar o registro de uma nova conta de usuário através de uma tentativa de acesso bem sucedida.

#### Pré-Condições:

- A API deve estar acessível
- O usuário ainda não deve ter uma conta registrada

#### Passos:

1. Efetuar o registro enviando uma requisição POST para o endpoint de contas com informações válidas do usuário (E-mail, Nome, Senha e Confirmação senha)
  - Certificar-se também de setar a informação de saldo inicial com um valor superior a 0 (zero)
2. Efetuar o acesso da conta do usuário enviando uma requisição POST para o endpoint de acesso com informações válidas da mesma (E-mail e Senha)

#### Resultados Esperados:

- A resposta para a requisição de registro deve conter um [HTTP status code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) [201](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/201)
- A resposta para a requisição de acesso deve conter um [HTTP status code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) [200](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/200), e o [payload](https://developer.mozilla.org/en-US/docs/Glossary/Payload_body) da resposta deve conter em sua estrutura JSON uma propriedade *saldo*, contendo o mesmo valor apontado na requisição de registro

#### Pós-Condições:

- O usuário deve estar com a nova conta registrada e ter a acessado com sucesso

### 2. Automation Request

#### Caso de Teste (TC - Test Case):

Transferência de valores monetários entre contas de usuário

#### Descrição:

Validar em uma conta de usuário destinatária a entrada de um valor monetário proveniente de uma conta de usuário originária.

#### Pré-Condições:

- A API deve estar acessível
- Devem haver duas contas de usuário já registradas (originária e destinatária), tendo a conta originária um *saldo* de R$ 1000,00, e a conta destinatária um *saldo* de R$ 0,00

#### Passos:

1. Efetuar o acesso da conta de usuário originária enviando uma requisição POST para o endpoint de acesso com informações válidas da mesma (E-mail e Senha)
    - Armazenar para utilização futura o token contido na propriedade *accessToken*, localizada na estrutura JSON do [payload](https://developer.mozilla.org/en-US/docs/Glossary/Payload_body) da resposta
2. Realizar uma transferência enviando uma requisição POST para o endpoint de transferências com informações válidas para a sua realização (Número da conta de usuário destinatária, Dígito da conta de usuário destinatária, Valor e Descrição) - O valor deve ser de R$ 500,00
    - Anexar à requisição um [Authorization header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization) de esquema do tipo [bearer](https://swagger.io/docs/specification/authentication/bearer-authentication) contendo o *accessToken* da conta de usuário originária
3. Efetuar a obtenção dos detalhes da conta de usuário originária enviando uma requisição GET para o endpoint de contas
    - Anexar à requisição um [Authorization header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization) de esquema do tipo [bearer](https://swagger.io/docs/specification/authentication/bearer-authentication) contendo o *accessToken* da conta de usuário originária
4. Efetuar o acesso da conta de usuário destinatária enviando uma requisição POST para o endpoint de acesso com informações válidas da mesma (E-mail e Senha)
    - Armazenar para utilização futura o token contido na propriedade *accessToken*, localizada na estrutura JSON do [payload](https://developer.mozilla.org/en-US/docs/Glossary/Payload_body) da resposta
5. Efetuar a obtenção dos detalhes da conta de usuário destinatária enviando uma requisição GET para o endpoint de contas
    - Anexar à requisição um [Authorization header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization) de esquema do tipo [bearer](https://swagger.io/docs/specification/authentication/bearer-authentication) contendo o *accessToken* da conta de usuário destinatária

#### Resultados Esperados:

- O *saldo* contido na estrutura JSON do [payload](https://developer.mozilla.org/en-US/docs/Glossary/Payload_body) da resposta da requisição de obtenção dos detalhes da conta de usuário originária deve ser de R$ 500,00
- O *saldo* contido na estrutura JSON do [payload](https://developer.mozilla.org/en-US/docs/Glossary/Payload_body) da resposta da requisição de obtenção dos detalhes da conta de usuário destinatária deve ser de R$ 500,00

#### Pós-Condições:

- As duas contas de usuário devem estar com valores iguais de *saldo*
