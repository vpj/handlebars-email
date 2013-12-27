nodemailer = require "nodemailer"

smtpTransport = null
user = null

sendEmail = (mailOptions, cb) ->
 mailOptions.from = "#{user.name} <#{user.email}>"

 smtpTransport.sendMail mailOptions, (err, response) ->
  if err
   console.log err
   cb? false
  else
   console.log "Email sent - #{mailOptions.to}:" + response.message
   cb? true

send = (email, cb) ->
 console.log "Sending mail - #{email.to}"
 mailOptions =
  to: email.to
  subject: email.subject
  text: email.text

 if email.html?
  mailOptions.html = email.html

 sendEmail mailOptions, cb

exports.send = send

exports.create = (email, password, name) ->
 console.log arguments
 user =
  email: email
  password: password
  name: name

 smtpTransport = nodemailer.createTransport "SMTP",
  service: "Gmail"
  auth:
   user: email
   pass: password


