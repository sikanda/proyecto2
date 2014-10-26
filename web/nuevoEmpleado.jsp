<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="Entidades.Empleado"%>


<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="empleadoDB" scope="page" class="Datos.EmpleadoDB" />

<%
        String apellido = "";
        String nombre = "";
    //    Date fechanac = new Date();
        String mail = "";
        String telefono = "";
	String direccion = "";
        String titulo2 = "";

        //levanta los campos en form para modificar
        if (request.getParameter("id") != null  && request.getParameter("accion")== null  ){
            try{
                Empleado emp = empleadoDB.getEmpleado(Integer.parseInt(request.getParameter("id")));
                apellido =  emp.getApellidoEmp();
                nombre = emp.getNombreEmp();
                direccion =  emp.getDireEmp();
                mail =  emp.getEmailEmp();
                telefono =  emp.getTelEmp();
               // fechanac = emp.getFechaNacEmp();
           }
            catch(Exception e)
            {
                response.sendRedirect(response.encodeRedirectURL("listaEmpleados.jsp"));
            }
        }


        if (request.getParameter("accion") != null){
               // fechanac =  request.getParameter("txtfechanac") .toString();
                mail = request.getParameter("txtmail").toString();
                telefono = request.getParameter("txttelefono").toString();
                direccion = new String(request.getParameter("txtdireccion").getBytes("iso-8859-1"), "UTF-8");//request.getParameter("txtdireccion").toString();
                apellido = new String(request.getParameter("txtapellido").getBytes("iso-8859-1"), "UTF-8"); //request.getParameter("txtapellido").toString();
                nombre =  new String(request.getParameter("txtnombre").getBytes("iso-8859-1"), "UTF-8"); //request.getParameter("txtnombre").toString();
                
               if (request.getParameter("accion").contentEquals("nuevo") || request.getParameter("accion").contentEquals("update")){
		        boolean rta = false;
                            Empleado emp = null;
                            if(request.getParameter("accion").contentEquals("update")){
                                //update
                                emp = new Empleado();
                                emp.setIdEmpleado(Integer.parseInt(request.getParameter("id")));
                                emp.setDireEmp(direccion);
                                emp.setNombreEmp(nombre);
                                emp.setApellidoEmp(apellido);
                               // emp.setFechaNacEmp(fechanac);
                                emp.setEmailEmp(mail);
                                emp.setTelEmp(telefono);
                                rta = emp.update();
                            }
                            else{ //nuevo
                                emp = new Empleado(nombre,apellido,direccion,mail,telefono);
                                rta = emp.save();
                            }
                            if (rta)
                            {
                                response.sendRedirect(response.encodeRedirectURL("listaEmpleados.jsp"));
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
               <script src="dist/libs/jquery.js" ></script>	
	   <script type="text/javascript" src="js/jquery.popupwindow.js"></script>
	<script>
	$(function() { 
 
   $('#help').click(function (event) {
   $.popupWindow('helpPages/listaEmpleados_h.html', {
	 width: 900,
	  height: 600,
	center: 'parent'
  });
});
$('#helpGen').click(function (event) {
   $.popupWindow('helpPages/ayudaGeneral.html', {
	 width: 900,
	  height: 600,
	center: 'parent'
  });
});
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
                            <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%><a href="<%= response.encodeURL("listaEmpleados.jsp")%>">Empleados</a><%=globconfig.separador()%><%= titulo2%></a></p></li>
                      <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                        </ul>
                        <br class="clear" />
                    </div>
                </div>

            <div id="main">

            <% String titulo = "Agregar nuevo empleado";
                if (request.getParameter("id") != null || request.getParameter("accion") != null){ 
                    titulo ="Modificar empleado";
                }%>
            <h2 id="titulo"><%=titulo%></h2>
            

          <%    String param = "nuevo";
        if(request.getParameter("id") != null){
            param = "update&id=" + request.getParameter("id");
        }
        %> 
        <div id="formu">
        <form name="frmempleado" class="formAbm" action="<%= response.encodeURL("nuevoEmpleado.jsp?accion=" + param)%>" method="POST">   
               <fieldset>
                    <legend><strong>Datos del empleado</strong></legend>  
                    <div>
                    <label for="txtnombre"> Nombre:</label>
                    <input type="text" id="txtnombre" name="txtnombre" value="<%= nombre %>"/>
                    <br />
                <label for="txtapellido"> Apellido:</label>
                    <input type="text" id="txtapellido" name="txtapellido" value="<%= apellido %>"/>
                    <br />
                      <label for="txtdireccion">  Dirección:</label>
                 <input type="text" id="txtdireccion" name="txtdireccion" value="<%= direccion %>"/>
                    <br />
                     <label for="txtmail"> Email:</label>
                   <input type="text" id="txtmail" name="txtmail" value="<%= mail %>"/>
                    <br />
                     <label for="txttelefono"> Teléfono:</label>
                   <input type="text" id="txttelefono" name="txttelefono" value="<%= telefono %>"/>
                     <br />
       <!--               <label for="txtfechanac"> Fecha Nac.</label>
                       <input type="text" id="txtfechanac" name="txtfechanac" value="<//%= fechanac %>"/>  -->
                     
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