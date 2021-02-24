Através do botão abaixo é possível importar o workspace do Insomnia:   
[![Run in Insomnia}](https://insomnia.rest/images/run.svg)](https://insomnia.rest/run/?label=APIExternaPVW&uri=https%3A%2F%2Fraw.githubusercontent.com%2Ffarmaponte%2Fapi-externa-pvw%2Fmaster%2F_dev%2Finsomnia.json)

# Adonis API application

This is the boilerplate for creating an API server in AdonisJs, it comes pre-configured with.

1. Bodyparser
2. Authentication
3. CORS
4. Lucid ORM
5. Migrations and seeds

## Setup

Use the adonis command to install the blueprint

```bash
adonis new yardstick --api-only
```

or manually clone the repo and then run `npm install`.


### Migrations

Run the following command to run startup migrations.

```js
adonis migration:run
```
