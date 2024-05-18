const mongoose = require('mongoose');
const validator = require('validator');
const bcrypt = require('bcrypt');
const Schema = mongoose.Schema;

var userSchema = new Schema ({
    username: {
        type: String,
        required: [true, 'Please Enter your username'],
        unique: true
    },
    emai: {
        type: String,
        required: [true, 'Please Enter your email'],
        unique: true,
        validate: [validator.isEmail, 'Please enter a valid Email']
    },
    password: {
        type: String,
        required: [true, 'Please Enter your password'],
        minLength: 6,
        select: false
    },
    avi: {
        type: String,
        enum: []
    },
    active: {
        type: Boolean,
        default: true,
        select: false
    },
   
},
    {timestamps: true}
);


userSchema.pre('save', async function(next){
    if(!this.isModified('password')) return next();

    this.password = await bcrypt.hash(this.password, 10);
    next();
})

userSchema.methods.matchPasswords = async function (password, userPassword){
    return await bcrypt.compare(password, userPassword);
}

module.exports = mongoose.model('User', userSchema);