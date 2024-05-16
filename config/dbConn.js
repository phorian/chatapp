const Mongoose = require('mongoose');

const connectDB = async () => {
        await Mongoose.connect(process.env.DATABASE_URI)
}

module.exports = connectDB;