package Datos;

import Entidades.Rubro;
import Entidades.Material;
import Entidades.ManoDeObra;
import java.sql.ResultSet;
import java.util.*;


public class RubroDB extends AccesoDatos {

public RubroDB() throws Exception{}

      //carga todos los rubros disponibles, con sus correspondientes subrubros, materiales y mano de obra
      public List getRubrosConSubrubros() throws Exception
      {
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

                listaMat.add(mat);
            }
            return listaMat;
	} 
      
        /*metodo que busca la mano de obra para un id de rubro*/ 
         public List getMOEnRubro(String idRubro) throws Exception{
            List listaMO = new ArrayList();
            ResultSet resultado = EjecutarQuery("select mr.idManoDeObra, mr.coefStdMo , m.descManoDeObra, m.idUnidadMedida, m.precioMo from manodeobrarubro mr inner join  manodeobra m on mr.idManoDeObra = m.idManoDeObra where idrubro = " + idRubro );
            while (resultado.next()){
                ManoDeObra mo = new ManoDeObra();
                mo.setIdManoDeObra(resultado.getString(1));
                mo.setCoefStdMO(resultado.getFloat(2));
                mo.setDescManoDeObra(resultado.getString(3));
                mo.setIdUnidadMedida(resultado.getString(4));
                mo.setPrecioMo(resultado.getFloat(5));

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
          public Rubro getRubro(String idRubro) throws Exception
    {
        Rubro r = new Rubro();
        ResultSet resultado = EjecutarQuery("SELECT idRubro, descRubro, idUnidadMedida FROM rubros WHERE idRubro = " + idRubro);

        while (resultado.next())
        {
            r.setIdRubro(idRubro);
            r.setDescRubro(resultado.getString(2));
            r.setIdUnidadMedida(resultado.getString(3));
            r.setSubrubros(new ArrayList()); //ojo q esto borra la lista de rubr
            r.setMateriales(getMaterialesEnRubro(idRubro));
            r.setManoDeObra(getMOEnRubro(idRubro));
        }
        resultado.close();
        return r;
    }
          
          
 public boolean saveALLRub(Rubro r){ 
        boolean rta = false;
        boolean rta1,rta2,rta3 ;
        boolean flag = true;
	String idPadre;
	if ((r.getIdRubro().length()) == 3)
        { idPadre = null;}
        else
        { idPadre = r.getIdRubro().substring(3) ;}

        //estoy suponiendo q rubro viene con el idRubro q se le asigno segun su posic en la jerarq 
        rta1 = EjecutarNonQuery("insert into rubros (idRubro, descRubro, idRubroPadre, idUnidadMedida)  VALUES ( '" + r.getIdRubro()  + "' , '" + r.getDescRubro() + "' , '" + idPadre + "' , '" + r.getIdUnidadMedida()  +   "' )");
        
                Iterator itMat = r.getMateriales().iterator();
                while(itMat.hasNext())
                {
                    Material  ma = (Material)itMat.next();
                    rta2 = EjecutarNonQuery("insert into materialesrubro (idRubro, idMaterial, coefStdMat)  VALUES ( '" +  r.getIdRubro()  + "' , '" + ma.getIdMaterial()  + "' , " +ma.getCoefStdMat() +   " )");
                    if(rta2 && rta1)
                    {
                         rta = commit();
                         flag = false;
                     }
                     if(!(rta2 && rta1))
                     {
                         rollback();
                     }    
                 }
                Iterator itMo = r.getManoDeObra().iterator();
                while(itMo.hasNext())
                {
                 ManoDeObra  mo = (ManoDeObra)itMo.next();    
                 rta3 = EjecutarNonQuery("insert into manodeobrarubro (idRubro, idManoDeObra, coefStdMo)  VALUES ( '" +  r.getIdRubro()  + "' , '" + mo.getIdManoDeObra()  + "' , " +mo.getCoefStdMO() +   " )");
                    if(rta3 && rta1)
                    {
                        rta = commit();
                         flag = false;
                    }
                    if(!(rta3 && rta1))
                    {
                        rollback();
                    }
                }
   
            if(rta1 && flag)
            {
                 rta = commit();
             }
            if(!(rta1 && flag))
            {
                rollback();
            }
        closeCon();
        return rta;
    }
}
