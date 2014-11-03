<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.Herramienta"%>


<%@ include file="WEB-INF/jspf/redirUsr.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="herramientaDB" scope="page" class="Datos.HerramientaDB" />

<%
	//String idHerram = "";
        String descHerram = "";
        String cant="";
        String titulo2 = "";

       if (request.getParameter("id") != null  && request.getParameter("accion")== null  ){
            try{
                Herramienta herr = herramientaDB.getHerramienta(request.getParameter("id"));
                descHerram = herr.getDescHerramienta();
                cant = String.valueOf(herr.getCant()) ;
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaHerramientas.jsp"));
            }
        }


        if (request.getParameter("accion") != null){
                descHerram =  new String(request.getParameter("txtDescHerramienta").getBytes("iso-8859-1"), "UTF-8");//request.getParameter("txtDescHerramienta").toString();
                cant = request.getParameter("txtCant").toString() ;
                
                if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
			    boolean rta = false;
                            Herramienta herr = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                herr = new Herramienta();
                                herr.setIdHerramienta(request.getParameter("id"));
                                herr.setDescHerramienta(descHerram);
                                herr.setCant(Integer.parseInt(cant) );
                                rta = herr.update();
                            }
                            else{
                                herr = new Herramienta(descHerram, Integer.parseInt(cant));
                                rta = herr.save();
                            }
                            if (rta)
                            {
                              response.sendRedirect(response.encodeRedirectURL("listaHerramientas.jsp"));
                                
                            }
                           else {
                              response.sendRedirect(response.encodeRedirectURL("inicioUsuario.jsp"));
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
                <script src="js/jquery.validate.js"></script>
         <script type="text/javascript" src="js/jquery.popupwindow.js"></script>       
                 <script>
            $(function() { 
           $('#help').click(function (event) {
           $.popupWindow('helpPages/listaHerramientas_h.html', {
             width: 900,
              height: 600,
            center: 'parent'
          });
     });
        $('#helpGen').click(function (event) {
           $.popupWindow('helpPages/index.html', {
             width: 900,
              height: 600,
            center: 'parent'
          });
     });
        var validator = $("#frmHerramienta").validate({
                rules: {
                        txtDescHerramienta: "required",
                          txtCant: {
                            required: true,
                            number: true,
                            min: 1
                          }
                },
                messages: {
                        txtDescHerramienta: "Campo requerido",
                txtCant: {
                    required: "Campo requerido",
                    number: "Cantidad inválida", 
                    min: "Cantidad debe ser mayor a 1" 
                  }
                 },
                errorPlacement: function(error, element) {
                error.appendTo(element.parent().next());
			},
                errorClass: 'errore'
		});
              });
        </script>

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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaHerramientas.jsp")%>">Herramientas</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                           <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nueva Herramienta";
                if (request.getParameter("id") != null || request.getParameter("accion") != null){
                    titulo ="Modificar Herramienta";
                }%>
            <h2 id="titulo"><%=titulo%></h2>
            

                <% String param = "nuevo";
        if(request.getParameter("id") != null){
            param = "update&id=" + request.getParameter("id");
        }
        %>
        <div id="formu">
        <form id="frmHerramienta" name="frmHerramienta" class="formAbm" action="<%= response.encodeURL("nuevaHerramienta.jsp?accion=" + param)%>" method="POST">
            <fieldset style="height: 150px;">
                <legend ><strong>Datos herramienta</strong></legend>
               <!--     <label for="txtidHerramienta"></label>
                        <input type="text" id="txtrazonsocial" name="txtidHerramienta" value="<//%= idHerram %>"/>
                    <br /> -->
             
               <table class="tablaFormatoABM">
               <tr>
                  
               <td> <label for="txtDescHerramienta"> Descripción: </label></td>
               <td>          <input type="text" id="txtDescHerramienta" name="txtDescHerramienta" value="<%= descHerram %>"/></td>
               <td>*</td>
               </tr>
                <tr>
                  <td>     <label for="txtCant"> Cantidad: </label></td>
                   <td>      <input type="text" id="txtCant" name="txtCant"   value="<%= cant %>"/></td>
                   <td>*</td>
                </tr>
                <tr> 
                    <td colspan="2" style="text-align:center;">
                     <input type="submit" value="Guardar"  />
                    </td>
                </tr>
           </table> 
               
                     <div style="font-size: 10px; float: right">   (*) Campo requerido </div>
            </fieldset>
        </form>
        </div>
         </div>
        </div>
                     <%@ include file="WEB-INF/jspf/firma.jspf" %>
 
    </body>
</html>