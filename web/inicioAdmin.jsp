<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= globconfig.nombrePag()%> </title>
  <%@ include file="WEB-INF/jspf/estilo.jspf" %>
 
   <%@ include file="WEB-INF/jspf/redirAdm.jspf" %>
       <script src="dist/libs/jquery.js" ></script>
        <script type="text/javascript" src="js/jquery.popupwindow.js"></script>
        <script>
            $(function() { 
          
           $('#help').click(function (event) {
           $.popupWindow('helpPages/inicioAdmin_h.html', {
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
                                        <li><p class="posicion">inicio</p></li>
                                         <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                                    </ul>
                                    <br class="clear" />
                            </div>
                        </div>
                      <div id="main22" >
                            <h2 style="color: white; font-family: Calibri ,Tahoma, Geneva ">Menú de Administrador</h2>
               
                                         
                        <!--    <fieldset id="optionMenu"> 
                            <legend><strong>Seleccione una opción </strong></legend> -->
                        
                    <!---    <li><a href="listaManoDeObra.jsp"><img src="images/pin.png" />Mano de Obra</a></li>                                         
                            <li><a href="editarRubro.jsp"><img  src="images/pin.png" />Rubros/Subrubros</a></li>
                            <li><a href="listaUsuarios.jsp"><img  src="images/pin.png" />Usuarios</a></li>
                            <li><a href="listaEmpleados.jsp"><img  src="images/pin.png" />Empleados</a></li>
                            <li><a href="listaMateriales.jsp"><img  src="images/pin.png" />Materiales</a></li>
                            <li><a href="listaUnidadesMedida.jsp"><img  src="images/pin.png" />Unidades de Medida</a></li> -->
<div id="mifeomenu" >                                         
<a href="listaManoDeObra.jsp" ><input type="image"  src="images/MOSB.png" onMouseOver="this.src='images/MOH.png'" onMouseOut="this.src='images/MOSB.png'">    </a>
<a href="editarRubro.jsp"  ><input type="image"  src="images/RUBSB.png" onMouseOver="this.src='images/RUBH.png'" onMouseOut="this.src='images/RUBSB.png'"></a></br>
<a href="listaUsuarios.jsp"  ><input type="image"  src="images/USSB.png" onMouseOver="this.src='images/USH.png'" onMouseOut="this.src='images/USSB.png'"></a>
<a href="listaEmpleados.jsp" ><input type="image"  src="images/EMPSB.png" onMouseOver="this.src='images/EMPH.png'" onMouseOut="this.src='images/EMPSB.png'"></a>  </br>
<a href="listaMateriales.jsp"  ><input type="image"  src="images/MASB.png" onMouseOver="this.src='images/MAH.png'" onMouseOut="this.src='images/MASB.png'"></a> 
<a href="listaUnidadesMedida.jsp"  ><input type="image"  src="images/UMSB.png" onMouseOver="this.src='images/UMH.png'" onMouseOut="this.src='images/UMSB.png'"></a>
</div>             <!--   </fieldset>  -->
              </div>
                </div>
                <%@ include file="WEB-INF/jspf/firma.jspf" %>
        
    </body>
</html>