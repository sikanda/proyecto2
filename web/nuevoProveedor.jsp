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
	String mensajeE = "";
        String titulo2 = "";

        if (request.getParameter("id") != null && request.getParameter("ae") == null ){
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


        if (request.getParameter("ae") != null){
                razonSocial = request.getParameter("txtrazonsocial").toString();
                mail = request.getParameter("txtmail").toString();
                telefono = request.getParameter("txttelefono").toString();
                direccion = request.getParameter("txtdireccion").toString();
                if (request.getParameter("ae").contentEquals("t") || request.getParameter("ae").contentEquals("u")){
			if(razonSocial.trim().isEmpty() || direccion.trim().isEmpty()|| mail.trim().isEmpty()){
				mensajeE = "Por favor, verifique los datos ingresados del proveedor.";
			}
			else{
                            boolean rta = false;
                            Proveedor pro = null;
                            if(request.getParameter("ae").contentEquals("u")){
                                pro = new Proveedor();
                                pro.setIdProveedor(Integer.parseInt(request.getParameter("id")));
                                pro.setDireProv(direccion);
                                pro.setRazonSocial(razonSocial);
                                pro.setEmailProv(mail);
                                pro.setTelProv(telefono);
                                rta = pro.update();
                            }
                            else{
                                pro = new Proveedor(razonSocial,direccion,mail,telefono);
                                rta = pro.save();
                            }
                            if (rta)
                            {
                                if(request.getParameter("ae").contentEquals("t")){
                                    session.setAttribute("proveedor", pro);
                                    response.sendRedirect(response.encodeRedirectURL("listaProveedores.jsp"));
                                }
                                else{
                                    response.sendRedirect(response.encodeRedirectURL("listaProveedores.jsp"));
                                }
                            }
			}
		}
	}
        if (request.getParameter("id") != null || request.getParameter("ae") != null){
                    titulo2 ="modificar Proveedor";
                } else{
                           titulo2 ="nuevo Proveedor";
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaProveedores.jsp?al=t")%>">Proveedores</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nuevo Proveedor.";
                if (request.getParameter("id") != null || request.getParameter("ae") != null){
                    titulo ="Modificar Proveedor";
                }%>
            <h2 id="titulo"><%=titulo%></h2>
            

                <% String param = "t";
        if(request.getParameter("id") != null){
            param = "u&id=" + request.getParameter("id");
        }
        %>
        <div id="formu">
        <form name="frmproveedor" action="<%= response.encodeURL("nuevoProveedor.jsp?ae=" + param)%>" method="POST">
            <fieldset>
                    <legend><strong>Datos del proveedor:</strong></legend>
                    <% if(!mensajeE.isEmpty()){ %>
                    <div id="mensaje">
                        <%= mensajeE %>
                    </div>
                    <% } %>
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
                    <input type="submit" value="Guardar" />
            </fieldset>
        </form>
        </div>
         </div>
        </div>
      </div>
    </body>
</html>