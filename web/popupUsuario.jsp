<jsp:useBean id="usuarioDB" scope="page" class="Datos.UsuarioDB" />
<%

       String nameUs = request.getParameter("nameUs"); 

        int cant =  usuarioDB.verificaNomUsuario(nameUs);
       if(cant == 0){
        out.print(true); 
        }
       else{
           out.print(false);
       }

  %>   
