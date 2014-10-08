<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Rubro"%>
<%@ page import="Entidades.Material"%>
<%@ page import="Entidades.ManoDeObra"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>



<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<%-- <jsp:useBean id="presupuestoBean" class="Entidades.Presupuesto"  scope="session"/> --%>

<%
    
        Rubro r1 = new Rubro("007011") ;  //007011
      session.setAttribute("rubroEdit", r1);

       
  %>   
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><%=globconfig.nombrePag() %></title>
          <%@ include file="WEB-INF/jspf/estilo.jspf" %>
          <script src="js/jquery-1.6.4.min.js" ></script>	
<script>
   
$(function() { 

$('td:nth-child(6)').hide(); //oculto id en tabla ma y mo
        
$("#btnAddMa").bind("click", AddMa);
$("#btnAddMo").bind("click", AddMo);
$(".btnDelete").bind("click", Delete);
$(".btnEdit").bind("click", Edit);
        
        
 //evitar q se submita el form con enter
$('#frmEditRubro').bind("keyup keypress", function(e) {
  var code = e.keyCode || e.which; 
  if (code  === 13) {               
    e.preventDefault();
    return false;
  }
});    
 
$('#btnGuardar').click(function() {

 var dataMa ="" ;
  $('#tablaMateriales td.aidi').each(function() {//td:nth-child(6)
        dataMa += $(this).text()+":";
      var cantMa = $(this).prev().prev().text()+";";
         dataMa +=cantMa;
     });
     
  var dataMo ="" ;
  $('#tablaManoDeObra td.aidi').each(function() {
        dataMo += $(this).text()+":";
      var cantMo = $(this).prev().prev().text()+";";
         dataMo +=cantMo;
     });    
     
//  $.ajax({
//        type: "POST",
//        url: "test.jsp",
//       data: {dataMObra : dataMo, dataMat:dataMa }  
//       });    
     $('#dataManoDeObra').val(dataMo);    
     $('#dataMateriales').val(dataMa);   
});
 

});

function Delete(){ var par = $(this).parent().parent(); //tr
     par.remove(); };
function AddMa(){
     $("#tablaMateriales tbody").append(
             "<tr>"+ 
             "<td ><input type='text' style=\"width: 280px;\" /></td>" + 
             "<td ><input type='text' style=\"width: 60px;\" /></td>"+ 
             "<td ><input type='text' style=\"width: 60px;\" /></td>"+ 
             "<td ><input type='text' style=\"width: 50px;\" /></td>"+ 
             "<td>  <img src=\'images/save.png\' class=\'btnSave\'> &nbsp;&nbsp; <img src=\'images/trash.png\' class=\'btnDelete\'> </td>"+
             "</tr>");
     $(".btnSave").bind("click", Save);
    $(".btnDelete").bind("click", Delete);
};
function AddMo(){
     $("#tablaManoDeObra tbody").append(
             "<tr>"+ 
             "<td ><input type='text' style=\"width: 280px;\" /></td>" + 
             "<td ><input type='text' style=\"width: 60px;\" /></td>"+ 
             "<td ><input type='text' style=\"width: 60px;\" /></td>"+ 
             "<td ><input type='text' style=\"width: 50px;\" /></td>"+ 
             "<td>  <img src=\'images/save.png\' class=\'btnSave\'> &nbsp;&nbsp; <img src=\'images/trash.png\' class=\'btnDelete\'> </td>"+
             "</tr>");
     $(".btnSave").bind("click", Save);
    $(".btnDelete").bind("click", Delete);
};
function Edit(){ var par = $(this).parent().parent(); //tr
 var tdDesc = par.children("td:nth-child(1)");
 var tdUnit = par.children("td:nth-child(2)");
 var tdPrecio = par.children("td:nth-child(3)"); 
 var tdCant = par.children("td:nth-child(4)"); 
 var tdButtons = par.children("td:nth-child(5)");
 tdDesc.html("<input type='text' style=\"width: 280px;\" id='txtDesc' value='"+tdDesc.html()+"'/>"); 
 tdUnit.html("<input type='text' style=\"width: 60px;\" id='txtUnit' value='"+tdUnit.html()+"'/>");
 tdPrecio.html("<input type='text' style=\"width: 60px;\" id='txtPrecio' value='"+tdPrecio.html()+"'/>");
 tdCant.html("<input type='text' style=\"width: 50px;\" id='txtCant' value='"+tdCant.html()+"'/>"); 
 tdButtons.html("<img src=\'images/save.png\' class=\'btnSave\'>"); 
 $(".btnSave").bind("click", Save); 
 $(".btnEdit").bind("click", Edit); 
 $(".btnDelete").bind("click", Delete); 
 };
