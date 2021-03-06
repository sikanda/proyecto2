<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Rubro"%>
<%@ page import="Entidades.Material"%>
<%@ page import="Entidades.ManoDeObra"%>
<%@ page import="Entidades.UnidadMedida"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ page errorPage="errorPageAdmin.jsp" %>

<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="materialDB" scope="page" class="Datos.MaterialDB" />
<jsp:useBean id="manoDeObraDB" scope="page" class="Datos.ManoDeObraDB" />
<jsp:useBean id="unidadMedidaDB" scope="page" class="Datos.UnidadMedidaDB" />
<%-- <jsp:useBean id="presupuestoBean" class="Entidades.Presupuesto"  scope="session"/> --%>

<%
       Rubro r1 = (Rubro)session.getAttribute("rubroEdit");  //supongo q ya lo seteo la otra pag

       List<Material> materiales = new ArrayList();
       List<ManoDeObra> manoDeObra = new ArrayList();   
       List<UnidadMedida> unidadesM = new ArrayList();     
        
       try{
            materiales = materialDB.getMateriales();
            manoDeObra = manoDeObraDB.getManoDeObra();
            unidadesM = unidadMedidaDB.getUnidadesDeMedida();
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
          <script src="js/jquery-ui.js"></script>
		  <script src="js/jquery.validate.js"></script>
          <script type="text/javascript" src="js/jquery.popupwindow.js"></script>
       <link rel="stylesheet" href="estilos/jquery-ui.css">
  <style>
    .ui-dialog-title{
    font-size: 160% !important;
    text-align: center;
}
   .ui-button-text {
    font-size: 10px; /* change font size */
    padding: 1px 1px 1px 1px; /* change padding */
}
.ui-dialog-titlebar-close {
  visibility: hidden;
}

select:disabled  {
color: #666; opacity: 1;    background: #EBEBE4;
}
  </style>

<script>
   
$(function() { 

$('td:nth-child(6)').hide(); //oculto id en tabla ma y mo

$(".btnDelete").bind("click", Delete);
$(".btnEdit").bind("click", Edit);
 ///////////////////MATERIALES////////////////////////////////////////////////////        
$('#btnAddMa').click(function() { 
   $( "#dialog-form-mat" ).dialog( "open" );
    });
 
dialog = $( "#dialog-form-mat" ).dialog({
autoOpen: false,
height: 300,
width: 510,//350,
modal: true,
buttons: {
//"Agregar": sub //addMat
Agregar: function() {
  $('#frmDialogMat').submit();
  }
,Cancelar: function() {
      $("#dropMat").val("");
      $("#unit").val("");
      $("#prec").val("");
      $("#cantstd").val(""); 
  dialog.dialog( "close" );}
}
}).css("font-size", "12px");

// form = dialog.find( "frmDialogMat" ).on( "submit", function( event ) {
//      event.preventDefault();
//      addMat();
//    });
//    function sub(){$('#frmDialogMat').submit();}
    function addMat() {
             $("#tablaMateriales tbody").append(
             "<tr>"+ 
             "<td >"+$("#dropMat option:selected").text()+"</td>" + 
            "<td >"+$("#unit").val()+"</td>" + 
            "<td >$"+$("#prec").val()+"</td>" + 
            "<td >"+$("#cantstd").val()+"</td>" + 
             "<td><img src=\'images/iconEdit.png\' class=\'btnEdit\'>&nbsp;&nbsp;<img src=\'images/trash.png\' class=\'btnDelete\'></td>"+
             "<td class = \"aidi\">"+$("#dropMat").val()+"</td>"+ 
                "</tr>");
      $('td:nth-child(6)').hide();  ////ojo con esto. aca esta el cod q tiene q estar lleno.
    $(".btnEdit").bind("click", Edit); 
    $(".btnDelete").bind("click", Delete);
     $("#dropMat option[value='"+$("#dropMat").val()+"']").remove();
      $("#dropMat").val("");
      $("#unit").val("");
      $("#prec").val("");
      $("#cantstd").val(""); 
    dialog.dialog( "close" );
}
      
$("#dropMat").change(function() { 
    //alert($(this).val()); 
    var ide=$(this).val();
         
$.ajax({
  url: 'popupMateriales.jsp',
  type: 'GET',
  data:  {currentMat : ide},
  success: function(data) {
	//called when successful
        var resultado = data.split(":");
	$("#unit").val(resultado[0]);
        $("#prec").val(resultado[1]);
        $("#cantstd").val("0.0");
  },
  error: function(e) {
            alert("error");
  }
}); //ajax mat
 });  //cmobo change

  ////////////////////// MANO DE OBRA //////////////////////////////////////////////////       
  $('#btnAddMo').click(function() { 
   $( "#dialog-form-mo" ).dialog( "open" );
    });
 
dialog2 = $( "#dialog-form-mo" ).dialog({
autoOpen: false,
height: 300,
width: 480, //350,
modal: true,
buttons: {
//"Agregar": subMo //addMo
Agregar: function() {
     $('#frmDialogMo').submit();

 }
,Cancelar: function() {
     $("#dropMo").val("");
      $("#unitMo").val("");
      $("#precMo").val("");
      $("#cantstdMo").val("");
dialog2.dialog( "close" );}
}
}).css("font-size", "12px");

// form2 = dialog2.find( "frmDialogMo" ).on( "submit", function( event ) {
//      event.preventDefault();
//      addMo();
//    });
//    function subMo(){$('#frmDialogMo').submit();}
    function addMo() {
             $("#tablaManoDeObra tbody").append(
             "<tr>"+ 
             "<td >"+$("#dropMo option:selected").text()+"</td>" + 
            "<td >"+$("#unitMo").val()+"</td>" + 
            "<td >$"+$("#precMo").val()+"</td>" + 
            "<td >"+$("#cantstdMo").val()+"</td>" + 
             "<td><img src=\'images/iconEdit.png\' class=\'btnEdit\'>&nbsp;&nbsp;<img src=\'images/trash.png\' class=\'btnDelete\'></td>"+
             "<td class = \"aidi\">"+$("#dropMo").val()+"</td>"+ 
                "</tr>");
      $('td:nth-child(6)').hide();  ////ojo con esto. aca esta el cod q tiene q estar lleno.
    $(".btnEdit").bind("click", Edit); 
    $(".btnDelete").bind("click", Delete);
    $("#dropMo option[value='"+$("#dropMo").val()+"']").remove();
      $("#dropMo").val("");
      $("#unitMo").val("");
      $("#precMo").val("");
      $("#cantstdMo").val(""); 
    dialog2.dialog( "close" );
}
       
$("#dropMo").change(function() { 
    //alert($(this).val()); 
    var ide=$(this).val();
         
$.ajax({
  url: 'popupManoDeObra.jsp',
  type: 'GET',
  data:  {currentMo : ide},
  success: function(data) {
	//called when successful
        var resultado = data.split(":");
	$("#unitMo").val(resultado[0]);
        $("#precMo").val(resultado[1]);
        $("#cantstdMo").val("0.0");
  },
  error: function(e) {
            alert("error");
  }
}); //ajax mo
 });  //cmobo change

 //////////////////////////////////////////////////////////////////////////////////////   

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
        dataMa += $.trim($(this).text())+":";
      var cantMa = $(this).prev().prev().text()+";";
         dataMa +=cantMa;
     });
     
  var dataMo ="" ;
  $('#tablaManoDeObra td.aidi').each(function() {
        dataMo += $(this).text()+":";
      var cantMo = $(this).prev().prev().text()+";";
         dataMo +=cantMo;
     });    
   
   if (dataMa === ""){dataMa = "vacio";}
   if (dataMo === ""){dataMo = "vacio";}

if( $("#dropUm").val() ==="PORC" )//porc no lleva mamo
{ dataMo = "vacio"; dataMa = "vacio";}
   
    $('#dataManoDeObra').val(dataMo);    
    $('#dataMateriales').val(dataMa);
    
});
// alert($("#unidadMedida").val() );

