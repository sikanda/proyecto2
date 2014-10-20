<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.ManoDeObra"%>
<%@ page import="Entidades.UnidadMedida"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>


<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="manoDeObraDB" scope="page" class="Datos.ManoDeObraDB" />
<jsp:useBean id="unidadMedidaDB" scope="page" class="Datos.UnidadMedidaDB" />

<%
	String desc = "";
        String descUm = "";
        float precio = 0;
        String titulo2 = "";
        List<UnidadMedida> unidadesM = new ArrayList();
        unidadesM = unidadMedidaDB.getUnidadesDeMedida();

       if (request.getParameter("id") != null  && request.getParameter("accion")== null  ){
            try{
                ManoDeObra mo = manoDeObraDB.getManoDeObra(request.getParameter("id"));
                desc = mo.getDescManoDeObra();
                descUm = mo.getIdUnidadMedida();
                precio =  mo.getPrecioMo();
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaManoDeObra.jsp"));
            }
        }


        if (request.getParameter("accion") != null){
                desc = request.getParameter("txtDesc").toString();
                 descUm = request.getParameter("txtDescUm").toString();
                  precio = Float.parseFloat(  request.getParameter("txtPrecio").toString());
             
                if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
			    boolean rta = false;
                            ManoDeObra mo = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                mo = new ManoDeObra();
                                mo.setIdManoDeObra(request.getParameter("id"));
                                mo.setDescManoDeObra(desc);
                                mo.setIdUnidadMedida(descUm);
                                mo.setPrecioMo(precio);
                                rta = mo.update();
                            }
                            else{
                                mo = new ManoDeObra(desc,descUm,precio);
                                rta = mo.save();
                            }
                            if (rta)
                            {
                              response.sendRedirect(response.encodeRedirectURL("listaManoDeObra.jsp"));
                                
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
        <script>
            $(function() { 
               // alert($("#unidadMedida").val() );
             $("#txtDescUm").val($("#unidadMedida").val() );
              $("#txtDescUm option[value='RG']").remove();
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaManoDeObra.jsp")%>">Mano de obra</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nueva Mano de Obra.";
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
        <form name="frmManoDeObra" action="<%= response.encodeURL("nuevaManoDeObra.jsp?accion=" + param)%>" method="POST">
            <fieldset>
                    <legend><strong>Datos mano de obra</strong></legend>
                    <label for="txtDesc"> Descripción: </label>
                        <input type="text" id="txtDesc" name="txtDesc" value="<%= desc %>"/></br>
                     <!--   <label for="txtDescUm"> Unidad de medida: </label>
                        <input type="text" id="txtDescUm" name="txtDescUm" value="<//%= descUm %>"/></br>  -->
                        
                        
                             <input type="hidden"  id="unidadMedida" name="unidadMedida"  value="<%= descUm %>" />
                               <label for="txtDescUm">Unidad de Medida:</label>
                               <select id="txtDescUm" name="txtDescUm" style="width:205px;"   >
                        <% for (int i = 0; i < unidadesM.size(); i++) {%>

                            <option value="<%= unidadesM.get(i).getIdUnidadMedida()%>">
                            <%= unidadesM.get(i).getDescUnidadMedida()%>
                              </option>
                                 <% }%> 
                          </select>                      
                        
                     </br>  
                        <label for="txtPrecio"> Precio: </label>
                        <input type="text" id="txtPrecio" name="txtPrecio" value="<%= precio %>"/>
                    <br /><br />
                    <input type="submit" value="Guardar" style="height:25px; width: 70px;" />
            </fieldset>
        </form>
        </div>
         </div>
        </div>
                     <%@ include file="WEB-INF/jspf/firma.jspf" %>
      </div>
    </body>
</html>