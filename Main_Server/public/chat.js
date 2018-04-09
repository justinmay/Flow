var socket = io.connect("http://1032969c.ngrok.io"); // <--- Change Before

var output = document.getElementById('output');


//Listen for events
socket.on('numnode', function(data){
	console.log(data.param1);
	if(data.param1 === '1'){
		output.innerHTML = '<img src="/Turn_Left.png" style="width:100%; height:100vh"/>';
	}
	else if(data.param1 === '2'){
		output.innerHTML = '<img src="/Turn_Right.png" style="width:100%; height:100vh"/>';
	}
	else if(data.param1 === '3'){
		output.innerHTML = '<img src="/Go_Straight.png" style="width:100%; height:100vh"/>';
	}  else {
        output.innerHtml = '';
    }
	//else return error
});

server.listen(4000);
