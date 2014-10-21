<%@page import="Base.Config.TipoABM"%>
<%@ page import="Entidades.Herramienta"%>
<jsp:useBean id="herramientaDB" scope="page" class="Datos.HerramientaDB" />
<jsp:useBean id="proveedorDB" scope="page" class="Datos.ProveedorDB" />
<jsp:useBean id="unidadMedidaDB" scope="page" class="Datos.UnidadMedidaDB" />
<jsp:useBean id="empleadoDB" scope="page" class="Datos.EmpleadoDB" />
<jsp:useBean id="materialDB" scope="page" class="Datos.MaterialDB" />
<jsp:useBean id="manoDeObraDB" scope="page" class="Datos.ManoDeObraDB" />
<jsp:useBean id="usuarioDB" scope="page" class="Datos.UsuarioDB" />


<%
           String ident = request.getParameter("ident");
           String objeto = request.getParameter("objeto");
           TipoABM typ = TipoABM.valueOf(objeto);
           
           boolean rta = false;
           try {
               if (ident != null || objeto != null) {

                   switch (typ) {
                       case Herr:
                           rta = herramientaDB.delete(ident);
                           break;
                        case Prov:
                          rta = proveedorDB.delete(Integer.parseInt(ident));
                          break;
                       case Ma:
                          rta = materialDB.delete(ident);
                          break;
                        case Mo:
                          rta = manoDeObraDB.delete(ident);
                          break;
                        case Um:
                          rta = unidadMedidaDB.delete(ident);
                          break;
                        case User:
                          rta = usuarioDB.delete(Integer.parseInt(ident));
                          break;
                        case Emp:
                          rta = empleadoDB.delete(Integer.parseInt(ident));
                          break;
                   }
                   if (rta) {
                       out.print("ok");
                   }
               }
           } catch (Exception e) { //out.print( "fail");
           }
        
 %>   