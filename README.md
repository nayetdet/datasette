# AntiMeta Dashboard

Dashboard containerizado com [Datasette](https://datasette.io/) para explorar a base SQLite do AntiMeta. O projeto foi pensado para rodar com Docker, publicar uma imagem no GHCR e montar a base localmente a partir da pasta `data/`.

## Visão geral

Este repositório entrega:

- uma imagem baseada em `datasetteproject/datasette`
- plugins `datasette-plot`, `datasette-vega` e `datasette-search-all`
- execução via Docker Compose com volume bind para a pasta `data/`
- workflow do GitHub Actions para build e publicação da imagem no GHCR

## Estrutura do projeto

```text
.
├── .env.example
├── .github/workflows/build.yml
├── data/
├── docker-compose.yml
├── Dockerfile
└── README.md
```

## Pré-requisitos

- Docker
- Docker Compose
- um arquivo SQLite disponível em `data/database.sqlite`

## Importante

Este projeto **não cria uma base demo automaticamente**. Antes de subir o container, coloque sua base SQLite em `data/database.sqlite`. Se o arquivo não existir, o Datasette não terá o que servir.

## Configuração

1. Copie o arquivo de ambiente:

```bash
cp .env.example .env
```

2. Garanta que a base exista no caminho abaixo:

```text
data/database.sqlite
```

O `.env.example` define atualmente:

```env
TZ=America/Fortaleza
```

## Executando com Docker Compose

O `docker-compose.yml` usa a imagem publicada em `ghcr.io/garapatech/antimeta-dashboard:latest`.

```bash
docker compose up -d
```

Depois, acesse:

```text
http://localhost:6767
```

Para parar os containers:

```bash
docker compose down
```

## Build local da imagem

Se você estiver alterando o `Dockerfile` ou quiser testar a imagem localmente, faça o build manual:

```bash
docker build -t antimeta-dashboard .
```

Depois execute o container montando a pasta `data/`:

```bash
docker run --rm \
  -p 6767:6767 \
  -e TZ=America/Fortaleza \
  -v "$PWD/data:/app/data" \
  antimeta-dashboard
```

## Plugins instalados no Datasette

O `Dockerfile` instala os seguintes plugins:

- `datasette-plot`
- `datasette-vega`
- `datasette-search-all`

## Publicação da imagem

O workflow [`.github/workflows/build.yml`](.github/workflows/build.yml) publica a imagem no GitHub Container Registry quando há push para `main` com alterações em:

- `.github/**`
- `.dockerignore`
- `Dockerfile`

As tags publicadas são:

- `ghcr.io/garapatech/antimeta-dashboard:latest`
- `ghcr.io/garapatech/antimeta-dashboard:sha-<commit>`

## Observações

- A pasta `data/` é ignorada pelo Git, então a base SQLite não é versionada.
- A porta exposta pela aplicação é `6767`.
- O volume montado no container aponta para `/app/data`.
