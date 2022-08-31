# BN Digital Container Registry

## Contents

### Build

#### NodeJS

[Dockerfile](packages/yarn/Dockerfile)

This image used for assembling NodeJS-based applications. Includes Yarn 3 cached packages from `package.json` as [@bn-digital](https://github.com/bn-digital) technology stack foundation.

### Runtime

#### HTML

[Dockerfile](packages/nodejs/Dockerfile)

```dockerfile
FROM nginx/unit:${unit_version}-minimal AS html
```

#### NodeJS

[Dockerfile](packages/nodejs/Dockerfile)

```dockerfile
FROM node:${nodejs_version}-bullseye-slim AS nodejs
```

#### PHP

[Dockerfile](packages/nodejs/Dockerfile)

```dockerfile
FROM nginx/unit:${unit_version}-php${php_version} AS php
```
