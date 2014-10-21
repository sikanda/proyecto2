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
                UnidadMedida herr = unidadMedidaDB.getUnidadMedida(request.getParameter("id"));
                id=request.getParameter("id");
                descU = herr.getDescUnidadMedida();
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaUnidadesMedida.jsp"));
            }
        }


        if (request.getParameter("accion") != null){
                id = request.getParameter("txtId").toString();
                descU = request.getParameter("txtDesc").toString();
             
                if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
			    boolean rta = false;
                            UnidadMedida um = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                um = new UnidadMedida();
                                um.setIdUnidadMedida(request.getParameter("id"));
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaUnidadesMedida.jsp")%>"> Unidades Medida</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
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
        <form name="frmUnidadMedida" class="formAbm" action="<%= response.encodeURL("nuevaUnidadMedida.jsp?accion=" + param)%>" method="POST">
            <fieldset>
                    <legend><strong>Datos unidad de medida</strong></legend>
                     <div>
                 <label for="txtId">Código: </label>
                        <input type="text" id="txtId" name="txtId" value="<%= id  %>"/>
                    <br />  
                    <label for="txtDesc"> Descripción: </label>
                        <input type="text" id="txtDesc" name="txtDesc"   value="<%= descU %>"/>
                    <br />
                    <input type="submit" value="Guardar"  />
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