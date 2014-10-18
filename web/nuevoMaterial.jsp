<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.Material"%>


<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="materialDB" scope="page" class="Datos.MaterialDB" />

<%
	String desc = "";
        String descUm = "";
        float precio = 0;
        String titulo2 = "";

       if (request.getParameter("id") != null  && request.getParameter("accion")== null  ){
            try{
                Material ma = materialDB.getMaterial(request.getParameter("id"));
                desc = ma.getDescMaterial();
                descUm = ma.getIdUnidadMedida();
                precio =  ma.getPrecioMa();
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaMateriales.jsp"));
            }
        }


        if (request.getParameter("accion") != null){
                desc = request.getParameter("txtDesc").toString();
                 descUm = request.getParameter("txtDescUm").toString();
                  precio = Float.parseFloat(  request.getParameter("txtPrecio").toString());
             
                if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
			    boolean rta = false;
                            Material ma = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                ma = new Material();
                                ma.setIdMaterial(request.getParameter("id"));
                                ma.setIdUnidadMedida(descUm);
                                ma.setPrecioMa(precio);
                                rta = ma.update();
                            }
                            else{
                                ma = new Material(descUm,precio);
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
                           titulo2 ="nueva";
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaMateriales.jsp")%>">Materiales</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nuevo Material ";
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
        <form name="frmMaterial" action="<%= response.encodeURL("nuevoMaterial.jsp?accion=" + param)%>" method="POST">
            <fieldset>
                    <legend><strong>Datos material</strong></legend>
                    <label for="txtDesc"> Descripción: </label>
                        <input type="text" id="txtDesc" name="txtDesc" value="<%= desc %>"/>
                        <label for="txtDescUm"> Unidad de medida: </label>
                        <input type="text" id="txtDescUm" name="txtDescUm" value="<%= descUm %>"/>
                        <label for="txtPrecio"> Precio: </label>
                        <input type="text" id="txtPrecio" name="txtPrecio" value="<%= precio %>"/>
                    <br /><br />
                    <input type="submit" value="Guardar" style="height:25px; width: 70px;" />
            </fieldset>
        </form>
        </div>
         </div>
        </div>
      </div>
    </body>
</html>