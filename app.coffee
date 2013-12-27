#!/usr/bin/env coffee

email = require './email'
d3 = require 'd3'
fs   = require 'fs'
YAML = require "yamljs"
args = require('optimist').argv
Handlebars  = require('handlebars')

console.log args.name
unless args.user? and args.password? and args.name? and args.template? and args.csv?
 console.log "please provide --user, --password, --name, --template, --csv, --subject"
 process.exit 1

email.create args.user, args.password, args.name


csv = d3.csv.parse (fs.readFileSync args.csv).toString()
subject = Handlebars.compile args.subject
text = Handlebars.compile (fs.readFileSync args.template).toString()
if args.html?
 html = Handlebars.compile (fs.readFileSync args.html).toString()

for line in csv
 if line.Email?
  line.email = line.Email

n = 0
sendMail = ->
 if n >= csv.length
  console.log "Done"
  process.exit 0

 if n > 0 and n % 10 is 0
  console.log "#{n}/#{csv.length}"

 line = csv[n]
 ++n

 opt =
  to: line.email
  subject: subject line
  text: text line
 if html?
  opt.html = text html

 console.log opt

 email.send opt, sendMail

sendMail()
