package com.myblog

class Post {
	
	String title
	String permalink
	String body
	Date dateCreated
	Date lastUpdated

	static belongsTo = [blog: Blog]
	static hasMany = [comments:Comment]
	
    static constraints = {
		title blank: false
		body blank: false
    }
	
	static mapping = {
		comments sort: 'dateCreated'
	}
	
	def beforeValidate() {
		permalink = title.replaceAll(/\s/,'-')
	}
}
