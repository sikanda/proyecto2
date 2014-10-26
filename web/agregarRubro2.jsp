<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Rubro"%>
<jsp:useBean id="globconfig" scope="application" class="Base.Config" />


<%
  boolean rta  ;
  String mensaje="";
  String unidadMedida = request.getParameter("dropUm");
  String descRubro = request.getParameter("descRubro");

  String mo = request.getParameter("dataManoDeObra");     //("dataMObra");
  String mat= request.getParameter("dataMateriales");     //("dataMat");

  
if(request.getParameter("btnGuardar")!=null) //name of your button, not id 
{
   Rubro rub = (Rubro)session.getAttribute("nuevoRubro");
   
    rub.setDescRubro(descRubro);
    rub.setIdUnidadMedida(unidadMedida);
 
       rta= rub.save(); 
       
       if (mat != null){
            rub.modificarListaMat(mat);
       }
         if (mo!= null){
            rub.modificarListaMo(mo);
       }
         
   if(rta  )
   { mensaje = "El rubro se ha guardado correctamente";
         session.removeAttribute("nuevoRubro");
   }
   else
    { mensaje = "Ha ocurrido un error ";}
   
   
}
  %>   
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
                                  <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("editarRubro.jsp")%>">rubros</a><%=globconfig.separador()%>nuevo</p></li>
                              </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                             <% String titulo = "Agregar nuevo rubro";
                %>
            <h2 id="titulo"><%=titulo%></h2>

        <div id="formu">
        <form name="frmaddrub2" action="<%= response.encodeURL("editarRubro.jsp")%>" method="POST">
            <fieldset>
                   
                    <% if(!mensaje.isEmpty()){ %>
                    <div id="mensaje">
                        <%= mensaje %>
                    </div>
                    <% } %>
                    </br>
                    <input type="submit" value="Continuar" style="height:25px; width: 70px;"/>
            </fieldset>
        </form>
        </div>
                  </div>
              </div>
                     <%@ include file="WEB-INF/jspf/firma.jspf" %>

            </div>
          </body>
</html>
