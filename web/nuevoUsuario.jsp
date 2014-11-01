<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.Usuario"%>


<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="usuarioDB" scope="page" class="Datos.UsuarioDB" />

<%
        String nombreUser = "";
        String pass = "";
        String titulo2 = "";

       if (request.getParameter("id") != null  && request.getParameter("accion")== null  ){
            try{
                Usuario user = usuarioDB.getUsuario(Integer.parseInt(request.getParameter("id")));
                nombreUser = user.getNombreUsuario();
                pass = user.getPass();
                
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaUsuarios.jsp"));
            }
        }


        if (request.getParameter("accion") != null){
                nombreUser = new String(request.getParameter("txtNomUs").getBytes("iso-8859-1"), "UTF-8"); //request.getParameter("txtNomUs").toString();
                pass = new String(request.getParameter("txtPass").getBytes("iso-8859-1"), "UTF-8"); //request.getParameter("txtPass").toString();
             
                if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
			    boolean rta = false;
                            Usuario user = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                user = new Usuario();
                                user.setIdUsuario(Integer.parseInt(request.getParameter("id")));
                                user.setNombreUsuario(nombreUser);  
                                user.setPass(pass);
                                rta = user.update();
                            }
                            else{
                                user = new Usuario(nombreUser,pass);
                                rta = user.save();
                            }
                            if (rta)
                            {
                              response.sendRedirect(response.encodeRedirectURL("listaUsuarios.jsp"));
                                
                            }
                           else { //error
                              response.sendRedirect(response.encodeRedirectURL("inicioUsuario.jsp"));
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
 if($('#txtNomUs').val() ==="admin"){
     $('#txtNomUs').attr("disabled", 'disabled');
 }
   $('#help').click(function (event) {
   $.popupWindow('helpPages/listaUsuarios_h.html', {
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
        var validator = $("#frmUsuario").validate({
       rules: {
               txtNomUs: "required",
                 txtPass:  "required"
       },
       messages: {
               txtNomUs: "Campo requerido",
				txtPass: "Campo requerido"
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaUsuarios.jsp")%>">Usuarios</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                       <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nuevo Usuario";
                if (request.getParameter("id") != null || request.getParameter("accion") != null){
                    titulo ="Modificar Usuario";
                }%>
            <h2 id="titulo"><%=titulo%></h2>
            

                <% String param = "nuevo";
        if(request.getParameter("id") != null){
            param = "update&id=" + request.getParameter("id");
        }
        %>
        <div id="formu">
        <form id="frmUsuario" name="frmUsuario" class="formAbm"  action="<%= response.encodeURL("nuevoUsuario.jsp?accion=" + param)%>" method="POST">
            <fieldset style="height: 150px;">
                    <legend><strong>Datos del usuario</strong></legend>
          <table class="tablaFormatoABM">
               <tr>
                <td>  <label for="txtNomUs"> Nombre:  </label></td>
              <td>      <input type="text" id="txtNomUs" name="txtNomUs"  value="<%= nombreUser %>"/></td> <td>*</td>
               </tr>      
            <tr>   <td>          <label for="txtPass"> Contraseña: </label></td>
                 <td>        <input type="text" id="txtPass" name="txtPass"  value="<%= pass %>"/></td> <td>*</td>
                 </tr>     
                      
           <tr>     <td colspan="2" style="text-align:center;">    
		   <input type="submit" value="Guardar"  /></td></tr>
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