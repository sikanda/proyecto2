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
   $.popupWindow('helpPages/ayudaGeneral.html', {
	 width: 900,
	  height: 600,
	center: 'parent'
  });
});
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
        <form name="frmproveedor" class="formAbm" action="<%= response.encodeURL("nuevoProveedor.jsp?accion=" + param)%>" method="POST">   
               <fieldset>
                    <legend><strong>Datos del proveedor:</strong></legend>       
                    <div>
                    <label for="txtrazonsocial"> Razón Social:</label>
                    <input type="text" id="txtrazonsocial" name="txtrazonsocial" value="<%= razonSocial %>"/>
                    <br />
                      <label for="txtdireccion">  Dirección</label>
                 <input type="text" id="txtdireccion" name="txtdireccion" value="<%= direccion %>"/>
                    <br />
                     <label for="txtmail"> Email:</label>
                   <input type="text" id="txtmail" name="txtmail" value="<%= mail %>"/>
                    <br />
                     <label for="txttelefono"> Teléfono:</label>
                   <input type="text" id="txttelefono" name="txttelefono" value="<%= telefono %>"/>
                     <br />
                    <input type="submit" value="Guardar" />
                    </div>
               </fieldset>
        </form>
        </div>
         </div>
        </div>
                       <%@ include file="WEB-INF/jspf/firma.jspf" %>
      </div>
    </body>
</html>