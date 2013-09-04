package com.myblog

import java.util.Date;

class Comment {

	String username
	String website
	String email
	String body
	Date dateCreated
	
	static belongsTo = [post: Post, user: User]
	
    static constraints = {
		username blank: false
		website nullable: true
		email nullable: true
		body blank: false
		user nullable: true, blank: false
    }
	
	
}
