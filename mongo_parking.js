var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://user1:HGIVpgPmagyprlFQ@parkingdata-shard-00-00-nf78h.mongodb.net:27017,parkingdata-shard-00-01-nf78h.mongodb.net:27017,parkingdata-shard-00-02-nf78h.mongodb.net:27017/test?ssl=true&replicaSet=ParkingData-shard-0&authSource=admin"
var bodyParser = require('body-parser');

var priorityQueue = require('js-priority-queue');
const get = require('simple-get');

var express = require('express');
var app = express();
app.use(bodyParser.json());     
app.use(bodyParser.urlencoded({ extended: false }));


//set up Priority Queue
var compareNumbers = function(a, b) { return b - a; };
var queue = new priorityQueue({ comparator: compareNumbers });

for(var i = 1; i <= 10; i++){
	queue.queue(i);
}

var server = app.listen(3000, function(){
	console.log("listening to requests on 3000");
});


//Request
//Create a car object
app.post('/request', function(req, res) {
	var carId = req.body.carId;
	var beacon = req.body.beacon;
	var parkingSpot = queue.dequeue();
	var page;

	MongoClient.connect(url, function(err, db){
		if (err) throw err;

		var dbo = db.db("ParkingInformation");

		var car_obj = { carId: carId, parkingSpot: parkingSpot, isParked: false, beacon: beacon };

		dbo.collection("Cars").insertOne(car_obj, function(err, res){
			if (err) throw err;
			console.log("inserted");
			db.close();
		});
	});

	//set left, right, or straight at screen1
	if(parkingSpot === 1 || parkingSpot === 3 || parkingSpot === 5){
		page = 2;
	}
	else if(parkingSpot === 2 || parkingSpot === 4 || parkingSpot === 6){
		page = 1;
	}
	else{
		page = 3;
	}

	var screenUrl1 = 'http://345f7faa.ngrok.io' + '/pages/' + page.toString();
	get(screenUrl1, function (err, res) {
	  if (err) throw err
	  console.log(res.statusCode) // 200
	  // res.pipe(process.stdout) // `res` is a stream
	});

	// const opts = {
	//   url: 'http://api.reimaginebanking.com/accounts/5aca0a04f0cec56abfa40631/purchases?key=1334c0eeb5e2216fb0cc61c43038eb26',
	//   body: {
	// 	  "merchant_id": "5aca0b0ef0cec56abfa40632",
	// 	  "medium": "balance",
	// 	  "purchase_date": "2018-04-08",
	// 	  "amount": 1,
	// 	  "status": "pending",
	// 	  "description": "first purchase"
	// 	}
	// }
	// get.post(opts, function (err, res) {
	//   if (err) throw err
	//   res.pipe(process.stdout) // `res` is a stream 
	// });

	// get('http://api.reimaginebanking.com/accounts/5aca0a04f0cec56abfa40631?key=1334c0eeb5e2216fb0cc61c43038eb26', function (err, res) {
	//   if (err) throw err
	//   console.log(res.statusCode) // 200 
	//   if(res.balance === 0){
	//   	console.log("There are no more parking spots left.");
	//   }
	// });


	res.send((parkingSpot).toString()); //sends back parking space
});


//Beacon Request
app.post('/beaconPast', function(req, res){
	var parkingSpot = req.body.parkingSpot;
	var page;

	//send get request to beacon
	var lightUrl = 'http://f421d765.ngrok.io/' + 'runPin/' + parkingSpot.toString();
	
	get(lightUrl, function (err, res) {
	  if (err) throw err
	  console.log(res.statusCode) // 200
	  // res.pipe(process.stdout) // `res` is a stream
	});

	

	res.send("");

});

//Screen2 Request
app.post('/beaconFuture', function(req, res){
	var parkingSpot = req.body.parkingSpot;
	var page;

	console.log("beacon future: " + parkingSpot);

	//set left, right, or straight at screen2
	if(parkingSpot === '10' || parkingSpot == '8'){
		page = 1;
	}
	else if(parkingSpot === '9' || parkingSpot == '7' ){
		page = 2;
	}
	else{
		page = 4;
	}

	//console.log(parkingSpot);

	var screenUrl2 = 'http://1032969c.ngrok.io/' + 'pages/' + page.toString();
	get(screenUrl2, function (err, res) {
	  if (err) throw err
	  console.log(res.statusCode) // 200
	  // res.pipe(process.stdout) // `res` is a stream
	});

	res.send("");
});


//Park Car
app.post('/park', function(req, res) {
	var carId = req.body.carId;
	console.log(carId);
	var parkingSpot;

	MongoClient.connect(url, function(err, db){
		if (err) throw err;

		var dbo = db.db("ParkingInformation");

		var query = { carId: carId };
		var new_values = { $set: {isParked: true} };

		dbo.collection("Cars").updateOne(query, new_values, function(err, res){
			if (err) throw err;
			console.log("updated isEmpty");
			db.close();
		});

	});

	res.send("");
});



//Leave Car
app.post('/leave', function(req, res) {
	var carId = req.body.carId;
	var parkingSpot;

	MongoClient.connect(url, function(err, db){
		if (err) throw err;
		
		var dbo = db.db("ParkingInformation");

		var query = { carId: carId };
		var new_values = { $set: {isParked: false}  };

		dbo.collection("Cars").updateOne(query, new_values, function(err, res){
			if (err) throw err;
		});

		dbo.collection("Cars").findOne(query, function(err, res){
			if (err) throw err;
			console.log(res);
			queue.queue(res.parkingSpot);
			parkingSpot = res.parkingSpot;

			//turn off LED
			var kill = 'http://f421d765.ngrok.io/' + 'killPin/' + parkingSpot.toString(); 
			get(kill, function (err, res) {
			  if (err) throw err
			  console.log(res.statusCode) // 200
			  // res.pipe(process.stdout) // `res` is a stream
			});

			db.close();
		});
	});

	// const opts = {
	//   url: 'http://api.reimaginebanking.com/accounts/5aca0a04f0cec56abfa40631/deposits?key=1334c0eeb5e2216fb0cc61c43038eb26',
	//   body: {
	// 	  "medium": "balance",
	// 	  "transaction_date": "2018-04-08",
	// 	  "status": "pending",
	// 	  "amount": 1.0,
	// 	  "description": "first deposit"
	// 	}
	// }
	// get.post(opts, function (err, res) {
	//   if (err) throw err
	//   res.pipe(process.stdout) // `res` is a stream 
	// });

	res.send("");
});

server.listen(3000);
