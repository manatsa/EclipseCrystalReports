
<%@page import="java.util.Iterator"%>
<%@page import="java.net.URL"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.primefaces.shaded.commons.io.FilenameUtils"%>
<title>Zvandiri Report</title>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%//Crystal Java Reporting Component (JRC) imports.%>

<%//Java imports. %>
<%@page import="java.io.*" %>
<%@ page import="com.crystaldecisions.sdk.occa.report.reportsource.IReportSource" %>
<%@ page import="com.crystaldecisions.report.web.viewer.CrystalReportViewer" %>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.PropertyBag" %>
<%@ page import="java.util.Set" %>
<%//Crystal Reports for Eclipse Version 2 imports.%>
<%@ page import="com.crystaldecisions.sdk.occa.report.application.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.document.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.definition.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*" %>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.IConnectionInfo" %>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.ConnectionInfo" %>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.Fields" %>


<%   
	Set<String> keys=request.getParameterMap().keySet();
	String report="";
	int source=0;
		try{
			report=request.getParameter("report_name").toString();
		}catch(Exception e){
			report=request.getSession().getAttribute("report_name").toString();
			out.println("report name is :"+report);
			source=1;
			e.printStackTrace();
		}
		
			
		System.out.println("Keys :"+keys.size());
		
	 File jsp = new File(request.getSession().getServletContext().getRealPath(request.getServletPath())).getParentFile();
	 String path="Reports/";
    //Report can be opened from the relative location specified in the CRConfig.xml, or the report location
//tag can be removed to open the reports as Java resources or using an absolute path (absolute path not recommended
//for Web applications).

    final String DBUSERNAME = "zvandiri";
    final String DBPASSWORD = "zvandiri2019";
    final String CONNECTION_STRING = "jdbc:mysql://localhost:3306/zvandiri";
    final String TRUSTEDCON = "false";
    final String SERVERTYPE = "JDBC (JNDI)";
    final String DATABASE_DLL = "crdb_jdbc.dll";
    final String DATABASE = "zvandiri";
    final String DBCLASSNAME = "com.mysql.jdbc.Driver";
    final String USEJDBC = "true";
    final String DATABASE_NAME = "zvandiri";
    final String SERVERNAME = "jdbc:mysql://localhost:3306";
    final String CONNECTIONURL = "jdbc:mysql://localhost:3306";
    final String SERVER = "localhost";
   
	System.out.println("++++++++++++++++++++++++++++ : "+report);
%>

<%

    try {
//    	final String rpt_name=FilenameUtils.removeExtension(report);
    	CrystalReportViewer viewer = new CrystalReportViewer();
        //viewer.setName("Report");
        //File dir = FileUtils.toFile(new URL("file://C:/Portables/Reports/"));

        ReportClientDocument doc = new ReportClientDocument();
        doc.open(jsp.getAbsolutePath()+"/Reports/"+report, 0);
        
        out.println("File path:"+doc.displayName());

// Set DB Username and Password
        doc.getDatabaseController().logon(DBUSERNAME, DBPASSWORD);

// Create the two connectioninfo objects to use
        IConnectionInfo oldConnectionInfo = new ConnectionInfo();
        IConnectionInfo newConnectionInfo = new ConnectionInfo();

// Assign the old Connection info to the reports current info
        DatabaseController dbController = doc.getDatabaseController();
        oldConnectionInfo = dbController.getConnectionInfos(null).getConnectionInfo(0);
// If this connection needed parameters, we would use this field.
        Fields pFields = null;

// Create a new propertybag for the new location
        PropertyBag boPropertyBag1 = new PropertyBag();

// Set new table logon properties
        boPropertyBag1.put("JDBC Connection String", CONNECTION_STRING);
        boPropertyBag1.put("Trusted_Connection", TRUSTEDCON);
        boPropertyBag1.put("Server Type", SERVERTYPE);
        boPropertyBag1.put("Database DLL", DATABASE_DLL);
        boPropertyBag1.put("Database", DATABASE);
        boPropertyBag1.put("Database Class Name", DBCLASSNAME);
        boPropertyBag1.put("Use JDBC", USEJDBC);
        boPropertyBag1.put("Database Name", DATABASE_NAME);
        boPropertyBag1.put("Server Name", SERVERNAME);
        boPropertyBag1.put("Connection URL", CONNECTIONURL);
        boPropertyBag1.put("Server", SERVER);
// Assign the properties to the connection info
        newConnectionInfo.setAttributes(boPropertyBag1);

// Set the DB Username and Pwd
        newConnectionInfo.setUserName(DBUSERNAME);
        newConnectionInfo.setPassword(DBPASSWORD);
        newConnectionInfo.setKind(ConnectionInfoKind.SQL);

        int replaceParams = DBOptions._ignoreCurrentTableQualifiers + DBOptions._doNotVerifyDB;
        dbController.replaceConnection(oldConnectionInfo, newConnectionInfo, pFields, replaceParams);


         if(keys.size()>1) 
         {
        	 ParameterFieldController paramController = doc.getDataDefController().getParameterFieldController();
             
	         for(String key:keys)
	        {
	            if(!key.contentEquals("report_name") || !key.contentEquals("CRVCompositeViewState")){
	                System.err.println( "Key: "+key+"  *** Value: "+request.getParameterMap().get(key).toString());
	                paramController.setCurrentValue("",key,request.getParameterMap().get(key));
	                //doc.getDataDefController().getParameterFieldController().setCurrentValue("",key,request.getParameterMap().get(key));
	            }
	        }   
         }
        
        
        
        
        /* ByteArrayInputStream byteArrayInputStream = (ByteArrayInputStream)doc.getPrintOutputController().export(ReportExportFormat.PDF);
        doc.close();

        writeToBrowser(byteArrayInputStream, response, "application/pdf"); */

        
        IReportSource reportSource =doc.getReportSource();

        
        viewer.setReportSource(reportSource);
        viewer.setBestFitPage(true);
        viewer.setDisplayToolbar(true);
        viewer.setDisplayPage(true);
        viewer.setBestFitPage(true);
        viewer.setEnableDrillDown(true);
        viewer.setHasExportButton(true);
        viewer.setHasGotoPageButton(true);
        viewer.setDisplayGroupTree(false);
        viewer.setDisplayToolbar(true);
        viewer.setHasLogo(false);
        viewer.setHasToggleGroupTreeButton(false);
        viewer.setHasToggleParameterPanelButton(false);
        viewer.setHasGotoPageButton(true);
        viewer.setBestFitPage(true);
        viewer.setBestFitPage(true);
        viewer.setOwnPage(true);
        viewer.processHttpRequest(request, response,getServletConfig().getServletContext(), null);

    } catch(Exception ex) {
        out.println(ex);
        ex.printStackTrace();
    }
%>


