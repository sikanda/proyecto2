<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Rubro"%>
<%@ page import="Entidades.Material"%>
<%@ page import="Entidades.ManoDeObra"%>
<%@ page import="Entidades.Presupuesto"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ taglib tagdir="/WEB-INF/tags" prefix="myTags1" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTags2" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="rubroDB" scope="page" class="Datos.RubroDB" />

<%
        List<Rubro> arrayRub = (List<Rubro>)session.getAttribute("rubrosLeaf");//necesito si o si los leaf para esto
        Rubro rubro = new Rubro();
        Material material = new Material();
        ManoDeObra manodeobra = new ManoDeObra();
        Enumeration<String> parameterNames = request.getParameterNames();
        List<Material> arrayMateriales;
        List<ManoDeObra> arrayManoDeObra;

        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            for (int i = 0; i < arrayRub.size(); i++) {
                if (paramName.equals(arrayRub.get(i).getIdRubro())) { //si no son leaf nunca entra aca
                    rubro = arrayRub.get(i);
                    rubro.setCantPresRub(Float.parseFloat(paramValues[0]));
                   
                     int k = 1;
                 //   for (int k = 1; k < paramValues.length; k++) {
                      //  String paramValue = paramValues[k];
                        arrayMateriales = rubro.getMateriales();
                        arrayManoDeObra = rubro.getManoDeObra();

                        for (int h = 0; h < arrayMateriales.size(); h++) {
                            material = arrayMateriales.get(h);
                            material.setCantPres(Float.parseFloat(paramValues[k]));
                            k++;
                        }
                        for (int h = 0; h < arrayManoDeObra.size(); h++) {
                            manodeobra = arrayManoDeObra.get(h);
                            manodeobra.setCantPres(Float.parseFloat(paramValues[k]));
                            k++;
                        }
                  // }
                }
            }
        }
        ArrayList<Rubro> rubrosAll = new ArrayList<Rubro>();
        ArrayList<Rubro> rubrosPerc = new ArrayList<Rubro>();
        List bdPerc = rubroDB.getRubrosPorc();
        
       List<Rubro> todosLosRubros = (List<Rubro>)session.getAttribute("rubrosEnArbol"); 
        // for(Rubro r : todosLosRubros){     //son los padres aca
           for(Rubro r : arrayRub){   
        //if(r.getIdRubro().equals("022")|| r.getIdRubro().equals("023")|| r.getIdRubro().equals("024")|| r.getIdRubro().equals("018")|| r.getIdRubro().equals("025"))
       if (bdPerc.contains(r.getIdRubro()))
         {
            rubrosPerc.add(r);
            System.out.println("es perc" + r.getIdRubro());
        }else{
           rubrosAll.add(r); 
        }
    }
         session.setAttribute("rubrosAll", rubrosAll);
         session.setAttribute("rubrosPerc", rubrosPerc);

        
  %>   
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><%=globconfig.nombrePag() %></title>
          <%@ include file="WEB-INF/jspf/estilo.jspf" %>
          <script src="js/jquery-1.6.4.min.js" ></script>	

<script>
$(function() {
 $('td:nth-child(4)').hide(); //rubros
$('td:nth-child(7)').hide(); //total linea en formato number
    
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
//blanqueo las cants q no tienen um (not a leaf node)
   $("#myTable td.unit").each(function() {
    if ($(this).text().length === 0)
       {
         $(this).prev().html("");
         $(this).parent().css("background-color","gainsboro");
         $(this).parent().next().css({'font-weight': 'bold', 'font-family': 'Arial'});
       }
}); 
  var stot = 0;
   $("#myTable td:nth-child(7)").each(function() {
        $this = $(this);
        if ($this.html() !== "") {
            stot += parseInt($this.html());
        }
    });
    $("#subtotal").html(formatCurrency(stot));
    
    
    var totPerc = 0;
  $("#myTable td.unit:contains('PORC')").each(function() {
    var inp = $(this).prev().text();
    var result = (inp/100)*stot;
    $(this).next().next().next().text(formatCurrency(result));
    $(this).next().next().next().next().text(result);
     totPerc +=result;
    });   

   $("#totalGral").html(formatCurrency(stot+totPerc));
   
$("#myTable td.unit:contains('PORC')").text("%"); 

$('td:nth-child(6)').css({
  'text-align':'right',
  'margin-right':'10px'});
  
$('td:nth-child(5)').css({
  'text-align':'right',
  'margin-right':'10px'});
  
  $('td:nth-child(2)').css({
  'text-align':'justify',
  'margin-right':'10px'});
});

function formatCurrency(total) {
    var neg = false;
    if(total < 0) {
        neg = true;
        total = Math.abs(total);
    }
    return (neg ? "-$" : '$') + parseFloat(total, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString();
}
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
                                  <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>generar presupuesto</a></p></li>
                              </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                          <h2 id="titulo">Presupuesto</h2>
              
                          <div id="formu">
                              <form name="frmPresupuesto" action="pantallaCuatro.jsp" method="POST">
                                  
                                                 
                         <div   style="  margin-left: 100px; margin-bottom: 20px; text-align: left; margin-right: 160px; margin-top:-10px; "> 
                            <label for="nomCli" >   Nombre Cliente:  </label>
                             <input type="text"  id="nomCli" name="nomCli" style="width:500px; float:right;"  /><br/>
                             
                             <label for="direCli" >Dirección: </label>
                            <input type="text" id="direCli" name="direCli" style="width:500px; float:right;  "  /><br/>
                                 <label for="telCli">Teléfono:</label>
                            <input type="text" id="telCli"  name="telCli" style="width:500px; float:right;"  /><br/>
                         </div>
                            <div id="tabla">                  
                              <table id="myTable" class="tabla" >
                                  <tbody>
                                      <tr>
                                          <th style="width: 300px;">Descripcion</th>
                                          <th>Cantidad</th>
                                          <th>Unidad</th>
                                          <th>Precio</th>
                                          <th>Total</th>
                                      </tr>
                                  <c:forEach items="${sessionScope.rubrosAll}" var="rub" >
                                  <myTags1:displayRubrosPres rub="${rub}"/> 
                                    </c:forEach>
                                         <tr > 
                                        <td colspan="4"> Subtotal:  </td>  
                                       <td  id = "subtotal" ></td>
                                    </tr>
                                      <c:forEach items="${sessionScope.rubrosPerc}" var="rub" >
                                  <myTags2:displayRubrosPerc rub="${rub}"/> 
                                    </c:forEach>
                                          <tr > 
                                        <td colspan="4"> Total General:  </td>  
                                       <td  id = "totalGral" ></td>
                                    </tr>
                                  </tbody>
                              </table>
                         </div> 
                               <div   style="  margin-left: 100px; margin-bottom: 20px; text-align: left ">   
                                 </br>
                               <label for="obs" >Observaciones: </label>    
                                  <textarea id="obs" style="resize: none; overflow-y: hidden;vertical-align:middle;width:530px; height:50px;"></textarea>
                                 </br>
                               </div>  
                                  <div style="text-align: center">        
                           <button type="button" style="height:25px ; width: 70px;"><a href="<%= response.encodeURL("pantallaDos.jsp?action=back")%>">Atras</a></button>
                        <input type="submit"  id="btnGuardar" name="btnGuardar" value="Guardar" style="height:25px ; width: 70px;" />
                        </div>
                        
                     
                   </form>
                      </div>
                  </div>
                         </div>
                           <%@ include file="WEB-INF/jspf/firma.jspf" %>
              </div>
          </body>
</html>
