var express = require('express');
var router = express.Router();
var mongoose = require( 'mongoose' );
//var Post = mongoose.model('User');
var Post = require('../models/models');
//api for all posts
router.route('/posts')
	
	//create a new post
	.post(function(req, res){

		var post = new Post();
		post.key = req.body.key;
		post.active = req.body.active;
		post.pageId = req.body.pageId;
		post.amount = req.body.amount;

		post.save(function(err, post) {
			if (err){
				return res.send(500, err);
			}
			return res.json(post);
		});
	})

	.get(function(req, res){
		Post.find(function(err, posts){
			if(err){
				return res.send(500, err);
			}
			return res.send(posts);
		});
	});

//api for a specfic post
router.route('/posts/:id')
	
	//create
	.put(function(req,res){
		return res.send({message:'TODO modify an existing post by using param ' + req.param.id});
	})

	.put(function(req, res){
		Post.findById(req.params.id, function(err, post){
			if(err)
				res.send(err);

			post.created_by = req.body.created_by;
			post.text = req.body.text;

			post.save(function(err, post){
				if(err)
					res.send(err);

				res.json(post);
			});
		});
	})

	.delete(function(req,res){
		return res.send({message:'TODO delete an existing post by using param ' + req.param.id})
	});

module.exports = router;