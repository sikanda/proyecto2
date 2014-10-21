<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Rubro"%>
<%@ page import="Entidades.Material"%>
<%@ page import="Entidades.ManoDeObra"%>
<%@ page import="Entidades.Presupuesto"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>
<jsp:useBean id="globconfig" scope="application" class="Base.Config" />


<%
        boolean rta=true;
        String mensaje="";
        Rubro rubroEdit = (Rubro)session.getAttribute("rubroEdit");  
     
       String mo = request.getParameter("dataManoDeObra");     //("dataMObra");
       String mat= request.getParameter("dataMateriales");     //("dataMat");
       
       String desc = request.getParameter("descRubro");
       String um = request.getParameter("dropUm");  //("unidadMedida"); //select unidad medida
       //System.out.println(um);
       rubroEdit.setDescRubro(desc);
       rubroEdit.setIdUnidadMedida(um);
       
       rta= rubroEdit.update();//devuelve booleano!
       
//       System.out.println(mat);
//       System.out.println(mo);
       if (mat != null){
            rubroEdit.modificarListaMat(mat);
       }
         if (mo!= null){
            rubroEdit.modificarListaMo(mo);
       }
         
    if (rta) //TODO: modificar para incluir los upd de ma y mo
        {
            mensaje = "El rubro se ha guardado correctamente";
            session.removeAttribute("rubroEdit");
        } else {
            mensaje = "Ha ocurrido un error ";
        }
        
  %>   
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><%=globconfig.nombrePag() %></title>
          <%@ include file="WEB-INF/jspf/estilo.jspf" %>
          <script src="js/jquery-1.6.4.min.js" ></script>	


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
                                  <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%>edit</a></p></li>
                              </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                            <% String titulo = "Editar rubro";
                %>
            <h2 id="titulo"><%=titulo%></h2>

        <div id="formu">
        <form name="frmedrub" action="<%= response.encodeURL("editarRubro.jsp")%>" method="POST">
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
          </body>
</html>
