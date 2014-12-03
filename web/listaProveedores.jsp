<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Proveedor"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page errorPage="errorPageUser.jsp" %>
<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="proveedorDB" scope="page" class="Datos.ProveedorDB" />

<%
	List<Proveedor> proveedores = new ArrayList();
	
     try{
         proveedores = proveedorDB.getProveedores();
          }
            catch(Exception e)
            {
                throw new RuntimeException("Error!");
            }
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
  var typ = "Prov";  
   $('td:nth-child(7)').hide(); //oculto id 
     $(".btnDelete").bind("click", function(e){
             var par = $(this).parent(); //td
             var pr= par.next();  //idProv q se borra
           // alert(pr.text());
            e.preventDefault(); 
            apprise('¿Está seguro que desea borrar el proveedor?',  {'confirm':true}   , function(r) {
              if(r) {  
                 // window.location = "borrarProveedor.jsp?id=" + pr.text() ; }}
           $.ajax({
                  url: 'popupBorrar.jsp',
                  type: 'GET',
                  data:  {ident : pr.text(), objeto:typ},
                  success: function() {
                     location.reload();  
                  },
                  error: function(e) {
                   apprise ('Ha ocurrido un error');
                  }
                }); //ajax 
                }//if r   
         }); //apprise
     }); //click
     $('#help').click(function (event) {
   $.popupWindow('helpPages/listaProveedores_h.html', {
	 width: 900,
	  height: 600,
	center: 'parent'
  });
});
$('#helpGen').click(function (event) {
   $.popupWindow('helpPages/index.html', {
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>proveedores</a></p></li>
                                <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                                    </ul>
                                    <br class="clear" />
                                </div>
                        </div>
            <div id="main">

                            <div id="opciones">
                                <p>
                                    <a href="<%= response.encodeURL("nuevoProveedor.jsp")%>">Agregar Proveedor</a>
                                </p>
                            </div>

                            <h2 id="titulo">Lista de Proveedores</h2>
                            <div id="tablaABM" >
                                    <table class="tablaABM">
                                        <thead>
                                            <tr>
                                                <th>Razón Social</th>
                                                <th>Dirección</th>
                                                <th>Telefono</th>
                                                <th>E-mail</th>
                                                <th colspan="2">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < proveedores.size(); i++) {
                                          %>
                                    <tr>
                                       <td style="width:180px;"><%= proveedores.get(i).getRazonSocial()%></td>
                                        <td style="width:110px;"><%= proveedores.get(i).getDireProv()%></td>
                                        <td><%= proveedores.get(i).getTelProv()%></td>
                                        <td  style="width:90px;"><%= proveedores.get(i).getEmailProv()%></td>
                                        <td class="imege"><a href="<%= response.encodeURL("nuevoProveedor.jsp?id=" + proveedores.get(i).getIdProveedor())%>"><img  src='images/iconEdit.png' class='btnEdit'  title ="Editar"></a></td>
                                       <td class="imege"><img src='images/trash.png' class='btnDelete'  title="Borrar"></td>
                                       <td><%= proveedores.get(i).getIdProveedor()%></td>
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
