<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.UnidadMedida"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="unidadMedidaDB" scope="page" class="Datos.UnidadMedidaDB" />

<%
	List<UnidadMedida> umeds = new ArrayList();
	umeds = unidadMedidaDB.getUnidadesDeMedida();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><%=globconfig.nombrePag() %></title>
          <%@ include file="WEB-INF/jspf/estilo.jspf" %>
           <script src="js/jquery-1.6.4.min.js" ></script>
 <script type="text/javascript" src="js/apprise.js"></script>
<link rel="stylesheet" href="estilos/apprise.css" type="text/css" />
<script>
$(function() {
   $('td:nth-child(5)').hide(); //oculto id 
     $(".btnDelete").bind("click", function(e){
             var par = $(this).parent(); //td
             var pr= par.next();  //id q se borra
            // alert(pr.text());
            e.preventDefault(); 
            apprise('¿Está seguro que desea borrar la unidad de medida?',  {'confirm':true}   , function(r) {
              if(r) {  
                  window.location = "borrarUnidadMedida.jsp?id=" + pr.text() ; }}
          );
        });
});
</script>
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%>unidades medida</a></p></li>
                                   </ul>
                                    <br class="clear" />
                                </div>
                        </div>
            <div id="main">
                            <div id="opciones">
                                <p>
                                    <a href="<%= response.encodeURL("nuevaUnidadMedida.jsp")%>">Agregar Unidad de medida</a>
                                </p>
                            </div>

                            <h2 id="titulo">Lista de Unidades de medida</h2>
                            <div id="tablaABM" >
                                    <table class="tablaABM">
                                        <thead>
                                            <tr>
                                                <th>Código</th>
                                                <th>Descripción</th>
                                                <th colspan="2">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < umeds.size(); i++) {
                                         %>
                                            <tr>
                                                <td><%= umeds.get(i).getIdUnidadMedida()%></td>
                                                <td style="width: 200px;"><%= umeds.get(i).getDescUnidadMedida()%></td>
                                               <td class="imege"><a href="<%= response.encodeURL("nuevaUnidadMedida.jsp?id=" + umeds.get(i).getIdUnidadMedida())%>"><img  src='images/iconEdit.png' class='btnEdit'></a></td>
                                                  <td class="imege"><img src='images/trash.png' class='btnDelete'></td>
                                                 <td><%= umeds.get(i).getIdUnidadMedida()%></td>
                                            </tr>
                                            <%
                                 }  
                                            %>                        
                                        </tbody>
                                    </table>
                            </div>
            </div>
            </div>
                                        <%@ include file="WEB-INF/jspf/firma.jspf" %>
        </div>
    </body>
</html>
