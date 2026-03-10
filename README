# Downsub - Baixador de Legendas OpenSubtitles

Um script interativo em Bash para buscar, selecionar e baixar legendas de filmes diretamente do [https://www.opensubtitles.org/] usando a linha de comando.

## Funcionalidades

* **Busca Rápida:** Encontra legendas com base no nome do filme e no idioma desejado.
* **Seleção Interativa:** Lista todas as opções de legendas encontradas e permite que o usuário escolha qual versão baixar.
* **Download Automático:** Baixa a legenda selecionada em formato `.zip` diretamente para o diretório especificado.
* **Menu de Ajuda Integrado:** Facilita o uso para novos usuários.

---

## Pré-requisitos

O script foi desenvolvido para sistemas baseados em Unix (Linux, macOS) e utiliza ferramentas que geralmente já vêm instaladas por padrão na maioria das distribuições:

* `bash`
* `curl` (para realizar as requisições web)
* `grep`, `awk`, `sed`, `tr` (para processamento de texto)

---

## Instalação

1. Clone ou baixe o script para a sua máquina.
2. Dê permissão de execução ao arquivo. No terminal, navegue até a pasta onde o script está salvo e execute:

```bash
chmod +x downsub.sh

```

*(Nota: Assumindo que o nome do seu arquivo seja `downsub.sh`. Altere se necessário).*

---

## Como usar

A sintaxe básica do programa exige três argumentos obrigatórios:

```bash
./downsub.sh <nome_do_filme> <idioma> <diretorio_de_saida>

```

### Argumentos:

* **`<nome_do_filme>`**: O título do filme que você deseja buscar. **Importante:** Se o nome do filme tiver espaços, coloque-o entre aspas (ex: `"The Matrix"`).
* **`<idioma>`**: O código do idioma desejado para a legenda. O OpenSubtitles geralmente usa códigos de três letras (ex: `pob` para Português do Brasil, `eng` para Inglês, `spa` para Espanhol).
* **`<diretorio_de_saida>`**: O caminho da pasta onde o arquivo `.zip` da legenda deverá ser salvo (ex: `/home/usuario/Downloads` ou `.` para o diretório atual).

### Comandos de Ajuda:

Para ver as instruções de uso diretamente no terminal, você pode usar qualquer um dos comandos abaixo:

```bash
./downsub.sh help
./downsub.sh -h
./downsub.sh --help

```

---

## Exemplos Práticos

**1. Baixando uma legenda em Português do Brasil para a pasta Downloads:**

```bash
./downsub.sh "Inception" pob ~/Downloads

```

**2. Baixando uma legenda em Inglês para a pasta atual (`.`):**

```bash
./downsub.sh "The Godfather" eng .

```

Ao executar o comando, o script irá exibir uma lista numerada de legendas encontradas. Basta digitar o número correspondente à legenda que você deseja e pressionar `Enter`. O arquivo `.zip` será baixado na pasta escolhida.

---

## Observações

* Como o script faz a raspagem de dados (*web scraping*) da página HTML do OpenSubtitles, mudanças drásticas na estrutura do site podem quebrar o funcionamento da busca.

