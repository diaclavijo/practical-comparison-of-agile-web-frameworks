import com.myblog.Blog
import com.myblog.User
import com.myblog.Role
import com.myblog.Post
import com.myblog.Comment
class BootStrap {
	def shiroSecurityService
    def init = { servletContext ->
		
		// Create the user role
		def userRole = Role.findByName('USER') ?:
			new Role(name: 'USER').save(flush: true, failOnError: true)
		assert userRole.addToPermissions("user:*")
		assert userRole.addToPermissions("blog:*")
		assert userRole.addToPermissions("post:*")
		assert userRole.addToPermissions("comment:*")
		assert userRole.save(flush: true, failOnError: true)
		// Create an standard user
		def standardUser = User.findByUsername('uno') ?:
			new User(username: "uno",
					email: "uno@uno.com",
					website: "uno.com",
					passwordHash: shiroSecurityService.encodePassword('123'))
					.save(flush: true, failOnError: true)
		assert standardUser.addToRoles(userRole).save(flush: true, failOnError: true)
		
		def unoBlog = Blog.findByUser(standardUser) ?:
			new Blog(title:"uno's blog",
					description:"uno life",
					user: standardUser)
					.save(flush: true, failnOnError: true)
		def post = new Post(title: "first story of one",
							body: "one was a great number",
							blog: unoBlog)
							.save(flush: true, failOnError: true)
		def comment = new Comment(username: 'unkown1',
								body: 'unknown liked this dude!',
								post: post)
								.save(flush: true, failOnError: true)
		
		def dosUser = new User(username: "dos",
				email: "dos@dos.com",
				website: "dos.com",
				passwordHash: shiroSecurityService.encodePassword('123'))
				.save(flush: true, failOnError: true)
		
		comment = new Comment(username: 'unkown1',
								body: 'unknown liked this dude!',
								user: dosUser,
								post: post)
								.save(flush: true, failOnError: true)
		
		def tresUser = new User(username: "tres",
			email: "tres@tres.com",
			website: "tres.com",
			passwordHash: shiroSecurityService.encodePassword('123'))
			.save(flush: true, failOnError: true)
	
		def tresBlog = new Blog(title:"tres's blog",
				description:"tres life",
				user: tresUser)
				.save(flush: true, failnOnError: true)
		
		post = new Post(title: "first story of tres",
							body: "tres was a great number",
							blog: tresBlog)
							.save(flush: true, failOnError: true)
							
		post = new Post(title: "second story of tres",
			body: "tres was a great number\n fsfafasf",
			blog: tresBlog)
			.save(flush: true, failOnError: true)
			
		post = new Post(title: "five story of ",
				body: "tres was a great number",
				blog: tresBlog)
				.save(flush: true, failOnError: true)
		
		post = new Post(title: "six story of tres ",
				body: "six was a great number",
				blog: tresBlog)
				.save(flush: true, failOnError: true)
		
		post = new Post(title: "uno second story",
			body: "uno oh my god ! in the sky there was blue print",
			blog: unoBlog)
				.save(flush: true, failOnError: true)
				
    }
    def destroy = {
    }
}
