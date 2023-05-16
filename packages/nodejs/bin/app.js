#!/usr/bin/env node
const strapi = require("@strapi/strapi");
const fs = require("fs");
const path = require("path");

const uploadDir = path.join(process.cwd(), "public", "uploads");

fs.existsSync(uploadDir) || fs.mkdirSync(uploadDir, { recursive: true });

strapi().start();
