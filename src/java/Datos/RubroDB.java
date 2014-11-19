package Datos;

import Entidades.Rubro;
import Entidades.Material;
import Entidades.ManoDeObra;
import java.sql.ResultSet;
import java.util.*;


public class RubroDB extends AccesoDatos {

public RubroDB() throws Exception{}

    //carga todos los rubros disponibles, con sus correspondientes subrubros, materiales y mano de obra
   public List getRubrosConSubrubros() throws Exception      {
          List<Rubro>  listaRub = new ArrayList();
          List<Rubro>  listaSubRub ;
          List<Material>  listaMat;
          List<ManoDeObra>  listaMO;

         ResultSet resultado = EjecutarQuery("select idRubro, descRubro, idUnidadMedida from rubros where idrubropadre is null order by idRubro " );
         while (resultado.next())
         {
             Rubro rub = new Rubro();
             rub.setIdRubro(resultado.getString(1));
             rub.setDescRubro(resultado.getString(2));
             rub.setIdUnidadMedida(resultado.getString(3));
             rub.setCantPresRub(Float.parseFloat("1"));

             listaSubRub = buscaSubrubros(resultado.getString(1));
             rub.setSubrubros(listaSubRub);

              listaMat = getMaterialesEnRubro(resultado.getString(1));
              rub.setMateriales(listaMat);

              listaMO = getMOEnRubro(resultado.getString(1));
              rub.setManoDeObra(listaMO);

             listaRub.add(rub);
          } 
              closeCon();
             return listaRub;
        }

   /*metodo que busca los hijos (subrubros) de un rubro dado*/ 
   public List buscaSubrubros(String idRubro) throws Exception{
         List<Rubro>  listaSub = new ArrayList();
         List<Rubro>  listaSubR;
         List<Material>  listaMat;
         List<ManoDeObra>  listaMO;

         ResultSet resultado = EjecutarQuery("select r.idRubro,r.descRubro,r.idUnidadMedida from rubros r inner join rubros r1 on r.idRubroPadre = r1.idrubro and r.idRubroPadre = " + idRubro );
         while (resultado.next()){
             Rubro rub = new Rubro();
             rub.setIdRubro(resultado.getString(1));
             rub.setDescRubro(resultado.getString(2));
             rub.setIdUnidadMedida(resultado.getString(3));
             rub.setCantPresRub(Float.parseFloat("1"));

             listaSubR = buscaSubrubros(resultado.getString(1));
             rub.setSubrubros(listaSubR);

             listaMat = getMaterialesEnRubro(resultado.getString(1));
             rub.setMateriales(listaMat);

             listaMO = getMOEnRubro(resultado.getString(1));
             rub.setManoDeObra(listaMO);

             listaSub.add(rub);
         }
         return listaSub;
     }

   /*metodo que busca los materiales para un id de rubro*/ 
   public List getMaterialesEnRubro(String idRubro) throws Exception{
        List listaMat = new ArrayList();
        ResultSet resultado = EjecutarQuery("select mr.idMaterial, mr.coefStdMat , m.descMaterial, m.idUnidadMedida, m.precioMa from materialesrubro mr inner join  materiales m on mr.idMaterial = m.idMaterial where idrubro = " + idRubro );
        while (resultado.next()){
            Material mat = new Material();
            mat.setIdMaterial(resultado.getString(1));
            mat.setCoefStdMat(resultado.getFloat(2));
            mat.setDescMaterial(resultado.getString(3));
            mat.setIdUnidadMedida(resultado.getString(4));
            mat.setPrecioMa(resultado.getFloat(5));
            mat.setCantPres(resultado.getFloat(2));

            listaMat.add(mat);
        }
        return listaMat;
    } 

