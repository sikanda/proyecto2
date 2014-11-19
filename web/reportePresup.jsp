<%@ page  import="java.io.*"%> 
<%@ page  import="java.util.HashMap"%>
<%@ page  import="java.util.Map"%>
<%@ page  import="net.sf.jasperreports.engine.*"%>
 <%@ page import="net.sf.jasperreports.view.JasperViewer;"%>
 <jsp:useBean id="presupuestoDB" scope="page" class="Datos.PresupuestoDB" />
 <%@ page import="Entidades.Presupuesto"%>
 <%@ page import="Entidades.Rubro"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
 
            // String obs = request.getParameter("o");
            String nomCli = request.getParameter("n");
            String direCli = request.getParameter("d");
            String telCli = request.getParameter("t");
            
            
           Presupuesto presPrint = new Presupuesto();
           presPrint.setIdPresupuesto(1);
            List<Rubro> arrayRub = (List<Rubro>)session.getAttribute("rubrosLeaf");
            presPrint.setRubros(arrayRub);
            presPrint.preparePrint();
            
            File reportFile = new File ("c:\\Users\\Erika\\Documents\\NetBeansProjects\\Siproc\\web\\repPresupuesto.jasper");
            Map parameters = new HashMap();
            
            parameters.put("nomCliente",nomCli);
            parameters.put("dirCliente",direCli);
            parameters.put("telCliente",telCli);
            byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, presupuestoDB.getConexion());
 
            ServletOutputStream sos = response.getOutputStream();
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline;filename='Presupuesto.pdf'");
            sos.write(bytes);
            sos.flush();
            sos.close();

        %>
    </body>
</html>