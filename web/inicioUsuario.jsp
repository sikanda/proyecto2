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
                        <div id="headerlogin">
                  <%@ include file="WEB-INF/jspf/barrausuario.jspf" %>            
                                <div id="logologin">
                                    <h2>
                                            Sistema de presupuesto de obras civiles
                                    </h2>
                                </div>

                       
                                <fieldset>  
                                    <legend><strong>Seleccione una opción  </strong></legend>
                                    <br/>    

                                    <div>

                                        <ul  style="list-style: none; "  >
                                            <li  ><a href="listaRubros.jsp" title="Presupuesto" style="height:51px;line-height:51px;"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/icon_dashboard.png" alt="Presupuesto"/><font color="white">Generar presupuesto</font></a></li>
                                            </br>
                                            <li><a href="listaProveedores.jsp" title="Proveedores" style="height:51px;line-height:51px;"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/icon_users.png" alt="Proveedores"/><font color="white">Proveedores</font></a></li>
                                            </br>
                                            <li><a href="editarRubro.jsp" title="Herramientas" style="height:51px;line-height:51px;"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/icon_settings.png" alt="Herramientas"/><font color="white">Herramientas</font></a></li>


                                        </ul>

                                    </div>       
                                </fieldset>   
                 
                        </div>
                </div>
           
        </div>
    </body>
</html>