    /*metodo que busca la mano de obra para un id de rubro*/ 
   public List getMOEnRubro(String idRubro) throws Exception{
        List listaMO = new ArrayList();
        float ctd ;
        ResultSet resultado = EjecutarQuery("select mr.idManoDeObra, mr.coefStdMo , m.descManoDeObra, m.idUnidadMedida, m.precioMo from manodeobrarubro mr inner join  manodeobra m on mr.idManoDeObra = m.idManoDeObra where idrubro = " + idRubro );
        while (resultado.next()){
            ctd = resultado.getFloat(2);
            ManoDeObra mo = new ManoDeObra();
            mo.setIdManoDeObra(resultado.getString(1));
            //mo.setCoefStdMO(resultado.getFloat(2));
            mo.setCoefStdMO(ctd);
            mo.setDescManoDeObra(resultado.getString(3));
            mo.setIdUnidadMedida(resultado.getString(4));
            mo.setPrecioMo(resultado.getFloat(5));
           // mo.setCantPres(resultado.getFloat(2));
            mo.setCantPres(ctd);

            listaMO.add(mo);
        }
        return listaMO;
    } 

     /*metodo que busca el objeto padre directo para un idrubro*/ 
   public Rubro getRubroPadre(String idRubro) throws Exception{
            Rubro padre = new Rubro();
            ResultSet resultado = EjecutarQuery("select rp.idRubro, rp.descRubro, rp.idUnidadMedida  from rubros r inner join rubros rp on rp.idRubro = r.idRubroPadre where r.idRubro = " + idRubro );
            while (resultado.next()){
                padre.setIdRubro(resultado.getString(1));
                padre.setDescRubro(resultado.getString(2));
                padre.setIdUnidadMedida(resultado.getString(3));
                padre.setSubrubros(new ArrayList());    //esta vacio pq lo uso pal presup, la carga de all available subr is pointless
                padre.setMateriales(getMaterialesEnRubro(resultado.getString(1)));
                padre.setManoDeObra(getMOEnRubro(resultado.getString(1)));
            }
            return padre;
        }      

   ///Obtiene un objeto rubro a partir del idRubro
    public Rubro getRubro(String idRubro) throws Exception    {
        Rubro r = new Rubro();
        List<Rubro>  listaSubRub ;
        ResultSet resultado = EjecutarQuery("SELECT idRubro, descRubro, idUnidadMedida FROM rubros WHERE idRubro = " + idRubro);
      
        while (resultado.next())
        {
            r.setIdRubro(idRubro);
            r.setDescRubro(resultado.getString(2));
            r.setIdUnidadMedida(resultado.getString(3));
          //  r.setSubrubros(new ArrayList()); //ojo q esto borra la lista de rubr
            
            //NEW!
             listaSubRub = buscaSubrubros(idRubro);
             r.setSubrubros(listaSubRub);   
            
            r.setMateriales(getMaterialesEnRubro(idRubro));
            r.setManoDeObra(getMOEnRubro(idRubro));
        }
        resultado.close();
        return r;
    }

    public boolean saveMatEnRub(String idR, ArrayList<Material> listaMat){ 
        boolean rta = true;
                Iterator itMat = listaMat.iterator();  //OJO! listaMat no tiene descripcion
                while(itMat.hasNext())
                {
                    Material  ma = (Material)itMat.next();
                    rta  = EjecutarNonQuery("insert into materialesrubro (idRubro, idMaterial, coefStdMat)  VALUES ( '" +  idR  + "' , '" + ma.getIdMaterial()  + "' , " +ma.getCoefStdMat() +   " )");
                    if(rta )
                    {
                         rta = commit();
                     }
                     if(!(rta))
                     {
                         rollback();
                     }    
                 }
        closeCon();
        return rta;
    }  

    public boolean saveMoEnRub(String idR, List<ManoDeObra> listaMo) {
        boolean rta = true;

        Iterator itMo = listaMo.iterator();
        while (itMo.hasNext()) {
            ManoDeObra mo = (ManoDeObra) itMo.next();
            rta = EjecutarNonQuery("insert into manodeobrarubro (idRubro, idManoDeObra, coefStdMo)  VALUES ( '" + idR + "' , '" + mo.getIdManoDeObra() + "' , " + mo.getCoefStdMO() + " )");
            if (rta) {
                rta = commit();
            }
            if (!(rta)) {
                rollback();
            }
        }
        closeCon();
        return rta;
    }

