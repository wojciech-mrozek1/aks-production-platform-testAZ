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

// Health check (basic)
app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok" });
});

// Readiness check
app.get("/ready", (req, res) => {
  res.status(200).json({ status: "ready" });
});

// Liveness check
app.get("/live", (req, res) => {
  res.status(200).json({ status: "alive" });
});

// Optional debug endpoint
app.get("/env", (req, res) => {
  res.json({
    APP_NAME: process.env.APP_NAME || null,
    APP_ENV: process.env.APP_ENV || null,
    APP_VERSION: process.env.APP_VERSION || null,
    PORT: process.env.PORT || null
  });
});

app.listen(port, () => {
  console.log(`${appName} listening on port ${port}`);
});
