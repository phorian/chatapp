require('dotenv').config();
var express = require('express');
var mongoose = require('mongoose');
var bodyParser = require('body-parser');
var connectDB = require('./config/dbConn');
var PORT = process.env.PORT || 3000;
var message = require('./model/message');
var http = require('http').Server(app);
var io = require('socket.io')(http);
var app = express();

//Use application service
app.use(express.static(__dirname));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

//Connect database
connectDB();

//create socket.io connection
io.on('connection', (socket) =>{
    console.log('a user is connected', socket.id);
    socket.on('disconnect', () => {
      console.log('user is disconnected', socket.id);
    });

    socket.om('message', (msg) => {
      console.log('Message: ' + msg);
    });
});

//Create Routes
app.get('/messages', (req, res) => {
    message.find({},(err, messages => {
        res.send(messages)
    }))
})

app.get('/messages/:user', (req, res) => {
    var user = req.params.user
    Message.find({name: user},(err, messages)=> {
      res.send(messages);
    })
  })

/*app.post('/messages', (req, res)=> {
    var message = new Message(req.body);
    message.save((err) => {
        if(err)
        sendStatus(500);
    io.emit('message', req.body);
    res.sendStatus(200);
    })
})*/

app.post('/messages', async (req, res) => {
    try{
      var message = new Message(req.body);
  
      var savedMessage = await message.save()
        console.log('saved');
  
      var censored = await Message.findOne({message:'badword'});
        if(censored)
          await Message.remove({_id: censored.id})
        else
          io.emit('message', req.body);
        res.sendStatus(200);
    }
    catch (error){
      res.sendStatus(500);
      return console.log('error',error);
    }
    finally{
      console.log('Message Posted')
    }
  
  })

mongoose.connection.once('open', () => {
    console.log('Connected to mongoDB')
app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
});