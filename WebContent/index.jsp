<%@page import="java.util.stream.Stream"%>
<%@page import="java.util.Set"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  


<%@include file="template/header.jspf" %>
<%
	/* 
	File jsp = new File(request.getSession().getServletContext().getRealPath(request.getServletPath()));
	String dirs = jsp.getParentFile().getParentFile().getAbsolutePath()+"/Reports/";
	//File dir=new File(dirs);
	File dir=new File("C:/Portables/Reports");
	File[] list = new File(dir).listFiles();
	out.println("SIZE: "+dir.length());
	 for(File file: list)
	{
		out.println("Filename :"+file.getAbsolutePath()+"<br />");
	} */ 
%>
 	
 	
 
<%@include file="template/footer.jspf" %>
    

   