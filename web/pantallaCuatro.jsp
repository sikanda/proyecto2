<%@page import="Entidades.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Presupuesto"%>
<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="clienteDB" scope="page" class="Datos.ClienteDB" />

<%
  boolean rta, rtaCli;
  String mensaje="";
  String obs = request.getParameter("obs");
  String nomCli = request.getParameter("nomCli");
  String direCli = request.getParameter("direCli");
  String telCli = request.getParameter("telCli");
  
if(request.getParameter("btnGuardar")!=null) //name of your button, not id 
{
   Presupuesto pres = (Presupuesto)session.getAttribute("presupuestoActual");
   pres.setObservaciones(obs);
   
        Cliente c = new Cliente();
        c.setIdCliente(clienteDB.getIdCliente());
        c.setNomApeCli(nomCli);
        c.setDireCli(direCli);
        c.setTelCli(telCli);
        rtaCli= c.save();
        pres.setCliente(c);
 
  rta = pres.save();
   if(rta && rtaCli)
   { mensaje = "El presupuesto se ha guardado correctamente";
         session.removeAttribute("rubrosEnArbol");
         session.removeAttribute("rubrosLeaf");
         session.removeAttribute("presupuestoActual");
         session.removeAttribute("rubrosAll");
         session.removeAttribute("rubrosPerc");
   }
   else
    { mensaje = "Ha ocurrido un error ";}
   
   
}
  %>   
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><%=globconfig.nombrePag() %></title>
          <%@ include file="WEB-INF/jspf/estilo.jspf" %>
     
    </head>
          <body>
              <div id="bg">
                  <div id="outer">
                      <div id="header">
                          <div id="logo">
                              <h1>
                                  <a href="#"><%= globconfig.nombrePag()%></a>
                              </h1>
                          </div>
                          <%@ include file="WEB-INF/jspf/barrausuario.jspf" %>
                          <div id="nav">
                              <ul>
                                  <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a></p></li>
                              </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                          <h3> <%= mensaje %></h3> 
                  </div>
              </div>
            </div>
          </body>
</html>
