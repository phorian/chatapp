require('dotenv').config();
var express = require('express');
var mongoose = require('mongoose');
var bodyParser = require('body-parser');
var connectDB = require('./dbConn');
var PORT = process.env.PORT || 3000;
var message = require('./model/message');
var app = express();

//Use application service
app.use(express.static(__dirname));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

//Connect database
connectDB();

//Create Routes
app.get('/messages', (req, res) => {
    message.find({},(err, messages => {
        res.send(messages)
    }))
})

app.post('/messages', (req, res)=> {
    var message = new message(req.body);
    message.save((err) => {
        if(err)
        sendStatus(500);
    res.sendStatus(200);
    })
})

mongoose.connection.once('open', () => {
    console.log('Connected to mongoDB')
app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
});