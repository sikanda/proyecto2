<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Rubro"%>
<%@ page import="Entidades.Presupuesto"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page errorPage="errorPageUser.jsp" %>
<%@ include file="WEB-INF/jspf/redirUsr.jspf" %> 

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="rubroDB" scope="page" class="Datos.RubroDB" />
<jsp:useBean id="presupuestoDB" scope="page" class="Datos.PresupuestoDB" />

<%!
public Rubro getRubroByCode(String idRubro, List<Rubro> lista) {
        Rubro rubro = new Rubro();
        for (int i = 0; i < lista.size(); i++) {
            if (idRubro.equals(lista.get(i).getIdRubro())) {
                rubro = lista.get(i);
                break;
            }
            List<Rubro> lista2 = lista.get(i).getSubrubros();
            for (int h = 0; h < lista2.size(); h++) {
                if (idRubro.equals(lista2.get(h).getIdRubro())) {
                    rubro = lista2.get(h);
                    break;
                }
                List<Rubro> lista3 = lista2.get(h).getSubrubros();
                for (int k = 0; k < lista3.size(); k++) {
                    if (idRubro.equals(lista3.get(k).getIdRubro())) {
                        rubro = lista3.get(k);
                        break;
                    }
                    List<Rubro> lista4 = lista3.get(k).getSubrubros();
                    for (int p = 0; p < lista4.size(); p++) {
                        if (idRubro.equals(lista4.get(p).getIdRubro())) {
                            rubro = lista4.get(p);
                            break;
                        }
                    }
                }
            }
        }
        return rubro;
    }
%>

<%
	List<Rubro> rub = new ArrayList();
    try{
        rub = rubroDB.getRubrosConSubrubros(); 
        
        if (request.getParameter("id") != null){       
        int idPresEdit = Integer.parseInt(request.getParameter("id"));
        Presupuesto presEdit = presupuestoDB.getPresupuesto(idPresEdit);
       // String[] listaRubCurrentPres = null ;
       String[] listaRubCurrentPres =  new String[presEdit.getRubros().size()];
          for (int z=0; z< presEdit.getRubros().size(); z++){
                listaRubCurrentPres[z] = presEdit.getRubros().get(z).getIdRubro();
           }   
          StringBuilder sb = new StringBuilder();
          for(String s: listaRubCurrentPres) {
            sb.append("_").append(s);
         }  
          String idesFinal =  sb.toString();
           session.setAttribute("idesFinale", idesFinal);
           session.setAttribute("presupuestoQueSeEdita", presEdit);
        }

        String[] listaIds = null;
        //string of IDS
        if (request.getParameter("ids") != null){
           String cadena = request.getParameter("ids").toString();
          session.setAttribute("cadenaIdes", cadena);
           listaIds = cadena.split("_");
           List<Rubro> listaRubrosSelec = new ArrayList();

           for (int p=0; p<listaIds.length; p++){
                Rubro rubro = getRubroByCode(listaIds[p],rub);
                listaRubrosSelec.add(rubro);
           } 
           session.setAttribute("rubrosLeaf", listaRubrosSelec);
           response.sendRedirect(response.encodeRedirectURL("editarPresupuesto2.jsp"));
        }
      }
      catch(Exception e)
      {
          throw new RuntimeException("Error!");
      }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><%=globconfig.nombrePag() %></title>
 
<%@ include file="WEB-INF/jspf/estilo.jspf" %>

<link href="dist/themes/default/style.min.css" rel="stylesheet" type="text/css" title="Estilo"/>
<style type="text/css"> /* This makes only leaves have checkboxes */
    #jstree .jstree-open > .jstree-anchor > .jstree-checkbox, 
    #jstree .jstree-closed > .jstree-anchor > .jstree-checkbox { display:none; }
