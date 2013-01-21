###
  mailUtil
###
email  = require 'emailjs/email'
jade   = require 'jade'
fs     = require 'fs'
config = require '../config'

# mail server
server  = email.server.connect config.email

# mess Object
message =
    text:    "i hope this works"
    from:    "q596392912@126.com"
    to:      "596392912@qq.com"
#    cc:      "else@gmail.com",
    subject: "testing emailjs"
    attachment:
        [
            data:"<html>i <i>hope</i> this works!</html>", alternative:true
#            , {path:"path/to/file.zip", type:"application/zip", name:"renamed.zip"}
        ]

# send the message and get a callback with an error or details of the message that was sent
# server.send(message, function(err, message) { console.log(err || message) })
###
  use user.email 
      user.nick_name 
  and code    
###
exports.sendSignup = (user, code) ->
    path = __dirname + '/../../views/mail_template/signup_send.jade'
    str = fs.readFileSync(path, 'utf8')
    fn = jade.compile str, filename: path, pretty: true 
    baseUrl = config.domain
    verifyUrl = baseUrl + '/finish?code=' + code
    actual = fn user: user.nick_name, baseUrl: baseUrl, verifyUrl: verifyUrl 
    
    message.to = user.email
    message.text = "欢迎加Snode社区"
    message.subject = "欢迎加Snode社区"
    message.attachment[0].data = actual.trim()
    server.send message, (err, message) ->
        console.log err if err
        
###
  mail url
###  
exports.emailUrl = (mail) ->
    url = 'http://'
    if mail.indexOf('mail') isnt -1
        url += mail.substr mail.indexOf('@') + 1, mail.length
    else
        url += 'mail.' + mail.substr mail.indexOf('@') + 1, mail.length
    url