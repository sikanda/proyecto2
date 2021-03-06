<%@page import="java.util.List"%>
<%@page import="Entidades.Cliente"%>
<%@page import="Entidades.Rubro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Presupuesto"%>
<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="clienteDB" scope="page" class="Datos.ClienteDB" />

<%
  boolean rta, rtaCli;
  String mensaje="";
  String obs = request.getParameter("obs");
  String nomCli = request.getParameter("nomCli");
  String direCli = request.getParameter("direCli");
  String telCli = request.getParameter("telCli");
  
//if(request.getParameter("btnGuardar")!=null) //name of your button, not id 
   ///doy de alta presupuesto  - redirigido desde pantalla3
  if(request.getParameter("action").equals("n"))
{
   Presupuesto pres = (Presupuesto)session.getAttribute("presupuestoActual");
   pres.setObservaciones(obs);
   
        Cliente c = new Cliente();
        c.setIdCliente(clienteDB.getIdCliente());
        c.setNomApeCli(nomCli);
        c.setDireCli(direCli);
        c.setTelCli(telCli);
        rtaCli= c.save();
        pres.setCliente(c);
 
  rta = pres.save();
   if(rta && rtaCli)
   { mensaje = "El presupuesto se ha guardado correctamente";
         session.removeAttribute("rubrosEnArbol");
         session.removeAttribute("rubrosLeaf");
         session.removeAttribute("presupuestoActual");
         session.removeAttribute("rubrosAll");
         session.removeAttribute("rubrosPerc");
   }
   else
    { mensaje = "Ha ocurrido un error ";}
   
   
}
  ///edito presupuesto  - redirigido desde editarPresupuesto3
  if(request.getParameter("action").equals("u"))
{

   Presupuesto pres = (Presupuesto)session.getAttribute("presupuestoQueSeEdita");
   pres.setObservaciones(obs);
   pres.setRubros((List<Rubro>)session.getAttribute("rubrosLeaf"));
   
    Cliente c = pres.getCliente();
    c.setNomApeCli(nomCli);
    c.setDireCli(direCli);
    c.setTelCli(telCli);
    rtaCli= c.update();
 
   rta = pres.update();
   if(rta && rtaCli)
   { mensaje = "El presupuesto se ha guardado correctamente";
         session.removeAttribute("rubrosEnArbol");
         session.removeAttribute("rubrosLeaf");
         session.removeAttribute("presupuestoQueSeEdita");
         session.removeAttribute("rubrosAll");
         session.removeAttribute("rubrosPerc");
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
                                    <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>generar presupuesto</a></p></li>
                            </ul>
                              <br class="clear" />
                          </div>
                      </div>
                      <div id="main">
                          
            <% String titulo = "Generar Presupuesto";
                %>
            <h2 id="titulo"><%=titulo%></h2>

        <div id="formu">
        <form name="frmpresup" action="<%= response.encodeURL("listaPresupuestos.jsp")%>" method="POST">
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
    
          </body>
</html>

