<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Material"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="materialDB" scope="page" class="Datos.MaterialDB" />

<%
	List<Material> materiales = new ArrayList();
	materiales = materialDB.getMateriales();
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%>materiales</a></p></li>
                                   </ul>
                                    <br class="clear" />
                                </div>
                        </div>
            <div id="main">

                            <div id="opciones">
                                <p>
                                    <a href="<%= response.encodeURL("nuevoMaterial.jsp")%>">Agregar Material</a>
                                </p>
                            </div>

                            <h2 id="titulo">Lista de Materiales</h2>
                            <div id="tabla" >
                                    <table class="tabla">
                                        <thead>
                                            <tr>
                                           <!--     <th>Id Material</th>   -->
                                                <th>Descripcion</th>
                                                <th>Unidad Medida</th>
                                                <th>Precio</th>
                                                <th colspan="2" align="center">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < materiales.size(); i++) {
                                          %>
                                            <tr>
                                       <!--          <td style="text-align:center">< //%= materiales.get(i).getIdMaterial()%></td>   -->
                                                <td  ><%= materiales.get(i).getDescMaterial()%></td>
                                                <td style="text-align:center"><%= materiales.get(i).getIdUnidadMedida()%></td>
                                                 <td style="text-align:center"><%= materiales.get(i).getPrecioMa()%></td>
                                                <td><a href="<%= response.encodeURL("nuevoMaterial.jsp?id=" + materiales.get(i).getIdMaterial())%>">Modificar</a></td>
                                                <td><a href="<%= response.encodeURL("borrarMaterial.jsp?id=" + materiales.get(i).getIdMaterial())%>">Borrar</a></td>
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
