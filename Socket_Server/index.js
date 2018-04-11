var express = require('express');
var socket = require('socket.io');


var app = express();
var server = app.listen(4000, function(){
	console.log("listening to requests on 4000");
});


app.use(express.static('public'));


//socket setup
var io = socket(server);

io.on('connection', function(socket){
	console.log("here");
});

app.get('/pages/:param1', function(req, res){
	console.log('made socket get');

	io.emit('numnode', (req.params));  //all of the socket

	res.send("made it");

});

server.listen(4000);