function Save(){ 
 var par = $(this).parent().parent(); //tr 
 var tdDesc = par.children("td:nth-child(1)");
 var tdUnit = par.children("td:nth-child(2)");
 var tdPrecio = par.children("td:nth-child(3)"); 
 var tdCant = par.children("td:nth-child(4)"); 
 var tdButtons = par.children("td:nth-child(5)");
tdDesc.html(tdDesc.children("input[type=text]").val()); 
tdUnit.html(tdUnit.children("input[type=text]").val()); 
tdPrecio.html(tdPrecio.children("input[type=text]").val()); 
tdCant.html(tdCant.children("input[type=text]").val()); 
tdButtons.html("<img src=\'images/iconEdit.png\' class=\'btnEdit\'/>&nbsp;&nbsp;<img src=\'images/trash.png\' class=\'btnDelete\'/>"); 
$(".btnEdit").bind("click", Edit); 
$(".btnDelete").bind("click", Delete); 
}; 

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
                                  <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>edit</a></p></li>
                              </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                          <h2 id="titulo">Editar rubro</h2>
                          <div id="formu">
                              <form name="frmEditRubro" id="frmEditRubro" method="POST" action="test.jsp" >
                        <div  >  
                       <div style="  margin-left: 100px; margin-bottom: 20px; margin-top: -20px; text-align: left ">
                           
                              <label for="idRubro" >Id. Rubro &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp      </label>
                              <input   disabled="true" type="text"  id="idRubro" name="idRubro" style="width:500px;" value="${sessionScope.rubroEdit.idRubro}" /><br/>  
                           
                            <label for="descRubro" >Descripcion  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp   </label>
                           <input type="text"  id="descRubro" name="descRubro" style="width:500px;" value="${sessionScope.rubroEdit.descRubro}" /><br/>   
                         
                           <label for="unidadMedida" >Unidad de medida </label> 
                          <input type="text"  id="unidadMedida" name="unidadMedida" style="width:500px;" value="${sessionScope.rubroEdit.idUnidadMedida}" /><br/>
                         
                       </div>   
                         <c:if test="${not empty sessionScope.rubroEdit.materiales}">    
                            <p style="  margin-left: 100px; margin-bottom: 1px;  text-align: left ">Materiales</p>
                         
                            <table id="tablaMateriales" class="tabla">
                                <tbody>
                                    <tr>
                                      <th style="width: 300px;">Descripcion</th>
                                        <th>Unidad</th>
                                        <th>Precio</th>
                                        <th>Cant. Estandar</th>
                                          <th>Acciones</th> 
                                          <!--  <th>Codigo</th> oculto!! por jquery-->
                                    </tr>
                                            <c:forEach items="${sessionScope.rubroEdit.materiales}" var="mat" >
                                        <tr >
                                           
                                            <td><c:out value= "${mat.descMaterial}"/></td> 
                                            <td><c:out value= "${mat.idUnidadMedida}"/></td> 
                                            <td><c:out value= "${mat.precioMa}" /></td>  
                                            <td><c:out value= "${mat.coefStdMat}" /></td>  
                                            <td><img src='images/iconEdit.png' class='btnEdit'>&nbsp;&nbsp;<img src='images/trash.png' class='btnDelete'> </td>
                                             <td class="aidi"><c:out value= "${mat.idMaterial}"/></td> 
                                         </tr>
                                            </c:forEach>
                                  
                                 </tbody>
                            </table>
                            <tr ><td colspan="6">   <button type="button" id="btnAddMa" style="height:25px ; width: 70px;"> Agregar</button></td>  </tr>
                         </c:if>
                        </div>
                          </br> 
                          <div  >  
                               <c:if test="${not empty sessionScope.rubroEdit.manoDeObra}">
                                      <p style="  margin-left: 100px; margin-bottom: 1px; text-align: left ">Mano de Obra</p>
                                      <table id="tablaManoDeObra" class="tabla">
                                          <tbody>
                                              <tr>
                                               <!--    <th>Codigo</th> oculto!! por jquery-->
                                                  <th style="width: 300px;">Descripcion</th>
                                                  <th>Unidad</th>
                                                  <th>Precio</th>
                                                  <th>Cant. Estandar</th>
                                                   <th>Acciones</th>
                                              </tr>
                                                      <c:forEach items="${sessionScope.rubroEdit.manoDeObra}" var="mo" >
                                                  <tr >
                                                     
                                                      <td><c:out value= "${mo.descManoDeObra}"/></td> 
                                                      <td><c:out value= "${mo.idUnidadMedida}"/></td> 
                                                      <td><c:out value= "${mo.precioMo}" /></td> 
                                                      <td><c:out value= "${mo.coefStdMO}" /></td>
                                                       <td><img src='images/iconEdit.png' class='btnEdit'>&nbsp;&nbsp;<img src='images/trash.png' class='btnDelete'> </td>
                                                    <td class="aidi"><c:out value= "${mo.idManoDeObra}"/></td>
                                                  </tr>
                                              </c:forEach>
                                          </tbody>
                                      </table>
                                         <tr ><td colspan="6">   <button type="button" id="btnAddMo" style="height:25px ; width: 70px;"> Agregar</button></td>  </tr>
                                    </c:if>
                                  </div>        
                          
                           <div style="text-align: center">   
                                      </br>
                           <button type="button" id="btnAtras" name="btnAtras" style="height:25px; width: 70px;" > Atras</button>
                        <input type="submit"  id="btnGuardar" name="btnGuardar" value="Guardar" style="height:25px ; width: 70px;" />
                       
                             <input type="hidden" id="dataMateriales" name="dataMateriales" value="pepe"/>
                             <input type="hidden" id="dataManoDeObra" name="dataManoDeObra"/>
                          </div>
                               </form>
                          </div>
                      </div>
                  </div>
          </body>
</html>
