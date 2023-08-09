require('dotenv').config();
var express = require('express');
var mongoose = require('mongoose');
var connectDB = require('./dbConn');
var PORT = process.env.PORT || 3000;
var app = express();

app.use(express.static(__dirname));


connectDB();

mongoose.connection.once('open', () => {
    console.log('Connected to mongoDB')
app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
});