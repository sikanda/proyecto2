<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= globconfig.nombrePag()%> </title>
  <%@ include file="WEB-INF/jspf/estilo.jspf" %>
  
 
 	
   <%@ include file="WEB-INF/jspf/redirUsr.jspf" %>
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
                                    <fieldset id="optionMenu">  
                                    <legend><strong>Seleccione una opción  </strong></legend>
                                    <br/> 
                                    <ul class="niceMenu" >
                                            <li><a href="listaRubros.jsp" title="Presupuesto" style="height:51px;line-height:51px;"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/icon_dashboard.png" alt="Presupuesto"/>Generar presupuesto</font></a></li>
                                            </br>
                                            <li><a href="listaProveedores.jsp" title="Proveedores" style="height:51px;line-height:51px;"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/icon_users.png" alt="Proveedores"/>Proveedores</font></a></li>
                                            </br>
                                            <li><a href="listaHerramientas.jsp" title="Herramientas" style="height:51px;line-height:51px;"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/icon_settings.png" alt="Herramientas"/>Herramientas</font></a></li>

                                    </ul>
                                    </fieldset>
                                    </div>       
                               
                                
                </div>
                            <%@ include file="WEB-INF/jspf/firma.jspf" %>
        </div>
    </body>
</html>