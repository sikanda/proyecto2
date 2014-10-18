<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.Proveedor"%>

<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="usuarioDB" scope="page" class="Datos.UsuarioDB" />

<%
	String mensajeE = "";

        if (request.getParameter("id") != null ){
            try{
                     
             boolean rta =   usuarioDB.delete(Integer.parseInt(request.getParameter("id")));
             
             if (rta){
             mensajeE = "El usuario ha sido borrado exitosamente";
             }
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaUsuarios.jsp"));
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
                 <div id="nav">
                                    <ul>
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaProveedores.jsp")%>">Usuarios</a><%=globconfig.separador()%> borrar</p></li>
                                    </ul>
                                    <br class="clear" />
                                </div>
                        </div>

            <div id="main">


            <% String titulo = "Borrar Usuario";
                %>
            <h2 id="titulo"><%=titulo%></h2>

        <div id="formu">
        <form name="frmusuario" action="<%= response.encodeURL("listaUsuarios.jsp")%>" method="POST">
            <fieldset>
                   
                    <% if(!mensajeE.isEmpty()){ %>
                    <div id="mensaje">
                        <%= mensajeE %>
                    </div>
                    <% } %>
                    </br>
                    <input type="submit" value="Continuar" style="height:25px; width: 70px;"/>
            </fieldset>
        </form>
        </div>
         </div>
                     </div>

         </div>
    </body>
</html>