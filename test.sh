curl -X POST --header 'Content-Type: application/logplex-1' -d "foo=bar" http://localhost:5000/logs
curl -X POST --header 'Content-Type: application/logplex-1' -d "recall=true push_token=fudge" http://localhost:5000/logs
