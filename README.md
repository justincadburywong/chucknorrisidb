[![CircleCI Status](https://circleci.com/gh/justincadburywong/chucknorrisidb.svg?style=shield&circle-token=05adecf9e64d82c61e14d0ce95feadf97ffd64b5)](https://circleci.com/gh/justincadburywong/chucknorrisidb)
[![Build Status](https://travis-ci.org/justincadburywong/chucknorrisidb.svg?branch=master)](https://travis-ci.org/justincadburywong/chucknorrisidb)
[![Coverage Status](https://coveralls.io/repos/github/justincadburywong/chucknorrisidb/badge.svg?branch=master)](https://coveralls.io/github/justincadburywong/chucknorrisidb?branch=master)

# ChuckNorrisIDB
An SMS service that sends Chuck Norris jokes to your phone via the Chuck Norris Internet Database API and Twilio.

# How To Use
Send a text message to 1-415-275-2620.  Receive joke.

You can also send the word 'nerdy' to get a nerdy joke, or the word 'dirty' for a dirty joke.  Just remember, thousands of people die every year from Chuck Norris joke related incidents.

# How It Works
An SMS message is sent to the phone number above.  Twilio sends a webhook request to this API written in Ruby on Sinatra, which reaches out to the Internet Chuck Norris Database, retrieves a JSON payload, and sends it back to Twilio, to be delivered to your SMS enabled device.

<img src="ChuckNorrisIDB.png" width="800px" alt="flowchart">

<img src="chuck-norris-dont-write-code.jpg" width="800px" alt="chuck_norris">
