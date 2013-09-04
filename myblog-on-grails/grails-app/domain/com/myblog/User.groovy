package com.myblog

class User {
    String username
    String passwordHash
	String email
	String website
	
	//String avatar
	byte[] avatar
	String avatarType
	
    static hasMany = [ roles: Role, permissions: String, commments:Comment ]
	static hasOne = [blog:Blog]
	
	
    static constraints = {
        username(nullable: false, blank: false, unique: true)
		email blank: false, unique: true, email: true
		website nullable: true
		avatar(nullable:true, maxSize: 1048576 /* 1000K */)
		avatarType(nullable:true)
		blog nullable: true, unique: true
    }
	
	static mapping = {
		blog cascade: "all-delete-orphan"
		commments cascade: "all-delete-orphan"
	}
}
