
###
Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
routes  = require("./log_drain")
logplex = require("./logplex")

UrbanAirship = require 'urban-airship'

ua = new UrbanAirship process.env.URBANAIRSHIP_PROD_APP_KEY,
  process.env.URBANAIRSHIP_PROD_SECRET,
  process.env.URBANAIRSHIP_PROD_MASTER_SECRET

app = express()

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.methodOverride()
  # LogPlex body parser
  app.use logplex()
  app.use express.bodyParser()
  app.use app.router
###
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.static(path.join(__dirname, "public"))
###

app.configure "development", ->
  app.use express.errorHandler()

# Connect Routes
app.post "/logs", routes.log_drain
app.get  "/", (req, res) -> res.send("NOTHING TO SEE HERE")

app.get "/case/updated", (req, res) ->
  console.log "query", req.query
  push_token = process.env.PUSH_TOKEN
  payload =
    device_tokens: [push_token]
    aps:
      alert: "We have corrected an issue with your device and it should now be working."
      badge: 0
      sound: (process.env.ALERT_SOUND || "default")
  ua.pushNotification "/api/push", payload, (err) ->
    console.log "notified token=#{push_token}"
    res.send "ok"

# Listen for Requests
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
