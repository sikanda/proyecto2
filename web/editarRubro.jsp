<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="Entidades.Rubro"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="WEB-INF/jspf/redirAdm.jspf" %>

<jsp:useBean id="globconfig" scope="application" class="Base.Config" />
<jsp:useBean id="rubroDB" scope="page" class="Datos.RubroDB" />

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
	rub = rubroDB.getRubrosConSubrubros();
       
        //string of IDS
        if (request.getParameter("ids") != null){
           String cadena = request.getParameter("ids").toString();
     
           Rubro rubro = getRubroByCode(cadena,rub);
             
           
           session.setAttribute("rubroEdit", rubro);
           response.sendRedirect(response.encodeRedirectURL("editarRubro1.jsp"));
        }       
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><%=globconfig.nombrePag() %></title>
        
<script type="text/javascript" src="js/apprise.js"></script>
<link rel="stylesheet" href="estilos/apprise.css" type="text/css" />

<%@ include file="WEB-INF/jspf/estilo.jspf" %>

<link href="dist/themes/default/style.min.css" rel="stylesheet" type="text/css" title="Estilo"/>
<style type="text/css"> /* This makes only leaves have checkboxes */
    #jstree .jstree-open > .jstree-anchor > .jstree-checkbox, 
    #jstree .jstree-closed > .jstree-anchor > .jstree-checkbox { display:none; }
