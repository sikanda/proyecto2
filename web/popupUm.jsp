<jsp:useBean id="unidadMedidaDB" scope="page" class="Datos.UnidadMedidaDB" />
<%

       String codUm = request.getParameter("codUm"); 

        int cant =  unidadMedidaDB.verificaCodUm(codUm);
       if(cant == 0){
        out.print(true); 
        }
       else{
           out.print(false);
       }

  %>   
