package Datos;
import Entidades.Presupuesto;
import Entidades.Rubro;
import Entidades.ManoDeObra;
import Entidades.Material;
import java.util.Iterator;

public class PresupuestoDB extends AccesoDatos {
    
    
    public PresupuestoDB() throws Exception{}
        public int getIdPresupuesto(){
        int rta = EjecutarQueryInt("SELECT MAX(idPresupuesto) FROM presupuestos")+1;
        closeCon();
        return (rta);
           }
        
        public boolean saveALLPres(Presupuesto p){ 
        boolean rta = false;
        boolean rta1,rta2,rta3,rta4 ;
        boolean flag = true;
       // Rubro r = new Rubro();
       java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
       String fechaCreac = sdf.format(p.getFechaCreacion());
        rta1 = EjecutarNonQuery("insert into presupuestos (observaciones, idUsuario, idCliente, fechaCreacion)  VALUES ( '" + p.getObservaciones()  + "' , " + p.getUsuario().getIdUsuario() + " , " + p.getCliente().getIdCliente()  + ", '" + fechaCreac +   "' )");
        
        int idPres = EjecutarQueryInt("SELECT MAX(idPresupuesto) FROM presupuestos");
        
           Iterator itRub = p.getRubros().iterator();
           while(itRub.hasNext())
           {
                Rubro  r = (Rubro)itRub.next();
                System.out.println( r.getIdRubro()); 
                 flag = true;
                //OJO! esto sirve para rubros hoja... no puede venir con los padres, sino hay q iterar en profundidad tb
                rta4 = EjecutarNonQuery("INSERT INTO rubrospresupuesto (idPresupuesto,idRubro,cantPresRub) VALUES (  " + idPres + " , '" + r.getIdRubro() +  "' , " +r.getCantPresRub() + " )");
                Iterator itMat = r.getMateriales().iterator();
                while(itMat.hasNext())
                {
                    Material  ma = (Material)itMat.next();
                    rta2 = EjecutarNonQuery("INSERT INTO materialespresupuesto (idPresupuesto,idRubro,idMaterial,cantPresMat)  VALUES ( " + idPres + " , '" + r.getIdRubro() + "' , '" + ma.getIdMaterial()  + "' , " +ma.getCantPres() +   " )");
                    if(rta2 && rta4 && rta1)
                    {
                         rta = commit();
                         flag = false;
                         // System.out.println("commit ma");
                     }
                     if(!(rta2 && rta4 && rta1))
                     {
                         rollback();
                     }    
                 }
                Iterator itMo = r.getManoDeObra().iterator();
                while(itMo.hasNext())
                {
                 ManoDeObra  mo = (ManoDeObra)itMo.next();    
                 rta3 = EjecutarNonQuery("INSERT INTO manodeobrapresupuesto (idPresupuesto,idRubro,idManoDeObra,cantPresMO)  VALUES ( " + idPres + " , '" + r.getIdRubro() + "' , '" + mo.getIdManoDeObra()  + "' , " +mo.getCantPres() +   " )");
                    if(rta3 && rta4 && rta1)
                    {
                        rta = commit();
                         flag = false;
                        // System.out.println("commit mo");
                    }
                    if(!(rta3 && rta4 && rta1))
                    {
                        rollback();
                    }
                }
           }    
            if(rta1 && flag)
            {
                 rta = commit();
                 //System.out.println("commit rta y flag");
             }
            if(!(rta1 && flag))
            {
                rollback();
            }
        closeCon();
        return rta;
    }
        
}
