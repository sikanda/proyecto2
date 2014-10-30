<%@page import="Base.Config.TipoABM"%>
<%@ page import="Entidades.Herramienta"%>
<jsp:useBean id="herramientaDB" scope="page" class="Datos.HerramientaDB" />
<jsp:useBean id="proveedorDB" scope="page" class="Datos.ProveedorDB" />
<jsp:useBean id="unidadMedidaDB" scope="page" class="Datos.UnidadMedidaDB" />
<jsp:useBean id="empleadoDB" scope="page" class="Datos.EmpleadoDB" />
<jsp:useBean id="materialDB" scope="page" class="Datos.MaterialDB" />
<jsp:useBean id="manoDeObraDB" scope="page" class="Datos.ManoDeObraDB" />
<jsp:useBean id="usuarioDB" scope="page" class="Datos.UsuarioDB" />
<jsp:useBean id="rubroDB" scope="page" class="Datos.RubroDB" />


<%
           String ident = new String(request.getParameter("ident").getBytes("iso-8859-1"), "UTF-8");// request.getParameter("ident");
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
                         case Rub:
                          rta = rubroDB.delete(ident);
                          break;
                   }
                   if (rta) {
                     // out.print( "ok");
                      response.setStatus(200);
                      System.out.println("200");
                   }
                   else
                   {
                       response.setStatus(400);
                       System.out.println("400");
                   }
               }
           } catch (Exception e) { //out.print( "fail");
                 //Response.status(400);
           }
        
 %>   
