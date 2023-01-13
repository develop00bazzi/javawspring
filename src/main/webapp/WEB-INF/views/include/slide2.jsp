<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

 <!-- Automatic Slideshow Images -->
 <div class="mySlides w3-display-container w3-center">
   <img src="${ctp}/slideShow/stanceNation_1.jpg" style="width:100%; height: 250px;">
   <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
     <h3>Los Angeles</h3>
     <p><b>We had the best time playing at Venice Beach!</b></p>   
   </div>
 </div>
 <div class="mySlides w3-display-container w3-center">
   <img src="${ctp}/slideShow/stanceNation_2.jpg" style="width:100%; height: 250px;">
   <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
     <h3>New York</h3>
     <p><b>The atmosphere in New York is lorem ipsum.</b></p>    
   </div>
 </div>
 <div class="mySlides w3-display-container w3-center">
   <img src="${ctp}/slideShow/stanceNation_3.jpg" style="width:100%; height: 250px;">
   <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
     <h3>Chicago</h3>
     <p><b>Thank you, Chicago - A night we won't forget.</b></p>    
   </div>
 </div>
 
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>