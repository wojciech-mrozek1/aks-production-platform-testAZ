const express = require("express");
const os = require("os");

const app = express();
const port = process.env.PORT || 3000;

const appName = process.env.APP_NAME || "test-app";
const appEnv = process.env.APP_ENV || "test";
const appVersion = process.env.APP_VERSION || "dev";

app.get("/", (req, res) => {
  res.json({
    app: appName,
    environment: appEnv,
    version: appVersion,
    status: "running",
    hostname: os.hostname(),
    uptime: process.uptime()
  });
});

app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok" });
});

app.get("/ready", (req, res) => {
  res.status(200).json({ status: "ready" });
});

app.get("/live", (req, res) => {
  res.status(200).json({ status: "alive" });
});

app.listen(port, () => {
  console.log(`${appName} listening on port ${port}`);
});