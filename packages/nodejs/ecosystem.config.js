module.exports = [
  {
    script: "app.js",
    name: process.env.APP_NAME,
    exec_mode: "cluster",
    instances: 1,
    watch: false,
    cwd: "/usr/local/src",
    env: {
      STRAPI_DISABLE_UPDATE_NOTIFICATION: true,
      STRAPI_HIDE_STARTUP_MESSAGE: true,
      STRAPI_TELEMETRY_DISABLED: true,
      BROWSER: false,
    },
  },
];
