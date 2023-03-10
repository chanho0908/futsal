<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="utilDB.DBconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="ground.GroundDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ground.LocationDTO"%>
<%@page import="ground.GroundDAO"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/ground_style.css?after">
<script type="text/javascript" src="../js/ground.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%	
		String getNo = request.getParameter("no");
		int no = Integer.parseInt(getNo);
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT imgPath from images where gno=?";
		ArrayList<String> images = new ArrayList<String>();
		
		try{
			conn = DBconnection.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
		
			while(rs.next()){
				images.add(rs.getString(1));
			}
		}catch(Exception e){
			out.println(e.getMessage());
		}
		
		String path = "";
		
		switch(getNo){
			case "1":
				path = "sBuild/"; break;
			case "2":	
				path = "HK/"; break;
			case "3":	
				path = "plab/"; break;	
			case "4":	
				path = "sky/"; break;
			case "5":	
				path = "notso/"; break;	
		}
		
		String imgPath1 = path + images.get(0);
		String imgPath2 = path + images.get(1);
		String imgPath3 = path + images.get(2);
		
		GroundDAO dao = new GroundDAO();
		LocationDTO dto = dao.getLocation(no);
		String lat = dto.getLat();
		String lng = dto.getLng();

		ArrayList<GroundDTO> gnd =  dao.getSelectf();
		
		String gname = gnd.get(0).getgName();
		
		String userID = null;
		if(userID == null){
			userID = (String) session.getAttribute("userID");
			
		}
	
		if(userID == null){ %>
		
		<div class="top-container">
			
		<div>
			<div class="join"  onclick="location.href='../user/joinForm.jsp'">?????? ??????</div>
			<div class="login" onclick="location.href='../user/loginForm.jsp'">?????????</div>
		</div>
		<%
		}else{
		%>	
		<div class="top-container">
			<div class="info" onclick="location.href='../user/userInfo.jsp'">??? ??????</div>
			<div class="logout" onclick="location.href='../user/logout.jsp'">????????????</div>
		</div>		
		<%
		}
		%>
	</div>
	<div class="image_container">
		<div class="content_slider">
			<ul class="bxslider">
			  <li><img src="../images/<%= imgPath1 %>" width="900px" height="470px;"></li>
		      <li><img src="../images/<%= imgPath2 %>" width="900px" height="470px;"></li>
		      <li><img src="../images/<%= imgPath3 %>" width="900px" height="470px;"></li>
		  	</ul>
		 </div> 	
	</div>
	<div class="left-container"> 
		<div class="left-logo"><a href="../index.jsp"> PLAY GROUND </a></div>
		<div class="mapTitle">??????</div>
		<div id="map" style="width:338px; height:300px;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2562ec27e72afca8d8642f34a62bf88e"></script>
		<script>
			var myLat = "<%=lat%>"; 
			var myLng = "<%=lng%>"; 
			
			var mapContainer = document.getElementById('map'), // ????????? ????????? div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(myLat, myLng), // ????????? ????????????
		        level: 3 // ????????? ?????? ??????
		    };
	
			var map = new kakao.maps.Map(mapContainer, mapOption); // ????????? ???????????????
		
			// ????????? ????????? ??????????????? 
			var markerPosition  = new kakao.maps.LatLng(myLat, myLng); 
		
			// ????????? ???????????????
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			marker.setMap(map);
		</script>
	</div>
	
	<%	
		GroundDTO gd  = new GroundDAO().getGround(no);
		String infoName = gd.getgName();
		int price = gd.getPrice();
		String addr = gd.getAddr();
		String cnt = gd.getUseablecnt();
		String grass = gd.getGrass();
		String size = gd.getSize();
		int parking = gd.getParking();
		int ballrent = gd.getBallrent();
		int temp = gd.getTemp();
		int shower = gd.getShower();
		int vestrent = gd.getVestrent();
		int shoese = gd.getShoeserent();
		
		String tPath = "";
		String sPath = "";
		String bPath = "";
		String vPath = "";
		String fsPath = "";
		
		if(temp == 1){
			tPath = "tempOn.svg";
		}else{ tPath = "tempOff.svg";}
		
		if(shower == 1){
			sPath = "shOn.svg";
		}else{ sPath = "shOff.svg";}
		
		if(ballrent == 1){
			bPath = "ballrentOn.svg";
		}else{ bPath = "ballrentOff.svg";}
		
		if(vestrent == 1){
			vPath = "vestrentOn.svg";
		}else{ vPath = "vestrentOff.svg";}
		
		if(shoese == 1){
			fsPath = "shoesrentOn.svg";
		}else{ fsPath = "shoesrentOff.svg";}
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		SimpleDateFormat format = new SimpleDateFormat("MM??? dd??? (E)");
		cal.add(Calendar.DATE, 30);
	%>
	
	<div class="reserve-container">
		<div class="infoName" style="margin: 0 0 0 20px">
			<h1><%= infoName %></h1>
		</div>
		<div class="addr">
		<h4><%= addr%></h4>
		</div>
		<div class="infoContaier">
			<div class="infoBodyLeft">
				<div class="sizeContainer">
					<div class="square"></div>
					<h3>????????????</h3>
					<h4>????????????: ?????????(??? ??????) ??? <%= price %>???</h4>
					<h4>????????????: <%= size %></h4>
					<h4>????????????: <%= cnt %> </h4>
					<h4>????????????: <%= grass %></h4>
				</div>
			</div>
			<div class="infoBodyRight">
				<div class="svc1"><img src="../images/service/parkingOn.svg"></div>
				<div class="svc1"><img src="../images/service/<%= tPath %>"></div>
				<div class="svc1"><img src="../images/service/<%= sPath %>"></div>
				<div class="svc2"><img src="../images/service/<%= bPath %>"></div>
				<div class="svc2"><img src="../images/service/<%= vPath %>"></div>
				<div class="svc2"><img src="../images/service/<%= fsPath %>"></div>
			</div>
		</div>
		
		<div class="timeSelectContainer">
			<div class="possibleDate">?????? ?????? ?????? : ?????? ~ <%= format.format(cal.getTime())%></div>
			<div class="timeselector">
				<div><h4 style="padding:10px 0 0 0; color:blue;">?????? ??????</h4></div>
		<form action="reserveAction.jsp">
				<select name="rdate" id="rdate">
					<option value="12??? 07???">12??? 07 (???)</option>
					<option value="12??? 08???">12??? 08 (???)</option>
					<option value="12??? 09???">12??? 09 (???)</option>
					<option value="12??? 10???">12??? 10 (???)</option>
					<option value="12??? 11???">12??? 11 (???)</option>
					<option value="12??? 12???">12??? 12 (???)</option>
					<option value="12??? 13???">12??? 13 (???)</option>
					<option value="12??? 14???">12??? 14 (???)</option>
					<option value="12??? 15???">12??? 15 (???)</option>
					<option value="12??? 16???">12??? 16 (???)</option>
					<option value="12??? 17???">12??? 17 (???)</option>
					<option value="12??? 18???">12??? 18 (???)</option>
					<option value="12??? 19???">12??? 19 (???)</option>
					<option value="12??? 20???">12??? 20 (???)</option>
					<option value="12??? 21???">12??? 21 (???)</option>
					<option value="12??? 22???">12??? 22 (???)</option>
					<option value="12??? 23???">12??? 23 (???)</option>
					<option value="12??? 24???">12??? 24 (???)</option>
					<option value="12??? 25???">12??? 25 (???)</option>
					<option value="12??? 26???">12??? 26 (???)</option>
					<option value="12??? 27???">12??? 27 (???)</option>
					<option value="12??? 28???">12??? 28 (???)</option>
					<option value="12??? 29???">12??? 29 (???)</option>
					<option value="12??? 30???">12??? 30 (???)</option>
					<option value="12??? 31???">12??? 31 (???)</option>
					<option value="1??? 01???">1??? 01 (???)</option>
					<option value="1??? 02???">1??? 02 (???)</option>
					<option value="1??? 03???">1??? 03 (???)</option>
					<option value="1??? 04???">1??? 04 (???)</option>
					<option value="1??? 05???">1??? 05 (???)</option>
					<option value="1??? 06???">1??? 06 (???)</option>
				</select> 
				<div><h4 style="padding:10px 0 0 5px; color:red;">?????? ??????</h4></div>
				<select style="margin-left: 0px" name="rtime">
					<option value="10:00 ~ 12:00">10:00 ~ 12:00</option>
					<option value="12:00 ~ 14:00">12:00 ~ 14:00</option>
					<option value="14:00 ~ 16:00">14:00 ~ 16:00</option>
					<option value="16:00 ~ 18:00">16:00 ~ 18:00</option>
					<option value="18:00 ~ 20:00">18:00 ~ 20:00</option>
					<option value="20:00 ~ 22:00">20:00 ~ 22:00</option>
				</select> 
				<input type="hidden" name="no" value="<%= no %>">
				<input type="hidden" name="infoName" value="<%= infoName %>">
				<input type="hidden" name="addr" value="<%= addr%>">
				<input type="hidden" name="price" value="<%= price%>">
			
			</div>
			<%
				if(userID == null){
			%>	<div style="margin-top: 30px; color:red; font-weight: bold">????????? ??? ????????? ????????? ????????? !</div>
			<%					
				}else{
			%>
				<input type="submit" id="showBtn" value="????????????" style="cursor: pointer;"></button>
			<%
				}
			%>
			</form>
		</div>
	</div>

	
	<%
		String selNotice = "";
		
		switch(getNo){
			case "1":
				selNotice = "sBuild_notice.jsp"; break;
			case "2":	
				selNotice = "hk_notice.jsp"; break;
			case "3":
				selNotice = "plab_notice.jsp"; break;
			case "4":	
				selNotice = "sky_notice.jsp"; break;
			case "5":	
				selNotice = "notso_notice.jsp"; break;	
		}
		
		String noticePath = "../notice/" + selNotice;
		
	%>
	
	<div class="main_notice_container">		
		<jsp:include page="<%= noticePath %>" flush="true"/>
	</div>
	
	
	<div class="rule_container">	
		<jsp:include page="payRule.jsp" flush="true"/>
	</div>
	
	
</body>
</html>