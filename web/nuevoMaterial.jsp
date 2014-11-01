<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.Material"%>
<%@ page import="Entidades.UnidadMedida"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>


<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="materialDB" scope="page" class="Datos.MaterialDB" />
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
                Material ma = materialDB.getMaterial(request.getParameter("id"));
                desc = ma.getDescMaterial();
                descUm = ma.getIdUnidadMedida();
                precio =  String.valueOf(ma.getPrecioMa());
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaMateriales.jsp"));
            }
        }


        if (request.getParameter("accion") != null){
                desc = new String(request.getParameter("txtDesc").getBytes("iso-8859-1"), "UTF-8"); // request.getParameter("txtDesc").toString();
                 descUm = request.getParameter("txtDescUm").toString();
                  precio = request.getParameter("txtPrecio").toString();
             
                if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
			    boolean rta = false;
                            Material ma = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                ma = new Material();
                                ma.setIdMaterial(request.getParameter("id"));
                                ma.setDescMaterial(desc);
                                ma.setIdUnidadMedida(descUm);
                                ma.setPrecioMa(Float.parseFloat(precio));
                                rta = ma.update();
                            }
                            else{
                                ma = new Material(desc,descUm,Float.parseFloat(precio));
                                rta = ma.save();
                            }
                            if (rta)
                            {
                              response.sendRedirect(response.encodeRedirectURL("listaMateriales.jsp"));
                                
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
                           titulo2 ="nuevo";
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
               // alert($("#unidadMedida").val() );
            if ($("#unidadMedida").val().length !== 0){ 
             $("#txtDescUm").val($("#unidadMedida").val() );
            }
            else{
             $("#txtDescUm").val($("#txtDescUm option:first").val());
            }
             $("#txtDescUm option[value='RG']").remove();

   $('#help').click(function (event) {
   $.popupWindow('helpPages/listaMateriales_h.html', {
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
        var validator = $("#frmMaterial").validate({
       rules: {
               txtDesc: "required",
                 txtPrecio: {
                   required: true,
                   number: true,
                   min: 0.01
                 }
       },
       messages: {
               txtDesc: "Campo requerido",
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaMateriales.jsp")%>">Materiales</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                       <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nuevo material ";
                if (request.getParameter("id") != null || request.getParameter("accion") != null){
                    titulo ="Modificar Material";
                }%>
            <h2 id="titulo"><%=titulo%></h2>
            

                <% String param = "nuevo";
        if(request.getParameter("id") != null){
            param = "update&id=" + request.getParameter("id");
        }
        %>
        <div id="formu">
        <form id="frmMaterial" name="frmMaterial" class="formAbm" action="<%= response.encodeURL("nuevoMaterial.jsp?accion=" + param)%>" method="POST">
            <fieldset style="height: 180px;">
                <legend><strong>Datos material</strong></legend>
                <table class="tablaFormatoABM">
                    <tr>
                        <td> <label for="txtDesc"> Descripción: </label> </td>
                        <td> <input type="text" id="txtDesc" name="txtDesc" value="<%= desc%>"/>  </td>
                        <td>*</td>
                    </tr>
                    <!--    <label for="txtDescUm"> Unidad de medida: </label>
                      <input type="text" id="txtDescUm" name="txtDescUm" value="<//%= descUm %>"/></br>  -->

                    <input type="hidden"  id="unidadMedida" name="unidadMedida"  value="<%= descUm%>" />
                    <tr> 
                        <td> <label for="txtDescUm">Unidad de Medida:</label></td>
                        <td> <select id="txtDescUm" name="txtDescUm" style="width:205px;"   >
                                <% for (int i = 0; i < unidadesM.size(); i++) {%>

                                <option value="<%= unidadesM.get(i).getIdUnidadMedida()%>">
                                    <%= unidadesM.get(i).getDescUnidadMedida()%>
                                </option>
                                <% }%> 
                            </select> </td>                    
                         <td>*</td>
                    </tr>
                    <tr> <td> <label for="txtPrecio"> Precio: </label>  </td>
                        <td><input type="text" id="txtPrecio" name="txtPrecio" value="<%= precio%>"/></td>
                        <td>*</td>
                    </tr>
                    <tr> 
                        <td colspan="2" style="text-align:center;"><input type="submit" value="Guardar" /></td>
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