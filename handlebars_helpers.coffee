Handlebars = require 'handlebars'

Handlebars.registerHelper 'eq', (x, y, opt) ->
 if x is y
  return opt.fn(this)
 else
  return ""

Handlebars.registerHelper 'neq', (x, y, opt) ->
 if x isnt y
  return opt.fn(this)
 else
  return ""


Handlebars.registerHelper 'has', (x, opt) ->
 if this[x]?
  return opt.fn(this)
 else
  return ""

Handlebars.registerHelper "loop", (arr, options) ->
# if options.inverse and not arr.length
#  return options.inverse this

 res = ""
 for item, idx in arr
  if (typeof item) isnt 'object'
   item = {value: item}
  item.$index = idx
  item.$first = idx is 0
  item.$last  = idx is arr.length - 1
  res += options.fn item

 return res

Handlebars.registerHelper "for", (obj, options) ->
# if options.inverse and not arr.length
#  return options.inverse this

 res = ""
 key = null
 item = null
 idx = -1
 for k, v of obj
  if idx >= 0
   if (typeof item) isnt 'object'
    item = {value: item}

   item.$key = key
   item.$index = idx
   item.$first = idx is 0
   item.$last  = false
   res += options.fn item

  idx++
  item = v
  key = k

 if idx >= 0
  if (typeof item) isnt 'object'
   item = {value: item}

  item.$key = key
  item.$index = idx
  item.$first = idx is 0
  item.$last  = true
  res += options.fn item

 return res

Handlebars.registerHelper "merge", (x, y, options) ->
 r = {}
 for k, v of x
  r[k] = v
 for k, v of y
  r[k] = v

 return options.fn r

Handlebars.registerHelper "of", (obj, idx, options) ->
 return options.fn obj[idx]

#Normal Helpers
Handlebars.registerHelper "keyCount", (obj) ->
 count = 0
 for k of obj
  count++

 return count

Handlebars.registerHelper "firstName", (str) ->
 str.split(" ")[0]
