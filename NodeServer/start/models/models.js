var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var userSchema = new mongoose.Schema({
	key: String,
	active: String, //hash created from password
	created_at: {type: Date, default: Date.now},
	pageId : String,
	amount : String
})


//mongoose.model('Post', postSchema);
var User = mongoose.model('User', userSchema);
module.exports = User;