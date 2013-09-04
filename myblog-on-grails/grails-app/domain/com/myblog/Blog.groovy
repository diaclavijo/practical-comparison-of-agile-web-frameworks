package com.myblog

class Blog {
	
	String title
	String description
	Date dateCreated
	User user
	static hasMany = [posts:Post]
    static constraints = {
		title blank: false
		user unique: true
    }
	
	static mapping = {
		posts cascade: "all-delete-orphan"
	}
}
