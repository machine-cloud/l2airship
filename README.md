# l2airship
#### Create Apple Push notifications via Urban Airship when devices are recalled

Coffeescript HTTP LogPlex bouncer.

This log drain looks for log lines with `recall=true` and uses the `push_token`
in the log line to send a push notification to the user, alerting
them their device has been recalled.


## Install

    > npm install
    > redis-server
    > foreman start web
    > ./test.sh


## ENV

    > heroku addons:add urbanairship

or set

    ALERT_SOUND
    URBANAIRSHIP_DEV_APP_KEY
    URBANAIRSHIP_DEV_MASTER_SECRET
    URBANAIRSHIP_DEV_SECRET


## Special Behavior

For demo purposes, you can set the `PUSH_TOKEN` env var and
all notifications will go to that device.
