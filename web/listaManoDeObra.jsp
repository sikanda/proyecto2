<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.ManoDeObra"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="manoDeObraDB" scope="page" class="Datos.ManoDeObraDB" />

<%
	List<ManoDeObra> arrayManoDeObra = new ArrayList();
	arrayManoDeObra = manoDeObraDB.getManoDeObra();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><%=globconfig.nombrePag() %></title>
          <%@ include file="WEB-INF/jspf/estilo.jspf" %>
   <script src="js/jquery-1.6.4.min.js" ></script>
 <script type="text/javascript" src="js/apprise.js"></script>
 <script type="text/javascript" src="js/jquery.popupwindow.js"></script>
<link rel="stylesheet" href="estilos/apprise.css" type="text/css" />
<script>
$(function() {
   var typ = "Mo";   
   $('td:nth-child(6)').hide(); //oculto id 
     $(".btnDelete").bind("click", function(e){
             var par = $(this).parent(); //td
             var pr= par.next();  //id  q se borra
           // alert(pr.text());
            e.preventDefault(); 
            apprise('¿Está seguro que desea borrar la mano de obra?',  {'confirm':true}   , function(r) {
              if(r) {  
               //   window.location = "borrarManoDeObra.jsp?id=" + pr.text() ; }}
             $.ajax({
                  url: 'popupBorrar.jsp',
                  type: 'GET',
                  data:  {ident : pr.text(), objeto:typ},
//                  success: function() {
//                     location.reload();  
//                  },
                statusCode: {
                    200: function() {
                   //   apprise ('La mano de obra ha sido dada de baja exitosamente' , function(r) {  if(r) { location.reload(); }});
                      location.reload();
                     },
                    400:function(){
                      apprise ('No se ha podido dar de baja la mano de obra. Verifique que la misma no esté asignada a un rubro.');
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
           $.popupWindow('helpPages/listaManoDeObra_h.html', {
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%>mano de obra</p></li>
                                        <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                                    </ul>
                                    <br class="clear" />
                                </div>
                        </div>
            <div id="main">

                            <div id="opciones">
                                <p>
                                    <a href="<%= response.encodeURL("nuevaManoDeObra.jsp")%>">Agregar Mano de obra</a>
                                </p>
                            </div>

                            <h2 id="titulo">Lista de Mano de obra</h2>
                            <div id="tablaABM" >
                                    <table class="tablaABM">
                                        <thead>
                                            <tr>
                                             <!--   <th>Id Material</th>  -->
                                                <th>Descripcion</th>
                                                <th>Unidad Medida</th>
                                                <th>Precio</th>
                                                <th colspan="2">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < arrayManoDeObra.size(); i++) {
                                          %>
                                            <tr>  
                                                <td  style="width:205px;"><%= arrayManoDeObra.get(i).getDescManoDeObra()%></td>
                                                <td style="width:95px;"><%= arrayManoDeObra.get(i).getDescUnidadMedida()%></td>
                                                 <td><%= arrayManoDeObra.get(i).getPrecioMo()%></td>
                                                <td class="imege"><a href="<%= response.encodeURL("nuevaManoDeObra.jsp?id=" + arrayManoDeObra.get(i).getIdManoDeObra())%>"><img  src='images/iconEdit.png' class='btnEdit' title ="Editar"></a></td>
                                                    <td class="imege"><img src='images/trash.png' class='btnDelete' title="Borrar"></td>
                                                <td><%= arrayManoDeObra.get(i).getIdManoDeObra()%></td>   
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
