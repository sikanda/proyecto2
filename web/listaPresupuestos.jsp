<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Presupuesto"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page errorPage="errorPageUser.jsp" %>
<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="presupuestoDB" scope="page" class="Datos.PresupuestoDB" />

<%
	List<Presupuesto> presus = new ArrayList();
	
      try{
         presus = presupuestoDB.getPresupuestos();
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
 <script src="dist/libs/jquery.js" ></script>
 <script type="text/javascript" src="js/apprise.js"></script>
<script type="text/javascript" src="js/jquery.popupwindow.js"></script>
<link rel="stylesheet" href="estilos/apprise.css" type="text/css" />
<script>
$(function() {
    var typ = "Pres";
  $('td:nth-child(8)').hide(); //oculto id 
     $(".btnDelete").bind("click", function(e){
             var par = $(this).parent(); //td
             var pr= par.next();  //id  q se borra
            e.preventDefault(); 
            apprise('¿Está seguro que desea borrar el presupuesto?',  {'confirm':true}   , function(r) {
              if(r) {  
                  $.ajax({
                  url: 'popupBorrar.jsp',
                  type: 'GET',
                  // data:  {ident : pr.text()},  //works fine
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
        $.popupWindow('helpPages/listaPresupuestos_h.html', {
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>presupuestos</p></li>
                                      <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                                    </ul>
                                    <br class="clear" />
                                </div>
                        </div>
            <div id="main">
                            <div id="opciones">
                                <p>
                                    <a href="<%= response.encodeURL("listaRubros.jsp")%>">Agregar Presupuesto</a>
                                </p>
                            </div>

                            <h2 id="titulo">Lista de Presupuestos</h2>
                            <div id="tablaABM" >
                                    <table class="tablaABM">
                                        <thead>
                                            <tr>
                                               <th >Cliente</th>
                                                <th >Teléfono</th>
                                                <th >Observaciones</th>
                                                 <th >Usuario</th>
                                                  <th >Fecha creación</th>
                                                <th colspan="2" >Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                for (int i = 0; i < presus.size(); i++) {
                                         %>
                                            <tr>
                                               <td style="width:120px;" ><%= presus.get(i).getCliente().getNomApeCli()%></td>
                                               <td  ><%= presus.get(i).getCliente().getTelCli()%></td>
                                                <td style="width:120px;" ><%= presus.get(i).getObservaciones()%></td>
                                              <td ><%= presus.get(i).getUsuario().getNombreUsuario() %></td>
                                                <td style="width:100px;"><%= presus.get(i).getFechaCreacion()  %></td>
                                                <td class="imege"><a href="<%= response.encodeURL("editarPresupuesto.jsp?id=" + presus.get(i).getIdPresupuesto())%>"><img  src='images/iconEdit.png' class='btnEdit' title ="Editar"></a></td>
                                                <td class="imege"><img src='images/trash.png' class='btnDelete' title="Borrar"></td>
                                             <td><%= presus.get(i).getIdPresupuesto()%></td> 
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
