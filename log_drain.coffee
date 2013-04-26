#

UrbanAirship = require 'urban-airship'

ua = new UrbanAirship process.env.URBANAIRSHIP_PROD_APP_KEY,
  process.env.URBANAIRSHIP_PROD_SECRET,
  process.env.URBANAIRSHIP_PROD_MASTER_SECRET

ALERT_MSG = "Your ThermoStat has been recalled! Please contact the manufacturer"

exports.log_drain = (req, res) ->
  req.body.map (line) ->
    if line.recall
      push_token = line.push_token || process.env.PUSH_TOKEN
      payload =
        device_tokens: [push_token]
        aps:
          alert: ALERT_MSG
          badge: 0
          sound: (process.env.ALERT_SOUND || "default")
      ua.pushNotification '/api/push', payload, (err) ->
        console.log "push-notification=#{push_token}"
        console.log(err) if err

  res.send('OK')
