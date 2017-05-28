<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
var link;
window.onload=function(){
document.getElementById("cenImg").onclick=function(){
if(link){
location.href = link;
}
}
};
function ch(aa,bb){
document.getElementById("cenImg").src = aa;
link = bb;
};
</script>

</head>
<body>

<img src="localOff.JPG" width="500" id="cenImg" /> <br> <br>

<img src="GrobalOff.JPG" style="cursor:pointer; width:200px;" onclick="ch('GrobalOff.JPG','aaa.html');" />
<img src="grobalOn.JPG" style="cursor:pointer; width:200px;" onclick="ch(grobalOn.JPG,'bbb.html');" />

</body>
</html>
