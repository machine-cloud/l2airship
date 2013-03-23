#

UrbanAirship = require 'urban-airship'

ua = new UrbanAirship process.env.URBANAIRSHIP_DEV_APP_KEY,
  process.env.URBANAIRSHIP_DEV_SECRET,
  process.env.URBANAIRSHIP_DEV_MASTER_SECRET

ALERT_MSG = "Your ThermoStat has been recalled! Please contact the manufacturer"

exports.log_drain = (req, res) ->
  req.body.map (line) ->
    if line.recall
      payload =
        device_tokens: [line.push_token]
        aps:
          alert: ALERT_MSG
      ua.pushNotification '/api/push', payload, (err) ->
        console.log(err) if err
    else
      console.log('no-recall=true')

  res.send('OK')
