<%@page import="Base.Config.TipoABM"%>
<jsp:useBean id="herramientaDB" scope="page" class="Datos.HerramientaDB" />
<jsp:useBean id="unidadMedidaDB" scope="page" class="Datos.UnidadMedidaDB" />
<jsp:useBean id="materialDB" scope="page" class="Datos.MaterialDB" />
<jsp:useBean id="proveedorDB" scope="page" class="Datos.ProveedorDB" />
<jsp:useBean id="manoDeObraDB" scope="page" class="Datos.ManoDeObraDB" />
<jsp:useBean id="usuarioDB" scope="page" class="Datos.UsuarioDB" />
<jsp:useBean id="rubroDB" scope="page" class="Datos.RubroDB" />
<%

//       String nameUs = request.getParameter("nameUs"); 
//
//        int cant =  usuarioDB.verificaNomUsuario(nameUs);
//       if(cant == 0){
//        out.print(true); 
//        }
//       else{
//           out.print(false);
//       }

       String desc = request.getParameter("desc"); 
       String tipo = request.getParameter("tipo");
       String id = request.getParameter("ide");
System.out.println("tipo " + tipo);
System.out.println("desc " + desc);
System.out.println("ide " + id);
       TipoABM typ = TipoABM.valueOf(tipo);
        int cant =  0;

        
  if (id == null || (id.equals("")) ){id="";}     
// if (id == null || (id.equals("")) ){ // no id= alta
//               if (desc != null || tipo != null) {

                 switch (typ) {
                       case Herr:
                           cant = herramientaDB.verificaDescHerr(desc,id);
                           break;
                       case Ma:
                          cant = materialDB.verificaDescMa(desc,id);
                          break;
                        case Mo:
                          cant = manoDeObraDB.verificaDescMo(desc,id);
                          break;
                        case Um:
                          cant = unidadMedidaDB.verificaDescUm(desc,id);
                          break;
                        case User:
                         cant =  usuarioDB.verificaNomUsuario(desc,id);
                         break;
                        case Prov:
                          cant = proveedorDB.verificaRazonSocial(desc,id);
                          break;
                         case Rub:
                          cant = rubroDB.verificaDescRub(desc,id);
                          break;
                   }
		
                if(cant == 0){
                  out.print(true); 
                  }
                 else{
                     out.print(false);
                 } 
//               }
// }
// else
// { out.print(true); }
  %>    
