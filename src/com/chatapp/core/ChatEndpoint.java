package com.chatapp.core;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/chat/{room}", encoders = ChatMessageEncoder.class, decoders = ChatMessageDecoder.class)
public class ChatEndpoint {
	private final Logger log = Logger.getLogger(getClass().getName());
	
	private static Set<Session> activeSessions=new HashSet<>();

	//on open update db with room and name and then send broadcast to all that user has joined
	@OnOpen
	public void open(final Session session, @PathParam("room") final String room) {
		log.info("session openend and bound to room: " + room);
                String st[]=room.split("&");
		session.getUserProperties().put("room", st[0]);
		session.getUserProperties().put("name", st[1]);
	try
        {
            Connection con = Connections.give_Connection();
            Statement statement=con.createStatement();
            statement.executeUpdate("update user set room='"+st[0]+"' where name='"+st[1]+"'");
            Date d=new Date();
	        ChatMessage chat=new ChatMessage();
	        chat.setMessage("Hi I just Joined");
	        chat.setSender(st[1]);
	        chat.setReceived(d);
	        activeSessions.add(session);
	        onMessage(session, chat);
	    }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        }
	
	
	//send messages to all open sessions
	@OnMessage
	public void onMessage(final Session session, final ChatMessage chatMessage) {
		String room = (String) session.getUserProperties().get("room");
		try {
			for (Session s : activeSessions) {
				if (s.isOpen()
						&& room.equals(s.getUserProperties().get("room"))) {
					s.getBasicRemote().sendObject(chatMessage);
				}
			}
		} catch (IOException | EncodeException e) {
			log.log(Level.WARNING, "onMessage failed", e);
		}
	}
        //onclose send broadcast that user left
        @OnClose
       public void onClose(Session session) throws IOException
       {
           Date d=new Date();
          ChatMessage chat=new ChatMessage();
        chat.setMessage(session.getUserProperties().get("name")+" just left the room");
        chat.setSender("System: ");
        chat.setReceived(d);
        onMessage(session, chat);
        activeSessions.remove(session);
        session.close();
            
        }
}