    public boolean deleteMatEnRub(String idR, ArrayList<Material> listaMat){ 
        boolean rta = true;
                Iterator itMat = listaMat.iterator();  //OJO! listaMat no tiene descripcion
                while(itMat.hasNext())
                {
                    Material  ma = (Material)itMat.next();
                    rta  = EjecutarNonQuery("delete from materialesrubro where idRubro = '" +  idR  + "'  and idMaterial = '" + ma.getIdMaterial()  + "' ");
                    if(rta )
                    {
                         rta = commit();
                     }
                     if(!(rta))
                     {
                         rollback();
                     }    
                 }
        closeCon();
        return rta;
    }  

    public boolean deleteAllMatEnRub(String idR){ 
        boolean rta = true;
                rta  = EjecutarNonQuery("delete from materialesrubro where idRubro = '" +  idR   + "' ");
                if(rta )
                {
                     rta = commit();
                 }
                 if(!(rta))
                 {
                     rollback();
                 }    
        closeCon();
        return rta;
    } 

    public boolean deleteMoEnRub(String idR, List<ManoDeObra> listaMo) {
        boolean rta = true;

        Iterator itMo = listaMo.iterator();
        while (itMo.hasNext()) {
            ManoDeObra mo = (ManoDeObra) itMo.next();
            rta  = EjecutarNonQuery("delete from manodeobrarubro where idRubro = '" +  idR  + "'  and idManoDeObra = '" +  mo.getIdManoDeObra()  + "' ");
             if (rta) {
                rta = commit();
            }
            if (!(rta)) {
                rollback();
            }
        }
        closeCon();
        return rta;
    }

    public boolean deleteAllMoEnRub(String idR) {
        boolean rta = true;

             rta  = EjecutarNonQuery("delete from manodeobrarubro where idRubro = '" +  idR  + "' ");
             if (rta) {
                rta = commit();
            }
            if (!(rta)) {
                rollback();
            }
        closeCon();
        return rta;
    }

    //usado por editar Rubro para actualizar info rubro
    public boolean update(Rubro r){
          //no estoy actualizando el rubro padre.
        boolean rta = false;
        String stringUM="";
        if (r.getIdUnidadMedida() != null)
        {
            stringUM = "'"+ r.getIdUnidadMedida()+ "'"; //evito el 'null'
            
            if(r.getIdUnidadMedida().equals("RG")) //else //le saque el else pq nunca es nulo al venir de un combo
           {
               stringUM = "null";
           }    

        }
        else
        {
            stringUM =  r.getIdUnidadMedida();
        }
        
           rta = EjecutarNonQuery("UPDATE rubros SET descRubro = '" + r.getDescRubro() + "', idUnidadMedida = " + stringUM + " WHERE idRubro = '" + r.getIdRubro() +"'");

        if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
                closeCon();
        return rta;
    }
 
//    //borra rubro y tablas relac. no toca presupuesto
    public boolean delete(String idR) { 
	boolean rta = false;
	//boolean rta1,rta2,rta3;
        boolean rta1 = false;
        boolean rta2 = false;
        boolean rta3 = false;
        
        boolean rta4 = true;
	List<Rubro>  listaSubRub ;
        Rubro rub = new Rubro();
	 try{
             rub = getRubro(idR);
           }
            catch(Exception e){}

if (validarCantRub(idR)==0){         
	rta1 =  EjecutarNonQuery("delete from rubros WHERE idRubro = " + idR);
	rta2 =  EjecutarNonQuery("delete from manodeobrarubro WHERE idRubro = " + idR);
	rta3 =  EjecutarNonQuery("delete from materialesrubro WHERE idRubro = " + idR);
	
	//System.out.println("desde delete: borro todo rub " + idR);
	 listaSubRub = rub.getSubrubros();
  
          if(!listaSubRub.isEmpty() )
          {
            rta4 = deleteSubrubros(listaSubRub);  
          }
}   
        if(rta1 && rta2 && rta3 && rta4)
       {
             rta = commit();
         }
        else
         {
                 rollback();
         } 
        closeCon();
	return rta;
					 
}

