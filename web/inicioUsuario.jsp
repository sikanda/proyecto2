<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= globconfig.nombrePag()%> </title>
  <%@ include file="WEB-INF/jspf/estilo.jspf" %>
  
 
 	
   <%@ include file="WEB-INF/jspf/redirUsr.jspf" %>
          <script src="dist/libs/jquery.js" ></script>
        <script type="text/javascript" src="js/jquery.popupwindow.js"></script>
                <script>
            $(function() { 
          
           $('#help').click(function (event) {
           $.popupWindow('helpPages/inicioUsuario_h.html', {
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
                             <div id="nav" >
                                    <ul>
                                        <li><p class="posicion">inicio</p></li>
                                         <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                                    </ul>
                                    <br class="clear" />
                            </div>
                                
                        </div>
<!--                                <div id="main">
                                    <fieldset id="optionMenu">  
                                    <legend><strong>Seleccione una opción  </strong></legend>
                                    <br/> 
                                    <ul class="niceMenu" >
                                            <li><a href="listaRubros.jsp" title="Presupuesto" style="height:51px;line-height:51px;"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/icon_dashboard.png" alt="Presupuesto"/>Generar presupuesto</font></a></li>
                                            </br>
                                            <li><a href="listaProveedores.jsp" title="Proveedores" style="height:51px;line-height:51px;"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/icon_users.png" alt="Proveedores"/>Proveedores</font></a></li>
                                            </br>
                                            <li><a href="listaHerramientas.jsp" title="Herramientas" style="height:51px;line-height:51px;"><img style="resize: none; overflow-y: hidden;vertical-align:middle;" src="images/icon_settings.png" alt="Herramientas"/>Herramientas</font></a></li>

                                    </ul>
                                    </fieldset>
                                    </div>       
  -->    
                        <div id="main22" >
                            <h2 style="color: white; font-family: Calibri ,Tahoma, Geneva ">Menú de Usuario</h2>
               
<div id="mifeomenu" >                                         
<a href="listaRubros.jsp" ><input type="image"  src="images/GPSB.png" onMouseOver="this.src='images/GPH.png'" onMouseOut="this.src='images/GPSB.png'">    </a></br>
<a href="listaProveedores.jsp"  ><input type="image"  src="images/PRSB.png" onMouseOver="this.src='images/PRH.png'" onMouseOut="this.src='images/PRSB.png'"></a></br>
<a href="listaHerramientas.jsp"  ><input type="image"  src="images/HESB.png" onMouseOver="this.src='images/HEH.png'" onMouseOut="this.src='images/HESB.png'"></a>
</div>             <!--   </fieldset>  -->
              </div>
                                
                </div>
                            <%@ include file="WEB-INF/jspf/firma.jspf" %>
  
    </body>
</html>