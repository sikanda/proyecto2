<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Rubro"%>
<%@ page import="Entidades.Material"%>
<%@ page import="Entidades.ManoDeObra"%>
<%@ page import="Entidades.Presupuesto"%>
<%@page import="Entidades.Cliente"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>

<%@ taglib tagdir="/WEB-INF/tags" prefix="myTags" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTagsBack" %>

<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />

<%
     //   List<Rubro> rubPresu = new ArrayList();
        List<Rubro> rubPresuDev = new ArrayList();
        
        Presupuesto p = new Presupuesto();
        
         p.setUsuario((Usuario)session.getAttribute("usuario"));
         p.setFechaCreacion(new Date());
   
         p.setRubros((List<Rubro>)session.getAttribute("rubrosLeaf")); //viene de pantalla 1, solo rubros leaf.
        rubPresuDev = p.devolverRubrosPresupuesto();
        
         session.setAttribute("rubrosEnArbol", rubPresuDev); //usado por la pantalla 2
         session.setAttribute("presupuestoActual", p);
         
//         if(request.getParameter("action") != null){
//         System.out.println(request.getParameter("action"));
//         }
       
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
//evitar q se submita el form con enter
$('#frmEditaCants').bind("keyup keypress", function(e) {
  var code = e.keyCode || e.which; 
  if (code  === 13) {               
    e.preventDefault();
    return false;
  }
});

   $("#myTable td.unit").each(function() {
    if ($(this).text().length === 0)
       {
         $(this).prev().find('input:text').remove();
      //  $(this).prev().prev().css("background-color","lightgray");
         $(this).parent().css("background-color","gainsboro");
         $(this).parent().next().css({'font-weight': 'bold', 'font-family': 'Arial'});
}
});
 
$('td:nth-child(4)').hide(); //rubros
$('td:nth-child(5)').hide(); //valores originales

$("#myTable td:nth-child(4)").each(function(){
switch($(this).text().length) {
 case 6:
  (($(this)).prev().prev().prev()).css("text-indent","15px");
  break;
   case 9:
   (($(this)).prev().prev().prev()).css("text-indent","30px");
  break;
 case 12:
   ($(this)).prev().prev().prev().css("text-indent","45px");
  break;
} 
});

//////test
$("#myTable td:nth-child(5)").each(function(){
     if ($(this).text().length === 0)
       {
           alert("entro");
          if ($(this).prev().prev().text().length !== 0)  
          {
              //$(this).parent().css("background-color","yellow");
              alert($(this).prev().prev().text());
          }
       }
});
//////test
 $("#myTable input.edit").keypress(function(e) {
  if(e.keyCode === 13 || e.keyCode === 9)  {//termina edicion
      //parent es el td del input, next es el td de uM
            var tieneClase = $(this).parent().next().hasClass("unit");   
            var newText = $(this).val();
            var rub = $(this).parent().next().next().text();
  
            if(tieneClase){  //se esta editando un rubro leaf
                   $("#myTable td.hidRub").each(function() { //para los mismos mat o mo dentro del rubro q se edita
                   if ($(this).text() === rub   )
                    {   //this es col 4 de rubro
                         var oldVal = $(this).next().text(); //5ta col tiene val sin modif
                         $(this).prev().prev().find('input:text').val(oldVal * newText);
                    }
                });
                }//tiene clase*/
             // anda 
             $("#myTable td.unit").prev().find('input:text').blur();
        } 
   } );
   $("#myTable td.unit:contains('PORC')").text("%"); 
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
                                  <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>edit</a></p></li>
                              </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                          <h2 id="titulo">Editar cantidades</h2>
                          <div id="formu">
                              <form name="frmEditaCants" id="frmEditaCants" action="pantallaTres.jsp" method="POST" autocomplete="on">
                                  <div id="tabla">                  
                                      <table id="myTable" class="tabla" >
                                          <tbody>
                                              <tr><th style="width: 300px;">Descripcion</th><th>Cantidad</th><th>Unidad</th></tr>
                                              <c:choose>
                                            <c:when test="${not empty param.action}">
                                               <c:forEach items="${sessionScope.rubrosEnArbol}" var="rub" >
                                            <myTagsBack:displayRubrosBack rub="${rub}"/> 
                                              </c:forEach>
                                            </c:when>
                                             <c:otherwise>
                                            <c:forEach items="${sessionScope.rubrosEnArbol}" var="rub" >
                                            <myTags:displayRubros rub="${rub}"/> 
                                              </c:forEach>
                                            </c:otherwise>
                                              </c:choose>
                                          </tbody>
                                      </table>

                                  </div>
                                  <input  style="height:25px ; width: 70px;" type="submit" value="Siguiente" />
                               </form>
                          </div>
                      </div>
                  </div>
          </body>
</html>
