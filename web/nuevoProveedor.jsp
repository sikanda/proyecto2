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
                razonSocial = request.getParameter("txtrazonsocial").toString();
                mail = request.getParameter("txtmail").toString();
                telefono = request.getParameter("txttelefono").toString();
                direccion = request.getParameter("txtdireccion").toString();
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
        <form name="frmproveedor" action="<%= response.encodeURL("nuevoProveedor.jsp?accion=" + param)%>" method="POST">   
               <fieldset>
                    <legend><strong>Datos del proveedor:</strong></legend>       
                    <span>Razon Social</span>
                    <label for="txtrazonsocial"><input type="text" id="txtrazonsocial" name="txtrazonsocial" value="<%= razonSocial %>"/></label>
                    <br />
                     <span>Dirección</span>
                    <label for="txtdireccion"><input type="text" id="txtdireccion" name="txtdireccion" value="<%= direccion %>"/></label>
                    <br />
                     <span>Email</span>
                    <label for="txtmail"><input type="text" id="txtmail" name="txtmail" value="<%= mail %>"/></label>
                    <br />
                     <span>Telefono</span>
                    <label for="txttelefono"><input type="text" id="txttelefono" name="txttelefono" value="<%= telefono %>"/></label>
                     <br />
                    <input type="submit" value="Guardar" style="height:25px; width: 70px;" />
            </fieldset>
        </form>
        </div>
         </div>
        </div>
      </div>
    </body>
</html>