</style>
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
                                        <li><p class="posicion"><a href="<%= response.encodeURL("inicioAdmin.jsp")%>">inicio</a><%=globconfig.separador()%>rubros</a></p></li>
                                   <li id="help"><a href="" title="Ayuda sobre esta página">Ayuda</a></li>
                                    </ul>
                                    <br class="clear" />
                                </div>
                        </div>
                <div id="main">
                    <h2 id="titulo">Seleccione el rubro a modificar</h2>

                    <div id="contenedor">
                        <table id="tablaRubros">
                            <tr>
                                <td id="col1">Rubros</td>
                                <td > </td>
                               </tr>
                            <tr>  
                                <td>
                                    <div id="jstree">
                                        <ul> 
                                            <%
                                                List<Rubro> subrub = new ArrayList();
                                                List<Rubro> subrub2 = new ArrayList();
                                                           List<Rubro> subrub3 = new ArrayList();

                                                           for (int i = 0; i < rub.size(); i++) {%>
                                            <li id="<%=rub.get(i).getIdRubro()%>" ><%= rub.get(i).getDescRubro()%>
                                                <ul>            
                                                    <%
                                                        subrub = rub.get(i).getSubrubros();
                                                        for (int j = 0; j < subrub.size(); j++) {
                                                    %>
                                                    <li id="<%=subrub.get(j).getIdRubro()%>" >    <%= subrub.get(j).getDescRubro()%>
                                                        <ul>  
                                                            <%
                                                                subrub2 = subrub.get(j).getSubrubros();
                                                                for (int k = 0; k < subrub2.size(); k++) {
                                                            %>    
                                                            <li id="<%=subrub2.get(k).getIdRubro()%>" > <%= subrub2.get(k).getDescRubro()%>
                                                                <ul>
                                                                    <%    subrub3 = subrub2.get(k).getSubrubros();

                                                                        for (int m = 0; m < subrub3.size(); m++) {
                                                                    %>  
                                                                    <li id="<%=subrub3.get(m).getIdRubro()%>" > <%= subrub3.get(m).getDescRubro()%></li>
                                                                        <%
                                                             }%>
                                                                </ul></li>                  
                                                            <%    }  %>  </ul></li>
                                                            <%
                                              } %>
                                                </ul></li>
                                                <%   }%>
                                        </ul>
                                    </div>
                                </td>
                              <td >     <div id="botones">
                                      <form id="formulario">
                                          <strong>     Usted ha seleccionado el rubro: </strong>
                                          <p id="mje" name="mje" value=""> </p>
                                          <br>
                                          <br>
                                        <input id="rubrosIds" type="hidden" name="ids" value=""/>
                                        <button disabled="disabled" class="notleaf" type="button" id="btnAgregar" name="btnAgregar" style="height:25px; width: 90px;" >Alta Rubro</button>
                                        <input disabled  class="btnToggle" id="btnCont" type="submit" value="Editar" style="height:25px; width: 70px;" />
                                        <button disabled="disabled" class="onlyLeaf" type="button" id="btnBorrar" name="btnBorrar" style="height:25px; width: 70px;" >Borrar</button>
                                        </form>                                       
                                    </div>
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
            "plugins" : [ "themes",  "ui"],   // "themes","checkbox", "ui"
              "themes" : {
                "theme" : "classic",
                "dots" : true,
                "icons" : true
                  },
              "ui" : {
                  "select_limit" : 1  //only allow one node to be selected at a time
                 //,"disable_selecting_children" : "true"
                  },
                   "core" : {
                    "multiple" : false,
                    "animation" : 0
                
                    },
                    "checkbox": { "two_state" : true }
            }) ; //jstree
     
  var typ="Rub";
 $("#btnBorrar").click(function(e){
  var idee = $("#rubrosIds").val(); // alert(idee); 
       e.preventDefault();  
 //alert(idSelected);
       apprise('¿Está seguro que desea borrar el rubro y su información asociada?',  {'confirm':true}   , function(r) {
         if(r) {  
      $.ajax({
             url: 'popupBorrar.jsp',
             type: 'GET',
             data:  {ident : idee, objeto:typ},
             success: function() {
                location.reload();  
             },
             error: function(e) {
              apprise ('Ha ocurrido un error');
             }
           }); //ajax 
           }//if r   
    }); //apprise
}); //click
	
      $('#help').click(function (event) {
   $.popupWindow('helpPages/editarRubro_h.html', {
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
//bind to events triggered on the tree
$('#jstree').on("changed.jstree", function (e, data) {
if (data.node.children.length)  //>0 = true, tiene hijos lo habilito
{     $('.notleaf').removeAttr("disabled", 'disabled');  
      $('.onlyLeaf').attr("disabled", 'disabled'); 
        } 
else 
{    $('.notleaf').attr("disabled", 'disabled'); 
    $('.onlyLeaf').removeAttr("disabled", 'disabled');  
        }
  console.log(data.selected);
  disparaClick();    
});   
 
$('#jstree').on("select_node.jstree", function (e,data){
if(data.node.children.length) { 
    $('.notleaf').removeAttr("disabled", 'disabled');  
    $('.onlyLeaf').attr("disabled", 'disabled');    
}
      $('.btnToggle').removeAttr("disabled", 'disabled');     
    });
    
$('#jstree').on("deselect_node.jstree", function (e,data){
         $('.btnToggle').attr("disabled", 'disabled'); 
         $('.notleaf').attr("disabled", 'disabled'); 
         $('.onlyLeaf').attr("disabled", 'disabled'); 
    });
    
//Stops the propagation of the selection of the nodes to their leaves
$('#jstree').on("select_node.jstree deselect_node.jstree", function (e, data) {
    if(data.node.children.length) {
        e.preventDefault(); 
        e.stopImmediatePropagation();
 }
});

var idSelected="";
function disparaClick(){
var selectedElmsNames = [];
var selectedElmsIds = [];
var elem = document.getElementById("rubrosIds");
var selectedElms = $('#jstree').jstree("get_selected", true);

$.each(selectedElms, function() {
  //  if(this.children.length > 0 === false) //CHECK IF NODE IS LEAF
       // {
            selectedElmsNames.push(this.text);
         selectedElmsIds.push(this.id);
         idSelected=this.id;
       // }
});
elem.value =selectedElmsIds.join('_'); // Change field
$('#mje').text(selectedElmsNames);
};

 
    document.getElementById("btnAgregar").onclick = function () {
        location.href = "agregarRubro.jsp?idRub="+idSelected ;
    };
    

  </script>
            <%@ include file="WEB-INF/jspf/firma.jspf" %>
        </div>
    </body>
</html>