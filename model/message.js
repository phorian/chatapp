var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var messageSchema = new Schema ({
    name: {
        type: String,
        required: true
    },
    message: {
        type: String,
        required: true
    }
})

module.exports = mongoose.model('message', messageSchema);