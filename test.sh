curl -X POST --header 'Content-Type: application/logplex-1' -d "foo=bar" http://localhost:5000/logs
curl -X POST --header 'Content-Type: application/logplex-1' -d "recall=true push_token=E913EEC9416BBDFF7A24429B512EC20E1503FE54C14518817BC3730AE09D8645" http://localhost:5000/logs
curl -X POST --header 'Content-Type: application/logplex-1' -d "recall=true push_token=FUDGE" http://localhost:5000/logs
