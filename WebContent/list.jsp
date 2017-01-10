<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>Insert title here</title>
</head>
<body>
	<%
		Connection con;
		PreparedStatement pstmt;
		ResultSet rs;

		Class.forName("oracle.jdbc.driver.OracleDriver");

		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String uid = "hr";
		String upw = "hr";
		con = DriverManager.getConnection(url, uid, upw);

		String sql = "select count(*) from mvc_board";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();

		int totalCount = 0;

		
		if(rs.next()){
			totalCount = rs.getInt(1); // ��ü �Խù��� ���ڸ� �˷��ش�.
			// System.out.println(Integer.toString(result));
		}

		int countList = 5;

		int totalPage = totalCount / countList;

		
		if (totalCount % countList > 0) {

			totalPage++; //10

		}
	
		
		int pageNum;
		
		pageNum=1;
		
		if(request.getParameter("page")!=null){
			pageNum= Integer.parseInt(request.getParameter("page"));
		}
		
		System.out.println("������ Ŭ�� ������ pageNum���� ���� :" +Integer.toString(pageNum));
		
		int countPage = 5;
		
		
		
		int startPage = ((pageNum) -1 / countPage) * countPage+1;

		int endPage = startPage + countPage - 1;
		
		
		
		
	%>



	<table width="500" cellpadding="0" cellspacing="0" border="1">

		<tr>
			<td>��ȣ</td>
			<td>�̸�</td>
			<td>����</td>
			<td>��¥</td>
			<td>��Ʈ</td>
		</tr>

		<c:forEach items="${list}" var="dto">

			<tr>
				<td>${dto.bId}</td>
				<td>${dto.bName}</td>
				<td><c:forEach begin="1" end="${dto.bIndent}">-</c:forEach> <a
					href="content_view.do?bId=${dto.bId}">${dto.bTitle}</a></td>
				<td>${dto.bDate}</td>
				<td>${dto.bHit}</td>
			</tr>

		</c:forEach>



		<tr>

			<td colspan="5"><a href="write_view.do">���ۼ�</a></td>


		</tr>

		<tr>
			<td>
				<%
					
				if (startPage > 1) {

						out.print("<a>ó��</a>");

					}

				if (endPage > totalPage) {

					endPage = totalPage;

				}

				%>
			</td>
			
			<td colspan="3" id='cli'>
				
				<%
					
					if(startPage!=1 && startPage>1){
					
					out.print("...");
					}
					
				
					if(startPage>endPage){ //�� ������ �������� ������ �� ������ ǥ���ϵ���
						
						for (int iCount = startPage-countPage; iCount <= endPage; iCount++) {
							
							
							out.print("<a href=list.do?page=" + iCount +">" + iCount + "<a>");
						
							}
						
					}	
					
					else{
						for (int iCount = startPage; iCount <= endPage; iCount++) {
							
						
							out.print("<a href=list.do?page=" + iCount +">" + iCount + "</a>");
							
							}
						
					}
					
					if(endPage<totalPage){
						
						out.print("<a href=list.do?page=" + (endPage+1) +">"+"..."+"</a>");
					}
				
				
				
				%>
			</td>
			<td>
				<%
					if (pageNum > 1) {

						out.print("<a>����</a>");

					}
				%>
			</td>


		</tr>

	</table>




</body>
</html>