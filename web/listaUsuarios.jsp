<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Usuario"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="usuarioDB" scope="page" class="Datos.UsuarioDB" />

<%
	List<Usuario> usuarios = new ArrayList();
	usuarios = usuarioDB.getUsuarios();
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>usuarios</a></p></li>
                                   </ul>
                                    <br class="clear" />
                                </div>
                        </div>
            <div id="main">

                            <div id="opciones">
                                <p>
                                    <a href="<%= response.encodeURL("nuevoUsuario.jsp")%>">Agregar Usuario</a>
                                </p>
                            </div>

                            <h2 id="titulo">Lista de Usuarios</h2>
                            <div id="tabla" >
                                    <table class="tabla">
                                        <thead>
                                            <tr>
                                                <th>Id Usuario</th>
                                                <th>Nombre Usuario</th>
                                                <th>Contraseña</th>
                                                <th colspan="2" align="center">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < usuarios.size(); i++) {
                                          %>
                                            <tr>
                                                <td style="text-align:center"><%= usuarios.get(i).getIdUsuario()%></td>
                                                <td style="text-align:center"><%= usuarios.get(i).getNombreUsuario()%></td>
                                                <td style="text-align:center"><%= usuarios.get(i).getPass()%></td>
                                                <td><a href="<%= response.encodeURL("nuevoUsuario.jsp?id=" + usuarios.get(i).getIdUsuario())%>">Modificar</a></td>
                                                <td><a href="<%= response.encodeURL("borrarUsuario.jsp?id=" + usuarios.get(i).getIdUsuario())%>">Borrar</a></td>
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
