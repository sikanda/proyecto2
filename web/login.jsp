<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="Entidades.Usuario" %>
<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="usuarioDB" scope="page" class="Datos.UsuarioDB" />

<%
String mensaje = "";
String usuario = "";
String clave = "";

if (request.getParameter("ref") != null) {
    if (request.getParameter("ref").contentEquals("login")) {
        usuario = request.getParameter("txtusuario").toString();
        clave = request.getParameter("txtclave").toString();

        if (!usuario.isEmpty() || !clave.isEmpty()) {
//            if(globconfig.adminLogin(usuario, clave))
//            {
//                session.setAttribute("admin", 1);
//                response.sendRedirect("inicioAdmin.jsp");
//            }
// //         aca va si el user no es admin
//            else
//            {
                Usuario usu = usuarioDB.loginUsuario(usuario, clave);
                if (usu != null) {
                    if (usu.getNombreUsuario().equals("admin")) {
                        session.setAttribute("admin", 1);
                        response.sendRedirect("inicioAdmin.jsp");
                    } else {
                        session.setMaxInactiveInterval(-1);
                        session.setAttribute("usuario", usu);
                        session.setAttribute("admin", 0);
                        response.sendRedirect("inicioUsuario.jsp");
                    }
                } else {
                    mensaje = "Por favor, verifique el usuario y clave ingresados.";
                }
            } else {
                mensaje = "El nombre de usuario y/o la contraseña no pueden estar vacíos.";
            }
    }
    else if (request.getParameter("ref").contentEquals("logout"))
    {
        mensaje = "La sesión se ha cerrado correctamente.";
        session.invalidate();
    }
}
%> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= globconfig.nombrePag()%> - Ingresar</title>
  <%@ include file="WEB-INF/jspf/estilo.jspf" %>
	          <script src="dist/libs/jquery.js" ></script>
        <script type="text/javascript" src="js/jquery.popupwindow.js"></script>
                <script>
            $(function() { 
        $('#helpLogin').click(function (event) {
           $.popupWindow('helpPages/ayudaGeneral.html', {
             width: 900,
              height: 600,
            center: 'parent'
          });
     });
              });
        </script>	
    </head>
    <body>
        <div id="bg1">     </div>   
        <div id="bg2"></div>
        <div id="outer2">
            <div id="header2">
                <div id="logo2">
                    <h1>
                        <img src="images/cim1.png" alt="" />  <!-- <a href="#">Cimax Construcciones</a>-->
                    </h1>
                </div>
                <div id="nav">
                    <ul>
                        <li id="helpLogin">
                            <a href="">Ayuda</a>
                        </li>
                    </ul><br class="clear" />
                </div>               

            </div>
            <div id="banner2">
                <div class="captions">
                    <h2> Sistema de presupuestos de obras civiles</h2>
                </div>
                <img src="images/bannerSmall.jpg" alt="" />
            </div>
<div id="frontPage">
            <h2>Ingresar al Sistema</h2>
            <% if (!mensaje.isEmpty()) {%>
            <h3  ><%= mensaje%></h3>
            <% }%>
            <form id="login" name="frmlogin" action="<%= response.encodeURL("login.jsp?ref=login")%>" method="POST">

                    <span id="label">Nombre de usuario:</span>
                    <br />
                    <label for="txtusuario"><input type="text" id="txtusuario" name="txtusuario" value = "plopez"/></label>
                    <br />
                    <span id="label">Contraseña:</span>
                    <br />
                    <label for="txtclave"><input type="password" id="txtclave" name="txtclave" value ="1234" /></label>
                    <br />
                    <input class="button" type="submit" value="Ingresar" />
            
            </form>
        </div>
</div>
        <%@ include file="WEB-INF/jspf/firma.jspf" %>

    </body>
</html>