# BN Digital Container Registry

## Contents

### Build

#### NodeJS

[Dockerfile](images/build/Dockerfile)

This image used for assembling NodeJS-based applications. Includes Yarn 3 cached packages from `package.json` as [@bn-digital](https://github.com/bn-digital) technology stack foundation.

### Runtime

#### HTML

[Dockerfile](images/runtime/Dockerfile)

```dockerfile
FROM nginx/unit:${unit_version}-minimal AS html
```

#### NodeJS

[Dockerfile](images/runtime/Dockerfile)

```dockerfile
FROM node:${nodejs_version}-bullseye-slim AS nodejs
```

#### PHP

[Dockerfile](images/runtime/Dockerfile)

```dockerfile
FROM nginx/unit:${unit_version}-php${php_version} AS php
```
