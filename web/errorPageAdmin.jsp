<%@ page isErrorPage="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<jsp:useBean id="globconfig" scope="application" class="Base.Config" />

 
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><%=globconfig.nombrePag() %></title>
          <%@ include file="WEB-INF/jspf/estilo.jspf" %>
     
    </head>
         <body>
        <div id="bg1">     </div>   
             <div id="bg2"></div>
                <div id="outer2">                 
                        <div id="header2">
                            <div id="logo2">
                                   <h1>
                                         <img src="images/cim1.png" alt="" /> 
                                    </h1>
                            </div>
                          <%@ include file="WEB-INF/jspf/barrausuario.jspf" %>
                          <div id="nav">
                              <ul>
                                    <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%>error</p></li>
                            </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                          <div style="text-align: left ; margin: 10px"> 
                          <h1>Oops...</h1>
 Ha ocurrido un error. A continuación los detalles del error:  </br>
                          </div>
<table border="1" class="tabla">
<tr valign="top">
<td width="25%"><b>Error:</b></td>
<td>${pageContext.exception}</td>
</tr>
<tr valign="top">
<td><b>URI:</b></td>
<td>${pageContext.errorData.requestURI}</td>
</tr>
<tr valign="top">
<td><b>Código de estado:</b></td>
<td>${pageContext.errorData.statusCode}</td>
</tr>
<tr valign="top">
<td><b>Traza de error generada:</b></td>
<td>
<c:forEach var="trace" items="${pageContext.exception.stackTrace}">
<p>${trace}</p>
</c:forEach>
</td>
</tr>
</table>
     <button type="button" style="height:25px ; width: 70px; margin:10px;"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">Continuar</a></button>
                  </div>
              </div>
                     <%@ include file="WEB-INF/jspf/firma.jspf" %>
    
          </body>
</html>

