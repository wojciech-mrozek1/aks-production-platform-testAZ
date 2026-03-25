const express = require("express");

const app = express();
const port = process.env.PORT || 3000;
const appName = process.env.APP_NAME || "test-app";
const appEnv = process.env.APP_ENV || "test";

app.get("/", (req, res) => {
  res.json({
    app: appName,
    environment: appEnv,
    status: "running",
    hostname: process.env.HOSTNAME || "unknown"
  });
});

app.get("/healthz", (req, res) => {
  res.status(200).send("ok");
});

app.get("/env", (req, res) => {
  res.json({
    APP_NAME: process.env.APP_NAME || null,
    APP_ENV: process.env.APP_ENV || null,
    PORT: process.env.PORT || null
  });
});

app.listen(port, () => {
  console.log(`${appName} listening on port ${port}`);
});
