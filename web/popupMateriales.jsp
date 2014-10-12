<%@ page import="Entidades.Material"%>
<jsp:useBean id="materialDB" scope="page" class="Datos.MaterialDB" />
<%
        //List<Material> materiales = new ArrayList();
	//materiales = materialDB.getMateriales();
       String idMa = request.getParameter("currentMat");     //("dataMObra");
      // System.out.println(mo);
       Material currentMaterial =  materialDB.getMaterial(idMa);
       if(currentMaterial != null){
        out.print(currentMaterial.getIdUnidadMedida() +":"+currentMaterial.getPrecioMa()); 
        }
       else{
           out.print(""+":"+"");
       }
       // out.print(":"+currentMaterial.getCoefStdMat() ); 
  %>   
