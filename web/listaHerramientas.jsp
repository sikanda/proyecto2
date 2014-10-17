<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Herramienta"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="herramientaDB" scope="page" class="Datos.HerramientaDB" />

<%
	List<Herramienta> herramientas = new ArrayList();
	herramientas = herramientaDB.getHerramientas();
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>herramientas</a></p></li>
                                   </ul>
                                    <br class="clear" />
                                </div>
                        </div>
            <div id="main">
                            <div id="opciones">
                                <p>
                                    <a href="<%= response.encodeURL("nuevaHerramienta.jsp")%>">Agregar Herramienta</a>
                                </p>
                            </div>

                            <h2 id="titulo">Lista de Herramientas</h2>
                            <div id="tabla" >
                                    <table class="tabla">
                                        <thead>
                                            <tr>
                                             <!--  <th style="text-align:center">Codigo</th>   -->
                                                <th style="text-align:center">Descripcion</th>
                                                <th colspan="2" align="center">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < herramientas.size(); i++) {
                                         %>
                                            <tr>
                                             <!--   <td style="text-align:center"><//%= herramientas.get(i).getIdHerramienta()%></td>    -->
                                                <td style="text-align:center"><%= herramientas.get(i).getDescHerramienta()%></td>
                                               <td><a href="<%= response.encodeURL("nuevaHerramienta.jsp?id=" + herramientas.get(i).getIdHerramienta())%>">Modificar</a></td>
                                                <td><a href="<%= response.encodeURL("borrarHerramienta.jsp?id=" + herramientas.get(i).getIdHerramienta())%>">Borrar</a></td>
                                            </tr>
                                            <%
                                 }  
                                            %>                        
                                        </tbody>
                                    </table>
                            </div>
            </div>
            </div>
        </div>
    </body>
</html>
