package Datos;

import Entidades.UnidadMedida;
import java.sql.ResultSet;
import java.util.*;


public class UnidadMedidaDB extends AccesoDatos {

public UnidadMedidaDB() throws Exception{}


    public List getUnidadesDeMedida() throws Exception{
      List listaUm = new ArrayList();
      ResultSet resultado = EjecutarQuery("SELECT  idUnidadMedida, descUnidadMedida FROM unidadesmedida order by descUnidadMedida");
      while (resultado.next()){
          UnidadMedida um = new UnidadMedida();
          um.setIdUnidadMedida(resultado.getString(1));
          um.setDescUnidadMedida(resultado.getString(2));

          listaUm.add(um);
      }
      closeCon();
      return listaUm;
  }  
}
