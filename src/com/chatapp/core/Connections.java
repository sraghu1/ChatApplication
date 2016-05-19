package com.chatapp.core;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Admin
 */
public class Connections {
     static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
   static final String DB_URL = "jdbc:mysql://localhost/practice";

   //  Database credentials
   static final String USER = "root";
   static final String PASS = "password";
   private static Connection conn = null;
   
   
   private Connections()
   {
	   
   }
    public static Connection give_Connection()
    {
        if(conn==null){
    	try {
        	//STEP 2: Register JDBC driver
	      Class.forName("com.mysql.jdbc.Driver");
	
	      //STEP 3: Open a connection
	      System.out.println("Connecting to database...");
	      conn = DriverManager.getConnection(DB_URL,USER,PASS);
	
	      //STEP 4: Execute a query
             
        } catch (Exception ex) {
            Logger.getLogger(Connections.class.getName()).log(Level.SEVERE, null, ex);
        }
    	return conn;
        }
        else
        {
        	return conn;
        }
    
    }
/*public static void main(String args[])
{
    Connections c=new Connections();
    Connection con=c.give_Connection();
    System.out.println(con);
    
}*/
}
