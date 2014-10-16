<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="rubroDB" scope="page" class="Datos.RubroDB" />

<%
	String mensajeE = "";
        String rubroElim = request.getParameter("idRub");

        if (rubroElim != null ){
            try{
                     
             boolean rta = rubroDB.delete(rubroElim);
//             boolean rta = true;
//             System.out.println("voy a borrar el rubro " +rubroElim );
             if (rta){
             mensajeE = "El rubro ha sido borrado exitosamente";
             }
           }
            catch(Exception e)
            {
                 mensajeE = "Ha ocurrido un error al borrar el Rubro";
            }
        }

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                          <h3> <%= mensajeE %></h3> 
                  </div>
              </div>
            </div>
          </body>
</html>