if( $('#unidadMedida').val() ==="" )
{  
$('select[name="dropUm"]').find('option:contains("Rubro general")').attr("selected",true);
$('#dropUm').attr("disabled", 'disabled');
}
else{
$("#dropUm option[value='RG']").remove();
//$("#dropUm option[value='PORC']").remove(); 
$("#dropUm").val($("#unidadMedida").val() );
}

$("#dropUm").change(function() { 
if( $("#dropUm").val() ==="PORC")
{
   $("#divContenedorMa").hide(500); 
   $("#divContenedorMo").hide(500); 
}
else
{
   $("#divContenedorMa").show(500); 
   $("#divContenedorMo").show(500); 
}
});

if( $("#unidadMedida").val() ==="PORC")
{
   $("#divContenedorMa").hide(); 
   $("#divContenedorMo").hide(); 
}

//exclusivo de editar rubro. saco del combo lo q haya en la tabla
    $("#tablaMateriales td.aidi").each(function() {
       // alert($(this).text());
 $("#dropMat option[value='"+$(this).text()+"']").remove();
});

   $("#tablaManoDeObra td.aidi").each(function() {
 $("#dropMo option[value='"+$(this).text()+"']").remove();
});

 $('#help').click(function (event) {
   $.popupWindow('helpPages/editarRubro1_h.html', {
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

var id= $( "#idRubro" ).val();
//seccion validacion datos rubro
        var validator = $("#frmEditRubro").validate({
       rules: {
              // descRubro: "required",
               descRubro: {
                required: true, 
               remote: {
                 url: "popupValida.jsp",
                 type: "post",
                 data: {
                     ide: id,  //alta
                   tipo: "Rub",  
                   desc: function() {
                     return $( "#descRubro" ).val();
                   }
                 }
               }
               },
               dropUm: "required"
               
       },
       messages: {
              // descRubro: "Campo requerido",
                descRubro: 
              { required: "Campo requerido",
                remote: "No disponible"},
               dropUm: "Campo requerido"
      
        },
       errorPlacement: function(error, element) {
       error.appendTo(element.parent().next());
               },
       errorClass: 'errore'
       });
       
     //seccion validacion dialog ma
        var validator2 = $("#frmDialogMat").validate({
       rules: {
               dropMat: "required",
               cantstd: {
                        required: true,
                        number: true,
                          min: 0.01
                      }
               },
       messages: {
               dropMat: "Campo requerido",
                cantstd: {
                        required: "Campo requerido",
                        number: "Cantidad inválida", 
                        min: "Debe ser mayor a 0" }
                 },
       errorPlacement: function(error, element) {
       error.appendTo(element.parent().next());
               },
        submitHandler: function() {
                        addMat();
                 },
       errorClass: 'errore'
       });  
       
        //seccion validacion dialog mo
        var validator3 = $("#frmDialogMo").validate({
       rules: {
               dropMo: "required",
               cantstdMo: {
                        required: true,
                        number: true,
                          min: 0.01
                      }
               },
       messages: {
               dropMo: "Campo requerido",
                cantstdMo: {
                        required: "Campo requerido",
                        number: "Cantidad inválida", 
                        min: "Debe ser mayor a 0" }
                 },
       errorPlacement: function(error, element) {
       error.appendTo(element.parent().next());
               },
        submitHandler: function() {
                        addMo();
                 },
       errorClass: 'errore'
       });
});

function Delete(){ var par = $(this).parent().parent(); //tr
     par.remove(); };
function Edit()  { var par = $(this).parent().parent(); //tr
 var tdDesc = par.children("td:nth-child(1)");
 var tdUnit = par.children("td:nth-child(2)");
 var tdPrecio = par.children("td:nth-child(3)"); 
 var tdCant = par.children("td:nth-child(4)"); 
 var tdButtons = par.children("td:nth-child(5)");
 var toErase = tdCant.html();
 tdDesc.html("<input type='text' style=\"width: 280px; float:none; \" id='txtDesc' disabled=true  value='"+ $.trim(tdDesc.html())+"'/>"); 
 tdUnit.html("<input type='text' style=\"width: 60px; float:none;\" id='txtUnit' disabled=true value='"+tdUnit.html()+"'/>");
 tdPrecio.html("<input type='text' style=\"width: 60px; float:none;\" id='txtPrecio' disabled=true  value='"+tdPrecio.html()+"'/>");
 tdCant.html("<input type='text' style=\"width: 50px; float:none;\" id='txtCant' class='cantEditada' onkeypress=\"return numbersOnly(this, event);\" value='"+tdCant.html()+"'/>"); 
 tdButtons.html("<img src=\'images/save.png\' class=\'btnSave\'>&nbsp;&nbsp;<img src=\'images/cancel.gif\' class=\'btnCancel\'/>"); 
$(".btnSave").bind("click", Save); 
 $(".btnEdit").unbind("click", Edit); 
$(".btnDelete").unbind("click", Delete); 
$(".unBoton").attr("disabled", 'disabled'); 
       // $(".btnCancel").bind("click", Cancel); //Cancel(toErase)); 
       $(".btnCancel").click({param1: toErase}, Cancel);
       
 };
function Save()  { 
 var par = $(this).parent().parent(); //tr 
 //alert($(".cantEditada").val());
    if($(".cantEditada").val().length !==0){ 

 var tdDesc = par.children("td:nth-child(1)");
 var tdUnit = par.children("td:nth-child(2)");
 var tdPrecio = par.children("td:nth-child(3)"); 
 var tdCant = par.children("td:nth-child(4)"); 
  var tdButtons = par.children("td:nth-child(5)");
 var tdCod = par.children("td:nth-child(6)");
tdDesc.html(tdDesc.children("input[type=text]").val()); 
tdUnit.html(tdUnit.children("input[type=text]").val()); 
tdPrecio.html(tdPrecio.children("input[type=text]").val()); 
tdCant.html(tdCant.children("input[type=text]").val()); 
tdButtons.html("<img src=\'images/iconEdit.png\' class=\'btnEdit\'/>&nbsp;&nbsp;<img src=\'images/trash.png\' class=\'btnDelete\'/>"); 
tdCod.html(tdCod.children("input[type=text]").val()); 
$(".btnEdit").bind("click", Edit); 
$(".btnDelete").bind("click", Delete); 
$('.unBoton').removeAttr("disabled", 'disabled');  }
else
{
   $(this).parent().prev().find('img').hide();
   $(this).parent().prev().append('<img src= "images/unchecked.gif">');
}

}; 
function Cancel(event)  { 
 var par = $(this).parent().parent(); //tr 
 var tdDesc = par.children("td:nth-child(1)");
 var tdUnit = par.children("td:nth-child(2)");
 var tdPrecio = par.children("td:nth-child(3)"); 
 var tdCant = par.children("td:nth-child(4)"); 
  var tdButtons = par.children("td:nth-child(5)");
 var tdCod = par.children("td:nth-child(6)");
tdDesc.html(tdDesc.children("input[type=text]").val()); 
tdUnit.html(tdUnit.children("input[type=text]").val()); 
tdPrecio.html(tdPrecio.children("input[type=text]").val()); 
tdCant.html(event.data.param1); 
tdButtons.html("<img src=\'images/iconEdit.png\' class=\'btnEdit\'/>&nbsp;&nbsp;<img src=\'images/trash.png\' class=\'btnDelete\'/>"); 
tdCod.html(tdCod.children("input[type=text]").val()); 
$(".btnEdit").bind("click", Edit); 
$(".btnDelete").bind("click", Delete); 
$('.unBoton').removeAttr("disabled", 'disabled'); 
};
function numbersOnly(oToCheckField, oKeyEvent) {        
  var s = String.fromCharCode(oKeyEvent.charCode);
  var containsDecimalPoint = /\./.test(oToCheckField.value);
  return oKeyEvent.charCode === 0 || /\d/.test(s) || 
      /\./.test(s) && !containsDecimalPoint;
}


</script>
    </head>
          <body>
 <!-- DIALOG MANO DE OBRA START -->
   <div id="dialog-form-mo" name="dialog-form-mo" title="Elegir Mano de Obra"   >
                  <form name="frmDialogMo" id="frmDialogMo">
	 <table class="tablaFormatoABM">
                        <tr>
                            <td>  <label for="dropMo">Mano de Obra </label></td>
                            <td><select id="dropMo" name="dropMo" style="width:200px; "  >
                              <option value="" disabled selected>-Seleccione mano de obra-</option>
                              <% for (int i = 0; i < manoDeObra.size(); i++) {%>

                              <option value="<%= manoDeObra.get(i).getIdManoDeObra()%>">
                              <%= manoDeObra.get(i).getDescManoDeObra()%>
                              </option>
                             <% }%> 
                              </select> * </td> 
                                <td> </td>
                        </tr>
                        <tr> 
                                <td>  <label for="unitMo">Unidad de Medida &nbsp;</label> </td>
                                <td>   <input type="text" id="unitMo" disabled="true" style="width:196px;" ></td>
                        </tr>
                         <tr>
                           <td><label for="precMo">Precio </label> </td>
                                <td> <input type="text" id="precMo" disabled="true" style="width:196px;"></td>
                        </tr>
                         <tr>
                                 <td>  <label for="cantstdMo">Cant. Estandar </label></td>
                                <td> <input type="text" id="cantstdMo" name="cantstdMo" style="width:196px;" onkeypress="return numbersOnly(this, event);" ></input>&nbsp;*</td>
                                  <td> </td>
                        </tr>
                        <tr> 
                                <td colspan="2" style="text-align:center;"><input type="submit" tabindex="-1" style="position:absolute; top:-1000px"></td>
                        </tr>
		</table> 		  
         </form>
       </div>
<!-- DIALOG MANO DE OBRA END -->
 <!-- DIALOG MATERIALES START -->
            <div id="dialog-form-mat" name="dialog-form-mat" title="Elegir Material"   >
                  <form name="frmDialogMat" id="frmDialogMat">
				  
		 <table class="tablaFormatoABM">
                    <tr>
                        <td><label for="dropMat">Material </label> </td>
                        <td><select id="dropMat" name="dropMat" style="width:230px; "  >
                                 <option value="" disabled selected >-Seleccione material-</option>
                                  <% for (int i = 0; i < materiales.size(); i++) {%>

                                  <option value="<%= materiales.get(i).getIdMaterial()%>">
                                  <%= materiales.get(i).getDescMaterial()%>
                              </option>
                                 <% }%> 
                          </select> *
		      </td>
                           <td> </td>
                    </tr>
                    <tr> 
                        <td>  <label for="unit">Unidad de Medida &nbsp;</label> </td>
                        <td>   <input type="text" id="unit" disabled="true" style="width:226px;" ></td>
                    </tr>
                     <tr>
                       <td><label for="prec">Precio </label> </td>
                        <td> <input type="text" id="prec" disabled="true" style="width:226px;" ></td>
                    </tr>
                     <tr>
                         <td>  <label for="cantstd">Cant. Estandar </label></td>
                         <td> <input type="text" id="cantstd" name="cantstd" style="width:226px;" onkeypress="return numbersOnly(this, event);" ></input>&nbsp;*</td>
                         <td> </td>
                    </tr>
                    <tr> 
                        <td colspan="2" style="text-align:center;"><input type="submit" tabindex="-1" style="position:absolute; top:-1000px"></td>
                    </tr>
                </table> 		  
         </form>
       </div>
<!-- DIALOG MATERIALES END -->

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
                          <div id="nav"   >
                              <ul>
                                  <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("editarRubro.jsp")%>">rubros</a><%=globconfig.separador()%>modificar</p></li>
                              <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                                  
                              </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                          <h2 id="titulo">Modificar rubro</h2>
						     <div style="font-size: 10px; float: right; margin-right: 70px; margin-top:-15px;">   (*) Campo requerido </div> 
                          <div id="formu">
                              <form name="frmEditRubro" id="frmEditRubro" method="POST" action="editarRubro2.jsp" >
 <table class="tablaFormatoABM">
		<tr>
			<td>   <label for="idRubro" >Id. Rubro  </label></td>
			<td>   <input   disabled="true" type="text"  id="idRubro" name="idRubro" style="width:400px;" value="${sessionScope.rubroEdit.idRubro}"  /></td>
			  <td></td>
	  </tr>
			 <tr>
			<td> <label for="descRubro" >Descripción   </label></td>
			<td> <input type="text"  id="descRubro" name="descRubro" style="width:400px;" value="${sessionScope.rubroEdit.descRubro}"  /></td>
			  <td>*</td>
	  </tr><input type="hidden"  id="unidadMedida" name="unidadMedida" value="${sessionScope.rubroEdit.idUnidadMedida}"   />
			 <tr>
                             <td>  <label for="dropUm">Unidad de Medida &nbsp;</label></td>
			<td>     <select id="dropUm" name="dropUm" style="width:405px;"   >
	<% for (int i = 0; i < unidadesM.size(); i++) {%>

		<option value="<%= unidadesM.get(i).getIdUnidadMedida()%>">
		<%= unidadesM.get(i).getDescUnidadMedida()%>
		  </option>
			 <% }%> 
	  </select> </td>
			  <td>*</td>
	  </tr>
	  </table>       
                        <div id="divContenedorMa"  >    
                         <c:if test="${not empty sessionScope.rubroEdit.idUnidadMedida}">    
                            <p style=" margin-top: 20px;  margin-left: 100px; margin-bottom: 1px;  text-align: left ;font-size: 14px; ">Materiales</p>
                         
                            <table id="tablaMateriales" class="tabla">
                                <tbody>
                                    <tr>
                                      <th style="width: 300px;">Descripcion</th>
                                        <th>Unidad</th>
                                        <th>Precio</th>
                                        <th>Cant. Estandar</th>
                                          <th>Acciones</th> 
                                    </tr>
                                            <c:forEach items="${sessionScope.rubroEdit.materiales}" var="mat" >
                                        <tr >
                                           
                                            <td><c:out value= "${mat.descMaterial}"/></td> 
                                            <td><c:out value= "${mat.idUnidadMedida}"/></td> 
                                            <td>$<c:out value= "${mat.precioMa}" /></td>  
                                            <td><c:out value= "${mat.coefStdMat}" /></td>  
                                            <td><img src='images/iconEdit.png' class='btnEdit'>&nbsp;&nbsp;<img src='images/trash.png' class='btnDelete'> </td>
                                             <td class="aidi"><c:out value= "${mat.idMaterial}"/></td> 
                                         </tr>
                                            </c:forEach>
                                  
                                 </tbody>
                            </table>
                            <tr ><td colspan="6">   <button type="button" id="btnAddMa" style="height:25px ; width: 70px;" class="unBoton"> Agregar</button></td>  </tr>
                         </c:if>
                        </div>
                          </br> 
                          <div id="divContenedorMo"  >  
                               <c:if test="${not empty sessionScope.rubroEdit.idUnidadMedida}">
                                      <p style="  margin-left: 100px; margin-bottom: 1px; text-align: left ;font-size: 14px; ">Mano de Obra</p>
                                      <table id="tablaManoDeObra" class="tabla">
                                          <tbody>
                                              <tr>
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
                                                      <td>$<c:out value= "${mo.precioMo}" /></td> 
                                                      <td><c:out value= "${mo.coefStdMO}" /></td>
                                                       <td><img src='images/iconEdit.png' class='btnEdit'>&nbsp;&nbsp;<img src='images/trash.png' class='btnDelete'> </td>
                                                    <td class="aidi"><c:out value= "${mo.idManoDeObra}"/></td>
                                                  </tr>
                                              </c:forEach>
                                          </tbody>
                                      </table>
                                         <tr ><td colspan="6">   <button type="button" id="btnAddMo" style="height:25px ; width: 70px;" class="unBoton"> Agregar</button></td>  </tr>
                                    </c:if>
                                  </div>        
                          
                           <div style="text-align: center">   
                                      </br>
                         <!--      <button type="button" id="btnAtras" name="btnAtras" style="height:25px; width: 70px;" class="unBoton"><a href="<//%= response.encodeURL("editarRubro.jsp")%>">Atras</a></button>-->
                      <button type="button" id="btnAtras" name="btnAtras" style="height:25px; width: 70px;" ><a href="<%= response.encodeURL("editarRubro.jsp?action="+ r1.getIdRubro() )%>">Atras</a></button>
                        
                           <input type="submit"  id="btnGuardar" name="btnGuardar" value="Guardar" style="height:25px ; width: 70px; float:none ; padding-right:0px;" class="unBoton"/>
                       
                             <input type="hidden" id="dataMateriales" name="dataMateriales" />
                             <input type="hidden" id="dataManoDeObra" name="dataManoDeObra"/>
                          </div>
                               </form>
                          </div>
                      </div>
                  </div>
                      <%@ include file="WEB-INF/jspf/firma.jspf" %>
 
          </body>
</html>
