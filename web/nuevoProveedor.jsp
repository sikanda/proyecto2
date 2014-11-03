<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.Proveedor"%>


<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="proveedorDB" scope="page" class="Datos.ProveedorDB" />

<%
	String razonSocial = "";
        String mail = "";
        String telefono = "";
	String direccion = "";
        String titulo2 = "";

        //levanta los campos en form para modificar
        if (request.getParameter("id") != null  && request.getParameter("accion")== null  ){
            try{
                Proveedor prov = proveedorDB.getProveedor(Integer.parseInt(request.getParameter("id")));
                razonSocial = prov.getRazonSocial();
                direccion = prov.getDireProv();
                mail = prov.getEmailProv();
                telefono = prov.getTelProv();
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaProveedores.jsp"));
            }
        }


        if (request.getParameter("accion") != null){
                razonSocial = new String(request.getParameter("txtrazonsocial").getBytes("iso-8859-1"), "UTF-8");//request.getParameter("txtrazonsocial").toString();
                mail = request.getParameter("txtmail").toString();
                telefono = request.getParameter("txttelefono").toString();
                direccion = new String(request.getParameter("txtdireccion").getBytes("iso-8859-1"), "UTF-8"); //request.getParameter("txtdireccion").toString();
               if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
		        boolean rta = false;
                            Proveedor pro = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                //update
                                pro = new Proveedor();
                                pro.setIdProveedor(Integer.parseInt(request.getParameter("id")));
                                pro.setDireProv(direccion);
                                pro.setRazonSocial(razonSocial);
                                pro.setEmailProv(mail);
                                pro.setTelProv(telefono);
                                rta = pro.update();
                            }
                            else{ //nuevo
                                pro = new Proveedor(razonSocial,direccion,mail,telefono);
                                rta = pro.save();
                            }
                            if (rta)
                            {
                                response.sendRedirect(response.encodeRedirectURL("listaProveedores.jsp"));
			}
		}
	}
        if (request.getParameter("id") != null  || request.getParameter("accion") != null){
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
 
   $('#help').click(function (event) {
   $.popupWindow('helpPages/listaProveedores_h.html', {
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
        var validator = $("#frmProveedor").validate({
       rules: {
			   txtrazonsocial: "required",
			   txtdireccion: "required",
			   txtmail: {
					email: true
				},
			   txttelefono:  {
					required: true,
					digits: true,
					maxlength: 10
				}
      },
       messages: {
			   txtrazonsocial: "Campo requerido",
			   txtdireccion: "Campo requerido",
			   txtmail: {
					email: "E-mail inválido"
				},
			   txttelefono:  {
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaProveedores.jsp")%>">Proveedores</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nuevo proveedor";
                if (request.getParameter("id") != null || request.getParameter("accion") != null){ 
                    titulo ="Modificar proveedor";
                }%>
            <h2 id="titulo"><%=titulo%></h2>
            

          <%    String param = "nuevo";
        if(request.getParameter("id") != null){
            param = "update&id=" + request.getParameter("id");
        }
        %> 
        <div id="formu">
        <form id="frmProveedor" name="frmProveedor" class="formAbm" action="<%= response.encodeURL("nuevoProveedor.jsp?accion=" + param)%>" method="POST">   
               <fieldset style="height: 200px;">
                    <legend><strong>Datos del proveedor:</strong></legend>       
            <table class="tablaFormatoABM">
                    <tr>
                        <td>    <label for="txtrazonsocial"> Razón Social:</label></td>
                  <td>   <input type="text" id="txtrazonsocial" name="txtrazonsocial" value="<%= razonSocial %>"/></td>
				     <td>*</td>
				 </tr>
          <tr>
                  <td>    <label for="txtdireccion">  Dirección:</label></td>
                <td>   <input type="text" id="txtdireccion" name="txtdireccion" value="<%= direccion %>"/></td>
				     <td>*</td>
				 </tr>
             <tr>
               <td><label for="txtmail"> Email:</label> </td>
           <td>  <input type="text" id="txtmail" name="txtmail" value="<%= mail %>"/></td>
                   <td></td>
			  </tr>
			   <tr>
               <td> <label for="txttelefono"> Teléfono:</label></td>
                   <td>  <input type="text" id="txttelefono" name="txttelefono" value="<%= telefono %>"/></td>
				        <td>*</td>
                    </tr>
                  <tr> 
                        <td colspan="2" style="text-align:center;">    
                    <input type="submit" value="Guardar"  /></td>
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