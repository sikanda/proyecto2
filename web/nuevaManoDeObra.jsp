<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.ManoDeObra"%>
<%@ page import="Entidades.UnidadMedida"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page errorPage="errorPageAdmin.jsp" %>

<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="manoDeObraDB" scope="page" class="Datos.ManoDeObraDB" />
<jsp:useBean id="unidadMedidaDB" scope="page" class="Datos.UnidadMedidaDB" />

<%
	String desc = "";
        String descUm = "";
        String precio = "";
        String titulo2 = "";
        List<UnidadMedida> unidadesM = new ArrayList();
        unidadesM = unidadMedidaDB.getUnidadesDeMedida();

       if (request.getParameter("id") != null  && request.getParameter("accion")== null  ){
            try{
                ManoDeObra mo = manoDeObraDB.getManoDeObra(request.getParameter("id"));
                desc = mo.getDescManoDeObra();
                descUm = mo.getIdUnidadMedida();
                precio =  String.valueOf(mo.getPrecioMo());
           }
            catch(Exception e)
            {
               // response.sendRedirect(response.encodeRedirectURL("listaManoDeObra.jsp"));
                 throw new RuntimeException("Error!");
            }
        }


        if (request.getParameter("accion") != null){
                desc = new String(request.getParameter("txtDesc").getBytes("iso-8859-1"), "UTF-8");//request.getParameter("txtDesc").toString();
                 descUm = request.getParameter("txtDescUm").toString();
                  precio =  request.getParameter("txtPrecio").toString();
             
                if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
			    boolean rta = false;
                            ManoDeObra mo = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                mo = new ManoDeObra();
                                mo.setIdManoDeObra(request.getParameter("id"));
                                mo.setDescManoDeObra(desc);
                                mo.setIdUnidadMedida(descUm);
                                mo.setPrecioMo(Float.parseFloat(precio));
                                rta = mo.update();
                            }
                            else{
                                mo = new ManoDeObra(desc,descUm,Float.parseFloat(precio));
                                rta = mo.save();
                            }
                            if (rta)
                            {
                              response.sendRedirect(response.encodeRedirectURL("listaManoDeObra.jsp"));
                                
                            }
                           else {
                              //response.sendRedirect(response.encodeRedirectURL("inicioAdmin.jsp"));
                                throw new RuntimeException("Error!"); 
                            }
					}
	}
        if (request.getParameter("id") != null || request.getParameter("accion") != null){
                    titulo2 ="modificar";
                } else{
                           titulo2 ="nueva";
                       }
%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
         <title><%=globconfig.nombrePag() %></title>
        <%@ include file="WEB-INF/jspf/estilo.jspf" %>
        <script src="dist/libs/jquery.js" ></script>
       <script src="js/jquery.validate.js"></script>
         <script type="text/javascript" src="js/jquery.popupwindow.js"></script>       
        <script>
            $(function() { 
      if ($("#unidadMedida").val().length !== 0){ 
             $("#txtDescUm").val($("#unidadMedida").val() );
         }
         else{
          $("#txtDescUm").val($("#txtDescUm option:first").val());
         }
           $("#txtDescUm option[value='RG']").remove();
              
           $('#help').click(function (event) {
           $.popupWindow('helpPages/listaManoDeObra_h.html', {
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
     
 function getURLParameter(name) {
  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
}
  var id= getURLParameter('id');
  
        var validator = $("#frmManoDeObra").validate({
       rules: {
              // txtDesc: "required",
                  txtDesc: {
                       required: true, 
                        remote: {
                          url: "popupValida.jsp",
                          type: "post",
                          data: {
                              ide: id,
                            tipo: "Mo",  
                            desc: function() {
                              return $( "#txtDesc" ).val();
                            }
                          }
                        }
                        },
               txtDescUm: "required",
                 txtPrecio: {
                   required: true,
                   number: true,
                   min: 0.01
                 }
       },
       messages: {
               //txtDesc: "Campo requerido",
                 txtDesc:{ 
              required: "Campo requerido",
              remote: "Descripción no disponible"
                },
               txtDescUm:"Campo requerido",
       txtPrecio: {
           required: "Campo requerido",
           number: "Precio inválido", 
           min: "Precio debe ser mayor a 0" 
         }
        },
       errorPlacement: function(error, element) {
       error.appendTo(element.parent().next());
               },
       errorClass: 'errore'
       });
     });
 function numbersOnly(oToCheckField, oKeyEvent) {        
  var s = String.fromCharCode(oKeyEvent.charCode);
  var containsDecimalPoint = /\./.test(oToCheckField.value);
  return oKeyEvent.charCode === 0 || /\d/.test(s) || 
      /\./.test(s) && !containsDecimalPoint;
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaManoDeObra.jsp")%>">Mano de obra</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                        <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nueva mano de obra";
                if (request.getParameter("id") != null || request.getParameter("accion") != null){
                    titulo ="Modificar Mano de Obra";
                }%>
            <h2 id="titulo"><%=titulo%></h2>
            

                <% String param = "nuevo";
        if(request.getParameter("id") != null){
            param = "update&id=" + request.getParameter("id");
        }
        %>
        <div id="formu">
            <form name="frmManoDeObra" id="frmManoDeObra" class="formAbm"  action="<%= response.encodeURL("nuevaManoDeObra.jsp?accion=" + param)%>" method="POST">
            <fieldset style="height: 180px;">
                    <legend><strong>Datos mano de obra</strong></legend>
                    <table class="tablaFormatoABM">
               <tr>
                <td>    <label for="txtDesc"> Descripción: </label></td>
                  <td>       <input type="text" id="txtDesc" name="txtDesc" value="<%= desc %>"  /></td>
				    <td>*</td>
					</tr>
                     <!--   <label for="txtDescUm"> Unidad de medida: </label>
                        <input type="text" id="txtDescUm" name="txtDescUm" value="<//%= descUm %>"/></br>  -->
                        
                        
                             <input type="hidden"  id="unidadMedida" name="unidadMedida"  value="<%= descUm %>" />
                       <tr>    <td>      <label for="txtDescUm">Unidad de Medida:</label></td>
                         <td>        <select id="txtDescUm" name="txtDescUm" style="width:205px;"   >
                                 <option value="" disabled selected>-Seleccione unidad-</option>
                        <% for (int i = 0; i < unidadesM.size(); i++) {%>

                            <option value="<%= unidadesM.get(i).getIdUnidadMedida()%>">
                            <%= unidadesM.get(i).getDescUnidadMedida()%>
                              </option>
                                 <% }%> 
                          </select>                      
                        </td> <td>*</td></tr>
                      <tr>    <td>  
                        <label for="txtPrecio"> Precio: </label> </td>
                    <td>     <input type="text" id="txtPrecio" name="txtPrecio" value="<%= precio %>" onkeypress="return numbersOnly(this, event);"/> </td>
                   <td>*</td></tr>
                  <tr> 
                    <td colspan="2" style="text-align:center;">
					<input type="submit" value="Guardar"  />
                     </td>
                </tr>
           </table> 
               
                     <div style="font-size: 10px; float: right">   (*) Campo requerido </div>
            </fieldset>
        </form>
        </div>
         </div>
        </div>
                     <%@ include file="WEB-INF/jspf/firma.jspf" %>
   
    </body>
</html>