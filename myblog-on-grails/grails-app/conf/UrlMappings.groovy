class UrlMappings {

	static mappings = {
		
		name root: "/"{
			controller = "post"
			action = "list"
		}
		
		
		"/Post/$action"{
			controller = "post"
		}
		
		
		
		"/User/$action"{
			controller = "user"
		}
		
		"/Blog/$action"{
			controller = "blog"
		}
		
		"/Comment/$action"{
			controller = "comment"
		}
		
		
		
		
		
		name signin: "/signin"{
			controller = "auth"
			action = "signIn"
		}
		
		name signup: "/signup"{
			controller = "user"
			action = "create"
		}
		
		name login: "/login"{
			controller = "auth"
			action = "login"
		}
		
		name signOut: "/signOut"{
			controller = "auth"
			action = "signOut"
		}
		
		name userblog: "/$username"{
			controller = "blog"
			action = "show"
		}
		
		name post: "/$username/$permalink"{
			controller = "post"
			action = "show"
		}
	
		
		"500"(view:'/error')
	}
}
