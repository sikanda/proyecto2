<%@ page import="Entidades.ManoDeObra"%>
<jsp:useBean id="manoDeObraDB" scope="page" class="Datos.ManoDeObraDB" />
<%
        //List<Material> materiales = new ArrayList();
	//materiales = materialDB.getMateriales();
       String idMo = request.getParameter("currentMo");     //("dataMObra");
      // System.out.println(mo);
       ManoDeObra currentManoDeObra =  manoDeObraDB.getManoDeObra(idMo);
       if(currentManoDeObra != null){
        out.print(currentManoDeObra.getIdUnidadMedida() +":"+currentManoDeObra.getPrecioMo()); 
        }
       else{
           out.print(""+":"+"");
       }
       // out.print(":"+currentMaterial.getCoefStdMat() ); 
  %>   