    public boolean deleteSubrubros(List<Rubro> listaSub) {
        boolean rta = false;
	boolean rta1,rta2,rta3;
        boolean rta4 = true;
        Iterator itSR = listaSub.iterator();
        while (itSR.hasNext()) {
            Rubro sRub = (Rubro) itSR.next();
	rta1 =  EjecutarNonQuery("delete from rubros WHERE idRubro = " + sRub.getIdRubro());
	rta2 =  EjecutarNonQuery("delete from manodeobrarubro WHERE idRubro = " + sRub.getIdRubro());
	rta3 =  EjecutarNonQuery("delete from materialesrubro WHERE idRubro = " + sRub.getIdRubro());

        // System.out.println("desde dSub: borro todo rub " + sRub.getIdRubro());
        
         if(!sRub.getSubrubros().isEmpty() )
          {
            rta4 = deleteSubrubros(sRub.getSubrubros());  
          }
         
        if(rta1 && rta2 && rta3 && rta4)
       {
             rta = commit();
         }
        else
         {
                 rollback();
         } 
            
        }
     //  closeCon();
	return rta;
    }
	
    public Rubro generarIdSubrubro(String idRubroPadre)throws Exception   
    {
        Rubro r = new Rubro();
        int nuevoId=0;
        String nuevoIdRubro;
        int lenPadre = idRubroPadre.length();
    
        ResultSet resultado = EjecutarQuery("select max(idRubro) from rubros where idRubroPadre = '" + idRubroPadre + "'") ;
           while (resultado.next())
        {
            if(resultado.getString(1) != null)
            { 
                nuevoId = Integer.parseInt(resultado.getString(1).substring(lenPadre,lenPadre+3))+1;
            }
            else
            {
                nuevoId = 1;
            }
           
        }
           nuevoIdRubro = idRubroPadre + String.format("%03d",nuevoId) ;
          r.setIdRubro(nuevoIdRubro);
           
        resultado.close();
        closeCon();
        return r;
 
    }
        //usado por agregar Rubro para alta rubro
    public boolean save(Rubro r){
        boolean rta = false;
        String stringUM="";
        String idHijo = r.getIdRubro();
        String idPadre = r.getIdRubro().substring(0,(idHijo.length()-3) );
        if (r.getIdUnidadMedida() != null)
        {
            stringUM = "'"+ r.getIdUnidadMedida()+ "'"; //evito el 'null'
       
            if(r.getIdUnidadMedida().equals("RG")) //else //le saque el else pq nunca es nulo al venir de un combo
            {
                stringUM = "null";
            }
         }
        else
        {
            stringUM =  r.getIdUnidadMedida();
        }
            rta = EjecutarNonQuery("INSERT INTO rubros (idRubro,descRubro,idRubroPadre,idUnidadMedida) VALUES (  '" + idHijo +"' ,'"  + r.getDescRubro() +"' ,'"  + idPadre+ "' ," + stringUM +")");

        if(rta){
            rta = commit(); 
        }
        if(!rta){
            rollback();
        }
                closeCon();
        return rta;
    }
    
       /*metodo q devuelve los rubros q tienen um porc. usado presupuesto*/ 
    public List getRubrosPorc() throws Exception{
        List listaPorc = new ArrayList();
        ResultSet resultado = EjecutarQuery("select idRubro from rubros where idunidadmedida = 'PORC'" );
        while (resultado.next()){
          
         listaPorc.add(resultado.getString(1));
        }
        return listaPorc;
    } 
    
   
    public int validarCantRub(String idRub){    
    int rta = EjecutarQueryInt("Select count(*) from rubrospresupuesto where idRubro = '" + idRub+"'" );
    return (rta);
       } 
            
    public int verificaDescRub(String desc, String idR){
        int rta = EjecutarQueryInt("SELECT count(*) FROM rubros where descRubro = '" + desc +"' and idRubro != '"+idR+"'");
        closeCon();
        return (rta);
    }
}
