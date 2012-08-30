
- Start a new browser session:
curl -i --data '{"desiredCapabilities":{"browserName":"firefox","version":"","platform":"ANY","javascriptEnabled":true}}'  http://localhost:4444/wd/hub/session
//Need to get sessionId from response header?

- Go to http://google.com
curl -i --data '{"url"="http://google.com"}'  http://localhost:4444/wd/hub/session/1346240826525/url



- Type "monk" into q
curl -i --data '{"using"="name","value"="q"}' http://localhost:4444/wd/hub/session/1346245302141/element/
//Look for 'ELEMENT'='N' item in returned json 
curl -i --data '{"value"=["m","o","n","k"]}' http://localhost:4444/wd/hub/session/1346245302141/element/0/value

//Try id, name, css, etc. Try/catch in C?


End session
curl -i -H "Accept: application/json" -X DELETE http://localhost:4444/wd/hub/session/1346240826525/url



