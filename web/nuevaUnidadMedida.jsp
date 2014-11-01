<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.UnidadMedida"%>


<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="unidadMedidaDB" scope="page" class="Datos.UnidadMedidaDB" />

<%
        String id = "";
        String descU = "";
        String titulo2 = "";

       if (request.getParameter("id") != null  && request.getParameter("accion")== null  ){
            try{
                UnidadMedida herr = unidadMedidaDB.getUnidadMedida(new String(request.getParameter("id").getBytes("iso-8859-1"), "UTF-8"));
                id=new String(request.getParameter("id").getBytes("iso-8859-1"), "UTF-8");//request.getParameter("id");
                descU = herr.getDescUnidadMedida();
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaUnidadesMedida.jsp"));
            }
        }


        if (request.getParameter("accion") != null){
                id = new String(request.getParameter("txtId").getBytes("iso-8859-1"), "UTF-8");//request.getParameter("txtId").toString();
                descU =  new String(request.getParameter("txtDesc").getBytes("iso-8859-1"), "UTF-8");//request.getParameter("txtDesc").toString();
             
                if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
			    boolean rta = false;
                            UnidadMedida um = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                um = new UnidadMedida();
                                um.setIdUnidadMedida(id);
                                um.setDescUnidadMedida(descU);
                                rta = um.update();
                            }
                            else{
                                um = new UnidadMedida(id,descU);
                                rta = um.save();
                            }
                            if (rta)
                            {
                              response.sendRedirect(response.encodeRedirectURL("listaUnidadesMedida.jsp"));
                                
                            }
                           else {
                              response.sendRedirect(response.encodeRedirectURL("inicioAdmin.jsp"));
                               //TODO: ver si se agrega una pag de error. 
                            }
					}
	}
        if (request.getParameter("id") != null || request.getParameter("accion") != null){
                    titulo2 ="modificar";
                } else{
                           titulo2 ="nueva";
                       }
%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title><%=globconfig.nombrePag() %></title>
        <%@ include file="WEB-INF/jspf/estilo.jspf" %>
               <script src="dist/libs/jquery.js" ></script>	
			      <script src="js/jquery.validate.js"></script>	
	   <script type="text/javascript" src="js/jquery.popupwindow.js"></script>
           	<script>
	$(function() { 
 
   $('#help').click(function (event) {
   $.popupWindow('helpPages/listaUnidadesMedida_h.html', {
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
if($('#txtId').val().length !== 0){
       $('#txtId').attr("disabled", 'disabled');
}
        var validator = $("#frmUnidadMedida").validate({
       rules: {
              txtId: {
			  required: true,
			  maxlength: 5
			},
                 txtDesc:  "required"
       },
       messages: {
			txtId: {
			  required: "Campo requerido",
			  maxlength: "Máximo 5 caracteres"
			},
				txtDesc: "Campo requerido"
        },
       errorPlacement: function(error, element) {
       error.appendTo(element.parent().next());
               },
       errorClass: 'errore'
       });
});
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaUnidadesMedida.jsp")%>"> Unidades Medida</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                         <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nueva unidad de medida";
                if (request.getParameter("id") != null || request.getParameter("accion") != null){
                    titulo ="Modificar unidad de medida";
                }%>
            <h2 id="titulo"><%=titulo%></h2>
            

                <% String param = "nuevo";
        if(request.getParameter("id") != null){
            param = "update&id=" + request.getParameter("id");
        }
        %>
        <div id="formu">
        <form id= "frmUnidadMedida" name="frmUnidadMedida" class="formAbm" action="<%= response.encodeURL("nuevaUnidadMedida.jsp?accion=" + param)%>" method="POST">
            <fieldset style="height: 150px;">
                    <legend><strong>Datos unidad de medida</strong></legend>
                
                    <table class="tablaFormatoABM">
               <tr>
                <td>   <label for="txtId">Código: </label></td>
                   <td>        <input type="text" id="txtId" name="txtId" value="<%= id  %>"/></td>
                   <td>*</td>
				   </tr>  
                <tr>   <td>     <label for="txtDesc"> Descripción: </label></td>
                 <td>          <input type="text" id="txtDesc" name="txtDesc"   value="<%= descU %>"/>
               </td>
			   <td>*</td></tr>  
              <tr>    <td colspan="2" style="text-align:center;">      <input type="submit" value="Guardar"  /></td></tr>  
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