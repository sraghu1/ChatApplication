package com.chatapp.core;

import java.util.HashSet;
import java.util.Set;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

@ApplicationPath("/core")
public class CoreApplicationPath extends Application{

	public CoreApplicationPath() {
		// TODO Auto-generated constructor stub
	}

	 /*@Override
	    public Set<Class<?>> getClasses()
	    {
	        final Set<Class<?>> classes = new HashSet<>();
	        classes.add(AuthenticationController.class);
	        return classes;
	    }*/
}
