<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Proveedor"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="proveedorDB" scope="page" class="Datos.ProveedorDB" />

<%
	List<Proveedor> proveedores = new ArrayList();
	proveedores = proveedorDB.getProveedores();
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>proveedores</a></p></li>
                                   </ul>
                                    <br class="clear" />
                                </div>
                        </div>
            <div id="main">

                            <div id="opciones">
                                <p>
                                    <a href="<%= response.encodeURL("nuevoProveedor.jsp")%>">Agregar Proveedor</a>
                                </p>
                            </div>

                            <h2 id="titulo">Lista de Proveedores</h2>
                            <div id="tabla">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Razón Social</th>
                                                <th>Dirección</th>
                                                <th>Telefono</th>
                                                <th>E-mail</th>
                                                <th colspan="2" align="center">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < proveedores.size(); i++) {
                                    if (i % 2 == 0)
                                    {
                                            %>
                                            <tr>
                                                <td><a href="<%= response.encodeURL("proveedor.jsp?id=" + proveedores.get(i).getIdProveedor())%>"><%= proveedores.get(i).getRazonSocial()%></a></td>
                                                <td style="text-align:center"><%= proveedores.get(i).getDireProv()%></td>
                                                <td style="text-align:center"><%= proveedores.get(i).getEmailProv()%></td>
                                                <td style="text-align:center"><%= proveedores.get(i).getTelProv()%></td>
                                                <td><a href="<%= response.encodeURL("nuevoProveedor.jsp?id=" + proveedores.get(i).getIdProveedor())%>">Modificar</a></td>
                                                <td><a href="<%= response.encodeURL("borrarProveedor.jsp?id=" + proveedores.get(i).getIdProveedor())%>">Borrar</a></td>
                                            </tr>
                                            <%
                                    }
                                    else
                                    {
                                            %>
                                            <tr class="odd">
                                                <td><a href="<%= response.encodeURL("proveedor.jsp?id=" + proveedores.get(i).getIdProveedor())%>"><%= proveedores.get(i).getRazonSocial()%></a></td>
                                                <td style="text-align:center"><%= proveedores.get(i).getDireProv()%></td>
                                                <td style="text-align:center"><%= proveedores.get(i).getEmailProv()%></td>
                                                <td style="text-align:center"><%= proveedores.get(i).getTelProv()%></td>
                                                <td><a href="<%= response.encodeURL("nuevoProveedor.jsp?id=" + proveedores.get(i).getIdProveedor())%>">Modificar</a></td>
                                                <td><a href="<%= response.encodeURL("borrarProveedor.jsp?id=" + proveedores.get(i).getIdProveedor())%>">Borrar</a></td>
                                            </tr>
                                            <%
                                    }
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
