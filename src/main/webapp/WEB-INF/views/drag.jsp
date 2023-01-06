<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
  $( function() {
	  
    $( "#sortable" ).sortable( {
    	stop: function(e){
    		const li = $("ul li");
    		
    		li.each(function(index){
    			const target = $(this);
    			target.find("input[name='excnOrd']").val(index+1);
    		});
    	}
    } );
    
  });
  </script>
<body>
	드래그앤드롭 테스트
	
	<table>
		<tbody id="sortable123123123213213213">
			<tr>
				<td>asd</td>
				<td>asd</td>
			</tr>
			<tr>
				<td>asd</td>
				<td>asd</td>
			</tr>
			<tr>
				<td>asd</td>
				<td>asd</td>
			</tr>
		</tbody>
	</table>
	
	<ul id="sortable">
		<li>
			<span id="PRM00000001">월마감 (최초순서1)</span>
			<input type="hidden" name="excnOrd">
			<input type="hidden" name="batPrmId" value="PRM00000001">
		</li>
		<li>
			<span id="PRM00000002">일마감 (최초순서2)</span>
			<input type="hidden" name="excnOrd">
			<input type="hidden" name="batPrmId" value="PRM00000002">
		</li>
		<li>
			<span id="PRM00000003">주마감 (최초순서3)</span>
			<input type="hidden" name="excnOrd">
			<input type="hidden" name="batPrmId" value="PRM00000003">
		</li>
	</ul>
</body>
</html>