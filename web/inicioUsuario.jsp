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

                                        <form id="admuser" name="admuser" >
                                            <fieldset>
                                                <legend><strong>Seleccione una opción  </strong></legend>
                                            
                                                                                         
                                               <a href="generarPresupuesto.jsp"> Generar Presupuesto</a><br>
                                               <a href="listaProveedores.jsp"> ABM Proveedores</a><br>
                                               <a href="listaProveedores.jsp"> ABM Herramienta</a><br>
                                               <br>
                                               <br>
                                            <a href="listaRubros.jsp"> test lista rubros</a><br>
                                             <a href="pantallaDos.jsp"> Test Pantalla DOS</a><br>
                                      </fieldset>
                             </form>
                        </div>
                </div>
           
        </div>
    </body>
</html>