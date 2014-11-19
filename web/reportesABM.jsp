<%@ page  import="java.io.*"%> 
<%@page import="Base.Config.TipoABM"%>
<%@ page  import="java.sql.Connection"%> 
<%@ page  import="java.sql.DriverManager"%>
<%@ page  import="java.util.HashMap"%>
<%@ page  import="java.util.Map"%>
<%@ page  import="net.sf.jasperreports.engine.*"%>
 <%@ page import="net.sf.jasperreports.view.JasperViewer;"%>
 <jsp:useBean id="herramientaDB" scope="page" class="Datos.HerramientaDB" />
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
<%
String rep = request.getParameter("rp");
String reporte="";
TipoABM typ = TipoABM.valueOf(rep);

if ( rep != null) {

    switch (typ) {
             case Herr:
                reporte = "c:\\Users\\Erika\\Documents\\NetBeansProjects\\Siproc\\web\\repHerramientas.jasper";
                break;
             case Ma:
               reporte = "c:\\Users\\Erika\\Documents\\NetBeansProjects\\Siproc\\web\\repMateriales.jasper";
               break;
             case Mo:
               reporte = "c:\\Users\\Erika\\Documents\\NetBeansProjects\\Siproc\\web\\repManoDeObra.jasper";
               break;
       }
  
        File reportFile = new File (reporte);
        Map parameters = new HashMap();
        byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters,  herramientaDB.getConexion());

        ServletOutputStream sos = response.getOutputStream();
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline;filename='Listado.pdf'");
        sos.write(bytes);
        sos.flush();
        sos.close();
   }
%>
    </body>
</html>