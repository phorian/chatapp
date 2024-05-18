const User = require('../model/user');




exports.createNewUser = async (req,res) => {
    const { username, email, password } = req.body;

    if(!username || !email || !password){
        return res.status(400).json({'message': 'Input all fields'})
    }

    //check for duplicates in db
    const duplicateEmail = await User.findOne({email: email}).exec();
    const duplicateUsername = await User.findOne({username: username}).exec();

    if(duplicateEmail || duplicateUsername){
        return res.status(400).json({
            status: false,
            message: 'User with email or username already exists'
        });
    }

    //check password strenght
    if (password.length < 6) {
        return res.status(400).json({'message': 'Password should be more than 6 characters'})
    }

    try {
        const newUser = new User(
            req.body
        );

        await newUser.save();

        res.status(201).json({
            status: 'success',
            message: 'New user created',
            data: {
                newUser
            }
        });
        
    } catch (err) {
        res.status(500).json({'message': err.message})
    }
}

exports.loginUser = async (req,res) => {
    const {username, password} = req.body;

    if(!username || !password){
        return res.status(400).json({'message': 'Input all fields'})
    }

    //check if user exists
    const searchUser = await User.findOne({username}).select('+password');
    if(!searchUser){
        return res.status(400).json({status: false, 'message': 'User not found'})
    }

    //confirm password
    const matchpwd = await searchUser.matchPassword(password, searchUser.password)
    if(matchpwd){

        //add jwt lazy ass

        const result = await searchUser.save();
        res.status(201).json({
            status: 'success',
            message: 'You are logged in',
            data: {
                result
            }
        })
    } else {
        return  res.status(403).json({
            status: false,
            message: 'Incorrect password.'
            })
    }

}

exports.updateUser = async (req,res, next) => {
    const {username, email } = req.body;

    if(req.body.password){
        return next(res.status(400).json({
            status: false,
            'message': "You can't update password here"
        }))
    }

    const updatedUser = await User.findByIdAndUpdate(req.user.id, req.body, {runValidators: true, new: true});

    res.status(200).json({
        status: 'success',
        data: {
            updatedUser
        }
    });
}

exports.updatePassword = async (req,res) => {

    const user = await User.findById(req.user.id).select('+password');

    if(!(await user.matchPassword(req.body.currentPassword, user.password))){
        return res.status(401).json('The current password is not correct');
    }

    //if current password is correct
    user.password = req.body.password,
    await user.save();

    //sign with JWT here ---> Later

    res.status(200).json({
        status: 'success',
        token,
        data: {
            user
        }
    });
}

exports.deleteUser = async (req,res) => {
    await User.findByIdAndUpdate(req.user.id, {active: false});

    res.status(204).json({
        status: 'success',
        data: null
    });
}