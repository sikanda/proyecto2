<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Material"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

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
<script src="js/jquery-1.6.4.min.js" ></script>
 <script type="text/javascript" src="js/apprise.js"></script>
<link rel="stylesheet" href="estilos/apprise.css" type="text/css" />
   <script type="text/javascript" src="js/jquery.popupwindow.js"></script>
<script>
$(function() {
   var typ = "Ma"; 
   $('td:nth-child(6)').hide(); //oculto id 
     $(".btnDelete").bind("click", function(e){
             var par = $(this).parent(); //td
             var pr= par.next();  //id  q se borra
           // alert(pr.text());
            e.preventDefault(); 
            apprise('¿Está seguro que desea borrar el material?',  {'confirm':true}   , function(r) {
              if(r) {  
                 // window.location = "borrarMaterial.jsp?id=" + pr.text() ; }}
                    $.ajax({
                  url: 'popupBorrar.jsp',
                  type: 'GET',
                  data:  {ident : pr.text(), objeto:typ},
//                  success: function() {
//                     location.reload();  
//                  },
               statusCode: {
                    200: function() {
                     location.reload();  // apprise ('El material ha sido dado de baja exitosamente');
                     },
                    400:function(){
                      apprise ('No se ha podido dar de baja el material. Verifique que el mismo no esté asignado a un rubro.');
                     },
                   500:function(){
                       apprise ('Ha ocurrido un error en el servidor');
                     }} 
//                  error: function(e) {
//                   apprise ('Ha ocurrido un error');
//                  }
                }); //ajax 
                }//if r   
         }); //apprise
     }); //click
 $('#help').click(function (event) {
   $.popupWindow('helpPages/listaMateriales_h.html', {
	 width: 900,
	  height: 600,
	center: 'parent'
  });
});
$('#helpGen').click(function (event) {
   $.popupWindow('helpPages/ayudaGeneral.html', {
	 width: 900,
	  height: 600,
	center: 'parent'
  });
});
     
  }); //fn
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
                        <%@ include file="WEB-INF/jspf/barrausuario.jspf" %>
                                <div id="nav">
                                    <ul>
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%>materiales</a></p></li>
                                      <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
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
                            <div id="tablaABM" >
                                    <table class="tablaABM">
                                        <thead>
                                            <tr>
                                           <!--     <th>Id Material</th>   -->
                                                <th>Descripcion</th>
                                                <th>Unidad Medida</th>
                                                <th>Precio</th>
                                                <th colspan="2">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < materiales.size(); i++) {
                                          %>
                                            <tr>
                                            <td  style="width:255px;"><%= materiales.get(i).getDescMaterial()%></td>
                                                <td style="width:105px;"><%= materiales.get(i).getDescUnidadMedida() %></td>
                                                 <td><%= materiales.get(i).getPrecioMa()%></td>
                                                <td  class="imege"><a href="<%= response.encodeURL("nuevoMaterial.jsp?id=" + materiales.get(i).getIdMaterial())%>"><img  src='images/iconEdit.png' class='btnEdit' title ="Editar"></a></td>
                                                 <td  class="imege"><img src='images/trash.png' class='btnDelete'  title="Borrar"></td> 
                                                <td><%= materiales.get(i).getIdMaterial()%></td>   
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
      
    </body>
</html>
