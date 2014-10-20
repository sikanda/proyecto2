<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= globconfig.nombrePag()%> </title>
  <%@ include file="WEB-INF/jspf/estilo.jspf" %>
 
   <%@ include file="WEB-INF/jspf/redirAdm.jspf" %>
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
                                        <li><p class="posicion">inicio</p></li>
                                    </ul>
                                    <br class="clear" />
                            </div>
                        </div>
                        <div id="main">
                            <h3>Menú de Administrador</h3>
                                        
                                            <fieldset id="optionMenu">
                                            <legend><strong>Seleccione una opción </strong></legend>
                                            <ul>
                                                <li><a href="listaManoDeObra.jsp"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/pin2.png" />Mano de Obra</a></li><br>                                           
                                                <li><a href="editarRubro.jsp"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/pin5.png" />Rubros/Subrubros</a></li><br>
                                                <li><a href="listaUsuarios.jsp"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/pin1.png" />Usuarios</a></li><br>
                                                <li><a href="listaEmpleados.jsp"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/pin3.png" />Empleados</a></li><br>
                                                <li><a href="listaMateriales.jsp"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/pin4.png" />Materiales</a></li><br>
                                                <li><a href="listaUnidadesMedida.jsp"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/pin2.png" />Unidades de Medida</a></li>
                                            </ul>
                                            </fieldset>
                                        
                        </div>
                </div>
                                       <%@ include file="WEB-INF/jspf/firma.jspf" %>
        </div>
    </body>
</html>