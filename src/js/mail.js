//'use strict';

var inbox = require('inbox');
var iconv = require('iconv');
var conv = new iconv.Iconv("ISO-2022-JP", "UTF-8");
var mail_address = process.env.MAIL_ADDRESS
var mail_pass = process.env.MAIL_PASSWORD

const simpleParser = require('mailparser').simpleParser;

var client = inbox.createConnection(false, 'imap.gmail.com', {
    secureConnection: true
    ,auth: {
      user: (mail_address),
      pass: (mail_pass),
    }
});

client.on('connect', function() {
    console.log('connected');
    client.openMailbox('INBOX', function(error) {
        if (error) throw error;
    });
});


client.on("new", function(message) {
  var tmp = [];

    //ruby実行
    const exec = require('child_process').exec;
    exec('source ../shell/open.sh', (err, stdout, stderr) => {
      if (err) { console.log(err); }
      console.log(stdout);
    });

  client.createMessageStream(message.UID).on("data", function(data){
     var body = conv.convert(data).toString();
        });

});
client.connect();
