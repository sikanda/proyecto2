<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Empleado"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page errorPage="errorPageAdmin.jsp" %>
<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="empleadoDB" scope="page" class="Datos.EmpleadoDB" />

<%
	List<Empleado> empleados = new ArrayList();
	
         try{
             empleados = empleadoDB.getEmpleados();
          }
            catch(Exception e)
            {
                //response.sendRedirect(response.encodeRedirectURL("listaUsuarios.jsp"));
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
  var typ = "Emp";
   $('td:nth-child(8)').hide(); //oculto id 
     $(".btnDelete").bind("click", function(e){
             var par = $(this).parent(); //td
             var pr= par.next();  //idemp q se borra
           // alert(pr.text());
            e.preventDefault(); 
            apprise('¿Está seguro que desea borrar el empleado?',  {'confirm':true}   , function(r) {
              if(r) {  
                  //window.location = "borrarEmpleado.jsp?id=" + pr.text() ; }}
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
           $.popupWindow('helpPages/listaEmpleados_h.html', {
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%>empleados</a></p></li>
                                  <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                                    </ul>
                                    <br class="clear" />
                                </div>
                        </div>
            <div id="main">

                            <div id="opciones">
                                <p>
                                    <a href="<%= response.encodeURL("nuevoEmpleado.jsp")%>">Agregar Empleado</a>
                                </p>
                            </div>

                            <h2 id="titulo">Lista de Empleados</h2>
                            <div id="tablaABM" >
                                    <table class="tablaABM">
                                        <thead>
                                            <tr>
                                             <!--    <th>Id Empleado</th>   -->
                                                <th>Nombre</th>
                                                <th>Apellido</th>
                                                <th>Dirección</th>
                                                <th>Telefono</th>
                                                <th>E-mail</th>
                                            <!--      <th>Fecha nac.</th>-->
                                                <th colspan="2">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < empleados.size(); i++) {
                                          %>
                                            <tr>
                                           <td ><%= empleados.get(i).getNombreEmp()%></td>
                                                <td ><%= empleados.get(i).getApellidoEmp()%></td>
                                                <td ><%= empleados.get(i).getDireEmp()%></td>
                                                 <td ><%= empleados.get(i).getTelEmp()%></td>
                                                <td ><%= empleados.get(i).getEmailEmp()%></td>
                                           <!--    <td><//%= empleados.get(i).getFechaNacEmp()%></td>  -->
                                                <td class="imege"><a href="<%= response.encodeURL("nuevoEmpleado.jsp?id=" + empleados.get(i).getIdEmpleado())%>"><img  src='images/iconEdit.png' class='btnEdit'  title ="Editar"></a></td>
                                              <td class="imege"><img src='images/trash.png' class='btnDelete' title="Borrar"></td>
                                                <td ><%= empleados.get(i).getIdEmpleado()%></td>  
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