</style>
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioUsuario.jsp")%>">inicio</a><%=globconfig.separador()%>editar presupuesto</a></p></li>
                                <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                                    </ul>
                                    <br class="clear" />
                                </div>
                        </div>
                <div id="main">
                    <h2 id="titulo">Seleccione los rubros deseados</h2>

                    <div id="contenedor">
                        <table id="tablaRubros">
                            <tr>
                                <td id="col1">Rubros</td>
                                <td></td>
                                <td id="col2">Seleccionados</td>
                            </tr>
                            <tr>  
                                <td>
                                    <div id="jstree">
                                                     <ul> 
                                                                        <%
                                                                List<Rubro> subrub = new ArrayList();   
                                                                List<Rubro> subrub2 = new ArrayList(); 
                                                                List<Rubro> subrub3 = new ArrayList(); 

                                                            for (int i = 0; i < rub.size(); i++) { %>
                                                               <li id="<%=rub.get(i).getIdRubro() %>"><%= rub.get(i).getDescRubro()%>
                                                                   <ul>            
                                                           <%
                                                           subrub = rub.get(i).getSubrubros(); 
                                                            for (int j = 0; j < subrub.size(); j++) {
                                                             %>
                                                                    <li id="<%=subrub.get(j).getIdRubro() %>">    <%= subrub.get(j).getDescRubro() %>
                                                                       <ul>  
                                                                        <%
                                                                        subrub2 = subrub.get(j).getSubrubros();
                                                                          for (int k = 0; k < subrub2.size();k++) {
                                                                         %>    
                                                                         <li id="<%=subrub2.get(k).getIdRubro() %>"> <%= subrub2.get(k).getDescRubro() %>
                                                                         <ul>
                                                                     <%    subrub3 = subrub2.get(k).getSubrubros();

                                                                          for (int m = 0; m < subrub3.size();m++) {
                                                                         %>  
                                                                             <li id="<%=subrub3.get(m).getIdRubro() %>" data-jstree='{"icon":"http://jstree.com/tree.png"}'> <%= subrub3.get(m).getDescRubro() %></li>
                                                                          <% 
                                                            }%>
                                                               </ul></li>                  
                                                            <%    }          %>  </ul></li>
                                                           <% 
                                                            } %>
                                                             </ul></li>
                                                             <%   }          %>
                                                     </ul>
                                    </div>
                                </td>
                                <td>
                                    <div id="botones">
                                        <button id="agregar" style="height:25px; width: 70px;">Agregar</button>
                                        <form id="formulario">
                                            <input type="hidden" id="rubrosIds" name="ids" value=""/>
                                            <input disabled type="submit" value="Continuar" id ="btnCont" style="height:25px; width: 70px;"/>
                                        </form>                                       
                                    </div>
                                </td>
                                <td id="event_result">
                                    
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
                                 
                                 
  <!-- include the jQuery library -->
  <script src="dist/libs/jquery.js"> </script>
  <!-- include the minified jstree source -->
  <script src="dist/jstree.min.js"></script>
  <script type="text/javascript" src="js/jquery.popupwindow.js"></script>

<script>
$(function () {
    $('#jstree').jstree({
                        "checkbox" : {
                                      "keep_selected_style" : false                   
                                     },
                        "plugins" : [ "checkbox" ]
                        });  
                        
 $('#help').click(function (event) {
   $.popupWindow('helpPages/editarPresupuesto_h.html', {
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

//var chainFinal = '<//%= session.getAttribute("idesFinale") %>';
//var resFinal = chainFinal.split("_");
//for (j = 0; j < resFinal.length; ++j) {
//   $("#jstree").jstree("select_node",resFinal[j]);  
//}

function getURLParameter(name) {
  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
}
var paramAct = getURLParameter('action');  
if (paramAct) {
var chain = '<%= session.getAttribute("cadenaIdes") %>';
var res = chain.split("_");
for (i = 0; i < res.length; ++i) {
   $("#jstree").jstree("select_node",res[i]);  
}
 }
 else
 {
    var chainFinal = '<%= session.getAttribute("idesFinale") %>';
var resFinal = chainFinal.split("_");
for (j = 0; j < resFinal.length; ++j) {
   $("#jstree").jstree("select_node",resFinal[j]);  
} 
 }

//$("#jstree").jstree("select_node","001001");
}); 	
//bind to events triggered on the tree
$('#jstree').on("changed.jstree", function (e, data) {
  console.log(data.selected);
});   

//Stops the propagation of the selection of the nodes to their leaves
$('#jstree').on("select_node.jstree deselect_node.jstree", function (e, data) {
    if(data.node.children.length) {
        e.preventDefault(); // may not be necessary
        e.stopImmediatePropagation();
        // uncomment below if you wish to have the parent item open/close the tree when double clicked
        //return data.instance.toggle_node(data.node);
    }
})

$('#agregar').on('click', function (){
var selectedElmsNames = [];
var selectedElmsIds = [];
var elem = document.getElementById("rubrosIds");
var selectedElms = $('#jstree').jstree("get_selected", true);
$.each(selectedElms, function() {
    if(this.children.length > 0 === false) //CHECK IF NODE IS LEAF
        {selectedElmsNames.push(this.text);
         selectedElmsIds.push(this.id);
        }
});
elem.value =selectedElmsIds.join('_'); // Change field
$('#event_result').html(selectedElmsNames.join('<br/>'));
 
if (elem.value.length > 0) 
{ //enable
    $('#btnCont').removeAttr("disabled", 'disabled'); 
    }else { //disable
       $('#btnCont').attr("disabled", 'disabled'); 
        };
});



  </script>
                   <%@ include file="WEB-INF/jspf/firma.jspf" %>
      

    </body>
</html>