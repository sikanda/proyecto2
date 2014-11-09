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
        Presupuesto pres = (Presupuesto)session.getAttribute("presupuestoQueSeEdita");       
        String nomCli = pres.getCliente().getNomApeCli();
        String direCli = pres.getCliente().getDireCli();
        String telCli = pres.getCliente().getTelCli();
        String obs = pres.getObservaciones();
        System.out.println("obs del current pres" + obs) ;
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
            //System.out.println("es perc" + r.getIdRubro());
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
              <script src="js/jquery.validate.js"></script>
              <script type="text/javascript" src="js/jquery.popupwindow.js"></script>

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

/*estilo para los rubros */
   $("#myTable td.unit").each(function() {
    if ($(this).text().length !== 0) {
         $(this).parent().css("background-color","gainsboro");
         $(this).parent().css({'font-weight': 'bold', 'font-family': 'Arial'});
       }
}); 
$("td:contains('total')").parent().css({'font-weight': 'bold', 'font-family': 'Arial'});
$("td:contains('Total')").parent().css({'font-weight': 'bold', 'font-family': 'Arial'});

  var stot = 0;
   $("#myTable td:nth-child(7)").each(function() {
        $this = $(this);
        if ($this.html() !== "") {
            stot += parseFloat($this.html());
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
  
     $("#myTable td.unit:contains('PORC')").text("%"); 
         $('#help').click(function (event) {
   $.popupWindow('helpPages/pantallaTres_h.html', {
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
 var validator = $("#frmPresupuesto").validate({
       rules: {
               nomCli: "required",
              // direCli: "required",
                 telCli:  {
                required: true,
                digits: true,
                maxlength: 10
				}
       },
       messages: {
            nomCli: "Campo requerido",
             //  direCli: "Campo requerido",
                 telCli:  {
                required: "Campo requerido",
                digits: "Teléfono inválido",
		 maxlength: "Máximo 10 números"
            }
        },
       errorPlacement: function(error, element) {
       error.appendTo(element.parent().next());
               },
       errorClass: 'errore'
       });

});

function formatCurrency(total) {
    var neg = false;
    if(total < 0) {
        neg = true;
        total = Math.abs(total);
    }
    return (neg ? "-$" : '$') + parseFloat(total, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString();
};
 function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
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
                                  <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>editar presupuesto</a></p></li>
                             <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                              </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                          <h2 id="titulo">Presupuesto</h2>
                     <div style="font-size: 10px; float: right; margin-right: 70px; margin-top:-15px;">   (*) Campo requerido </div>  
                          <div id="formu">
                              <form id="frmPresupuesto" name="frmPresupuesto" action="pantallaCuatro.jsp?action=u" method="POST">

                   <table class="tablaFormatoABM">
                    <tr>
                        <td>  <label for="nomCli" >   Nombre Cliente:  </label></td>
                        <td>  <input type="text"  id="nomCli" name="nomCli" value="<%= nomCli %>"></td>
                          <td>*</td>
                  </tr>
                         <tr>
                        <td> <label for="direCli" >Dirección: </label></td>
                        <td> <input type="text" id="direCli" name="direCli" value="<%= direCli %>"></td>
                          <td></td>
                  </tr>
                         <tr>
                        <td> <label for="telCli">Teléfono:</label></td>
                        <td>   <input type="text" id="telCli"  name="telCli" onkeypress="return isNumber(event)"  value="<%= telCli %>"></td>
                          <td>*</td>
                  </tr>
                  </table>
                 
                            <div id="tabla">                  
                              <table id="myTable" class="tabla" >
                                  <tbody>
                                      <tr>
                                          <th style="width: 300px;">Descripcion</th>
                                          <th style="text-align: center">Cantidad</th>
                                          <th>Unidad</th>
                                          <th>Precio</th>
                                          <th style="text-align: center">Total</th>
                                      </tr>
                                  <c:forEach items="${sessionScope.rubrosAll}" var="rub" >
                                  <myTags1:displayRubrosPres rub="${rub}"/> 
                                    </c:forEach>
                                         <tr > 
                                        <td> Subtotal:  </td> 
                                        <td></td><!--esto lo usa jquery, no borrar-->
                                        <td></td><!--esto lo usa jquery, no borrar-->
                                            <td></td><!--esto lo usa jquery, no borrar-->
                              
                                        <td></td><!--esto lo usa jquery, no borrar-->
                                       <td  id = "subtotal" ></td>
                                    </tr>
                                      <c:forEach items="${sessionScope.rubrosPerc}" var="rub" >
                                  <myTags2:displayRubrosPerc rub="${rub}"/> 
                                    </c:forEach>
                                          <tr > 
                                        <td> Total General:  </td>
                                         <td></td> <!--esto lo usa jquery, no borrar-->
                                        <td></td><!--esto lo usa jquery, no borrar-->
                                            <td></td><!--esto lo usa jquery, no borrar-->
                                       
                                        <td></td><!--esto lo usa jquery, no borrar-->
                                       <td  id = "totalGral" ></td>
                                    </tr>
                                  </tbody>
                              </table>
                         </div> 
                        <!--       <div   style="  margin-left: 200px; margin-bottom: 20px; text-align: left ">   -->
                                   <div   style="  margin-left: 100px; margin-bottom: 20px; text-align: left ">   
                                 </br>
                               <label for="obs" >Observaciones: </label>    
                                  <textarea id="obs" name="obs" style="resize: none; overflow-y: hidden;vertical-align:middle;width:500px; height:50px;"><%= obs %></textarea>
                                 </br>
                               </div>  
                                  <div style="text-align: center">        
                           <button type="button" style="height:25px ; width: 70px;"><a href="<%= response.encodeURL("editarPresupuesto2.jsp")%>">Atras</a></button>
                        <input type="submit"  id="btnGuardar" name="btnGuardar" value="Guardar" style="height:25px ; width: 70px;" />
                        </div>
                        
                     
                   </form>
                      </div>
                  </div>
                         </div>
                           <%@ include file="WEB-INF/jspf/firma.jspf" %>
        
          </body>
</html>
