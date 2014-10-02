<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.Proveedor"%>


<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="proveedorDB" scope="page" class="Datos.ProveedorDB" />

<%
	String mensajeE = "";

        if (request.getParameter("id") != null ){
            try{
                     
             boolean rta =   proveedorDB.delete(Integer.parseInt(request.getParameter("id")));
             
             if (rta){
             mensajeE = "El proveedor ha sido borrado exitosamente";
             }
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaProveedores.jsp"));
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaProveedores.jsp?al=t")%>">Proveedores</a><%=globconfig.separador()%> Borrar Proveedor</p></li>
                                    </ul>
                                    <br class="clear" />
                                </div>
                        </div>

            <div id="main">


            <% String titulo = "Borrar Proveedor";
                %>
            <h2 id="titulo"><%=titulo%></h2>

        <div id="formu">
        <form name="frmproveedor" action="<%= response.encodeURL("listaProveedores.jsp")%>" method="POST">
            <fieldset>
                   
                    <% if(!mensajeE.isEmpty()){ %>
                    <div id="mensaje">
                        <%= mensajeE %>
                    </div>
                    <% } %>

                    <input type="submit" value="Continuar" />
            </fieldset>
        </form>
        </div>
         </div>
                     </div>

         </div>
    </body>
</html>