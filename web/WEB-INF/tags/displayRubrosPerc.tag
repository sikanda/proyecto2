<%@tag description="recursive call to print tree" pageEncoding="UTF-8"%>
 <%@ taglib tagdir="/WEB-INF/tags" prefix="myTags2" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@ attribute name="rub" required="true" type="Entidades.Rubro" %>

<%-- any content can be specified here e.g.: --%>    
<tr>
<td><c:out value= "${rub.descRubro}" /></td>                   <%-- descripcion --%>    
<td><c:out value=  "${rub.cantPresRub}"/></td>                 <%-- cantidad --%>    
<td class= "unit"><c:out value= "${rub.idUnidadMedida}"/></td> <%-- unidad medida --%> 
<td><c:out value= "${rub.idRubro}" /></td>                     <%-- idRubro --%> 
<td></td>                                                      <%-- precio --%>  
<td></td>                                                      <%-- total currency --%>  
<td class ="percent"></td>                                      <%-- total number --%>  
</tr>

<c:forEach items="${rub.subrubros}" var="srub"> <%-- itero en los hijos --%> 
    <myTags2:displayRubrosPerc rub="${srub}"/>       
</c:forEach>


  