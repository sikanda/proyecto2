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
                 
                        <div id="headerlogin">
        <%@ include file="WEB-INF/jspf/barrausuario.jspf" %>                      
                           
                                <div id="logologin">
                                    <h2>
                                          Sistema de presupuesto de obras civiles
                                    </h2>
                           </div>
 
                                        <form id="admlogin" name="admlogin" >
                                            <fieldset>
                                                <legend><strong>Seleccione una opción </strong></legend>
                                              <a href="listaManoDeObra.jsp"> ABM Mano de Obra</a><br>                                           
                                               <a href="editarRubro.jsp"> ABM Rubro/Subrubro</a><br>
                                               <a href="listaUsuarios.jsp"> ABM Usuario</a><br>
                                               <a href="listaEmpleados.jsp"> ABM Empleado</a><br>
                                               <a href="listaMateriales.jsp"> ABM Material</a><br>
                                               <a href="listaUnidadesMedida.jsp"> ABM Unidad Medida</a><br>
                                             
                                      </fieldset>
                             </form>
                        </div>
                </div>
           
        </div>
    </body>
</html>