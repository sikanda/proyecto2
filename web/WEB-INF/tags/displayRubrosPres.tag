<%@tag description="recursive call to print tree" pageEncoding="UTF-8"%>
 <%@ taglib tagdir="/WEB-INF/tags" prefix="myTags1" %> 
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

<c:set var="totalPorRubro" value="${0}"/>
<c:set var="totalFinalMat" value="${0}"/>
<c:set var="totalFinalMO" value="${0}"/>

<c:forEach items="${rub.materiales}" var="mat" >
    <tr >
        <td><c:out value= "${mat.descMaterial}"/></td>             <%-- descripcion --%>         
        <td class= "edit"><c:out value= "${mat.cantPres}" /></td>  <%-- cantidad --%> 
        <td><c:out value= "${mat.idUnidadMedida}"/></td>           <%-- unidad medida --%> 
        <td class="hidRub"><c:out value= "${rub.idRubro}" /></td>  <%-- idRubro --%> 
        <td><fmt:formatNumber value="${mat.precioMa}" type="currency" /></td> <%-- precio --%> 
       <c:set var="totalRowMa" value="${mat.cantPres * mat.precioMa}"  /> 
       <td><fmt:formatNumber value="${totalRowMa}" type="currency" /></td> <%-- total linea formato currency --%> 
        <td><fmt:formatNumber value="${totalRowMa}" type="number" /></td> <%-- total linea --%> 
      <c:set var="totalFinalMat" value="${totalFinalMat + totalRowMa}"  /> <%-- total rubro --%> 
    </tr>
  </c:forEach>

<c:forEach items="${rub.manoDeObra}" var="mo">
    <tr>
        <td><c:out value= "${mo.descManoDeObra}" /></td>            <%-- descripcion --%> 
        <td class= "edit"><c:out value= "${mo.cantPres}" /></td>    <%-- cantidad --%> 
        <td><c:out value= "${mo.idUnidadMedida}" /></td>            <%-- unidad medida --%> 
        <td class="hidRub"><c:out value= "${rub.idRubro}" /></td>    <%-- idRubro --%> 
        <td><fmt:formatNumber value="${mo.precioMo}" type="currency" /></td>  <%-- precio --%> 
        <c:set var="totalRowMo" value="${mo.cantPres * mo.precioMo}"  /> 
         <td><fmt:formatNumber value="${totalRowMo}" type="currency" /></td> <%-- total linea formato currency--%> 
        <td><fmt:formatNumber value="${totalRowMo}" type="number" /></td> <%-- total linea --%> 
        <c:set var="totalFinalMO" value="${totalFinalMO + totalRowMo}"  /> <%-- total rubro --%> 
    </tr>
 </c:forEach>

<c:forEach items="${rub.subrubros}" var="srub"> <%-- itero en los hijos --%> 
    <myTags1:displayRubrosPres rub="${srub}"/>       
</c:forEach>

    <c:if test="${empty rub.subrubros}"> <%-- si no hay mas hijos imprimo el total del rubro --%> 
 <tr >
   <c:set var="totalPorRubro" value="${totalPorRubro + totalFinalMat + totalFinalMO}"></c:set> 
   <td colspan="4"> <c:out value= "Total Rubro:" /> </td>  
   <td  ><fmt:formatNumber value="${totalPorRubro}" type="currency" /> </td>     
</tr>
</c:if>

  