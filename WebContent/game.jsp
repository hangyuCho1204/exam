<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html><head><title>애니멀클럽</title>
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no" />
<style>
img{
    width : 40px;
    height : 40px;
    border:1px solid white
}
img.check{
    border:1px solid blue;
}
span{
    border:1px solid white;
}
span#score{
    border:0px;
    font-size:9pt;
}
span#hint{
    display:none;
}
div#debug{
    position:absolute;
    left:0px;
    top:0px;
    border:1px blue dotted;
    width:30%;
    font-size:9pt;
    font-family:굴림체;
    display:none;
}
</style>
<script type="text/javascript">
<!--
String.prototype.format = function() {             // 숫차포멧변환 3자리 마다 ',' 추가
	if(isNaN(this)) return this;
	var reg = /(^[+-]?\d+)(\d{3})/;                // 정규식정의
	this.rep = this + '';                          // 문자로 변환
	while (reg.test(this.rep)) this.rep = this.rep.replace(reg, '$1' + ',' + '$2');
	return this.rep;
}
Number.prototype.format = function() {             // 숫자포멧변환 3자리 마다 ',' 추가
	if(isNaN(this)) return this;
	return (this + '').format();
}
Number.prototype.to2 = function(){                 // 숫자 2자리 고정
    return this<10?'0'+this:this;
}
Number.prototype.to3 = function(){                 // 숫자 3자리 고정
    return this<10?'00'+this:(this<100?'0'+this:this);
}
Date.prototype.get = function(){                   // 날짜 값 추출 [밀리초까지]
    return this.getFullYear() + '-'
         + (this.getMonth()+1).to2() + '-'
         + this.getDate().to2()
         + ' '
         + this.getHours().to2() + ':'
         + this.getMinutes().to2() + ':'
         + this.getSeconds().to2() + '.'
         + this.getMilliseconds().to3();
}
function log(str){                               // 디버깅용
//    var s = (new Date()).toString() + '\n'
    if(!DEBUG) return;
    var s = '[' + (new Date()).get() + ']\n'
          + str;
    document.getElementById('debug').innerText = s + '\n' + document.getElementById('debug').innerText.substring(0,1000);
}
function toggleDebug(){
    //var debug = document.getElementById('debug')
    debug.innerHTML = '';
    debug.innerText = '';
    if( DEBUG ) {
        DEBUG = false;
        debug.style.display = 'none';
    } else {
        DEBUG = true;
        debug.style.display = 'block';
    }
}
//-->
</script>
<script type="text/javascript">

var si=0;    // 이전 위치 저장 버퍼
var sj=0;    // 
var maxi=9;  // 세로 개수
var maxj=19;  // 가로 개수
var count=0; // 3개이상 매치 횟수
var matchCell = []; // 삭제 대상 배열
var DEBUG = false;
var DELETING = true;

function reSet(f){
    si=0;    // 이전 위치 저장 버퍼
    sj=0;    // 
    //maxi=9;  // 세로 개수
    //maxj=19;  // 가로 개수
    count=0; // 3개이상 매치 횟수
    matchCell = []; // 삭제 대상 배열
    f=f||false;
    if(f){
        draw();
        document.getElementById("score").innerHTML=count.format();
    }
}

function obj(i,j){  // i,j 위치 개체 찾기
 return document.getElementById("h"+i+'$'+j);
}

function imgn(i,j){ // i,j 위치 이미지 번호 추출
 var imgsrc = obj(i,j).src;
 return imgsrc.substr(imgsrc.length-5,1);
}

// i,j 위치 이미지의 타입 추출
function imgtype(i,j){
 var imgsrc = obj(i,j).src;
 return imgsrc.substr(imgsrc.length-6,1);
}

// 세로줄 3개이상 같은 이미지 찾기
function checkRow(i){
 var r=true;
 for(var k=1; k<(maxj-2); k++){
  if( imgn(i,k)!=imgn(i,k+1) ) continue;
  if( imgn(i,k)!=imgn(i,k+2) ) {k++;continue;}
  matchCell.push([i,k  ]);
  matchCell.push([i,k+1]);
  matchCell.push([i,k+2]);
  r=false;
 }
}

// 가로줄 3개이상 같은 이미지 찾기
function checkColumn(j){ 
 var r=true;
 for(var k=1; k<(maxi-2); k++){
  if( imgn(k,j)!=imgn(k+1,j) ) continue;
  if( imgn(k,j)!=imgn(k+2,j) ) {k++;continue;}
  matchCell.push([k  ,j]);
  matchCell.push([k+1,j]);
  matchCell.push([k+2,j]);
  r=false;
 }
}

// 전체(?) 한줄에 3개이상 같은것이 있는지 찾음
function checkMatch(starti,startj){
 starti=starti||1;
 startj=startj||1;
 for(var i=starti; i<maxi; i++) if(checkRow(i)) break;
 for(var j=startj; j<maxj; j++) if(checkColumn(j)) break;

 if(matchCell.length){
  log('matchCell:'+matchCell.toString());
  for(var i in matchCell){ // 삭제 대상 이미지 변경
   obj(matchCell[i][0],matchCell[i][1]).src = "s"+imgn(matchCell[i][0],matchCell[i][1])+".JPG";
  }
  setTimeout(function(){
   deleteMatch();
   checkMatch(1,1);
  },333);
  //},500);
  DELETING=true;
//  blIsDrag=true;
 }else{
//  timer=null;
  DELETING=false;
//  blIsDrag=false;
 }

}

// 같은 이미지 삭제
function deleteCell(i,j){
 log('i['+i+'],j['+j+']');
 if(imgtype(i,j)=="x") return;
 for(var k=i; k>1; k--) obj(k,j).src=obj(k-1,j).src;
// var r = Math.floor(Math.random()*6)+1;
 var r = ((Math.floor(Math.random()*10)%6)+1);
 obj(1,j).src="x"+r+".JPG";
 count=count+300;
 document.getElementById("score").innerHTML=count.format();
}

// 같은 이미지가 있는경우 삭제 수행
function deleteMatch(){
 // 정렬하지 않으면 일부 삭제 되지 않는 현상 발생함.
 // j 좌표 기준 정렬
 matchCell.sort(function(a,b){
     return (a[1]<b[1]) ? -1 : ((a[1]>b[1])?1:0);
 });
 // i 좌표 기준 정렬
 matchCell.sort(function(a,b){
     return (a[0]<b[0]) ? -1 : ((a[0]>b[0])?1:0);
 });
 for(var i in matchCell) deleteCell(matchCell[i][0],matchCell[i][1]);
 matchCell.length=0;
}

// 첫선택과 두번째 선택이 인접한 경우 교환 수행
function exchange(i,j){
 if(si==0){
  si=i;
  sj=j;
  obj(si,sj).style.border = "1px solid red";
  return;
 }
 log('-------------------------------------------');
 obj(si,sj).style.border="1px solid white";
 if(Math.abs(si-i)+Math.abs(sj-j)==1){
  var imgsrc= obj(i,j).src;
  obj(i,j).src= obj(si,sj).src;
  obj(si,sj).src=imgsrc;
 }
 var mi = Math.min(si,i) -2;
 var mj = Math.min(sj,j) -2;
 if(mi<1) mi=1;
 if(mj<1) mj=1;
 checkMatch(mi,mj);
 si=0;
}

// 화면 다시 그리기
function fRandom(){
    location.reload();
}

// 힌트 [현재 사용하지 않음]
function hint(obj,r){
    if(r==1) obj.innerHTML = 'hint';
    else     obj.innerHTML = '제가 미리 적어둔 게임 방법'
}

// 화면클릭 처리
// 클릭한곳이 이미지 이면 교환절차 수행
document.onclick = function(e){
    e = e||window.event;
    var isIE = /*@cc_on!@*/false;
    var obj = isIE ? e.srcElement:e.target;
    if(obj.tagName == 'IMG'){
        var d = obj.getAttribute('id').match(/\d+/g);
        exchange(d[0],d[1]);
    }
}

// 게임 이미지 그림
function draw(){
 var html = '';
 for(var i=1; i<maxi; i++){
  for(var j=1; j<maxj; j++){
//   var r= Math.floor(Math.random()*6)+1;
//   html += "<img src=x"+r+".JPG id ='h"+i+j+"'>";
   var r = ((Math.floor(Math.random()*10)%6)+1);
   html += "<img src=x"+r+".JPG id ='h"+i+'$'+j+"'>";
  }
  html += "<br/>";
 }
 drawArea.innerHTML = html;
 checkMatch();
}

function maxCount(){
 maxi = Math.floor( (document.body.clientHeight-70) / (40+2) );
 maxj = Math.floor( (document.body.clientWidth-5) / (40+2) );
}

//-------------------------------------------------------------------------------
// Element
//-------------------------------------------------------------------------------
function $(n){return document.getElementById(n)||'';}

document.onmouseover = function(e){
    e = e||window.event;
    var isIE = /*@cc_on!@*/false;
    var obj = isIE ? e.srcElement:e.target;
    if(obj.tagName == 'IMG'){
        obj.style.border = "1px solid black";
    }
}
document.onmouseout = function(e){
    e = e||window.event;
    var isIE = /*@cc_on!@*/false;
    var obj = isIE ? e.srcElement:e.target;
    if(obj.tagName == 'IMG'){
        obj.style.border = "1px solid white";
    }
}
//*******************************************************************************
// 마우스 드래그 관련 시작
//*******************************************************************************
    var x=0, y=0;         // 이동전 레이어 위치
    var objDoc;           // 마우스 이동시 이동되는 레이어 담을 변수
    var objIE = document.all;
    var objOtherBrowsers = document.getElementById && !document.all;
    var blIsDrag = false; // 움직임속성 [true:이동중,false:무이동]
	var moveKey = 'IMG'; // 대상 엘리먼트 찾는 키
	var moveDIV = null;   // 레이어 스타일 적용위한 변수
    var intTopY;
    var intTopX;
    var 좌표;
	document.onmousemove = function (e){ // 마우스 이동 이벤트 처리
      if (blIsDrag&&!DELETING){
        objDoc.style.top  = objOtherBrowsers ? intTopY + e.clientY - y : intTopY + event.clientY - y;
        objDoc.style.left = objOtherBrowsers ? intTopX + e.clientX - x : intTopX + event.clientX - x;
        return false;
      }
    }
    document.onmousedown = function (e){ // 마우스 버튼 눌려졌을때 이벤트 처리
		if(blIsDrag) return false; // 드래그 상태
//        alert(DELETING)
        window.defaultStatus = 'DELETING['+DELETING+']';
        if(DELETING) return false; // 같은 이미지 삭제중
        document.onclick(e);

		// 이벤트가 발생한 TD 테그 찾음
		var objF = objOtherBrowsers ? e.target : event.srcElement;
		var strTopElement = objOtherBrowsers ? "HTML" : "BODY";

		// 대상(순서) 엘리먼트 찾음
		while (objF.tagName != strTopElement && objF.tagName != moveKey)
			objF = objOtherBrowsers ? objF.parentNode : objF.parentElement;

		// 대상 엘리먼트이면 수행
		if (objF.tagName == moveKey){
			blIsDrag = true;
			var p = getOffset(objF);  // 클릭된 셀의 위치 정보 추출
			// 이동될 레이어 설정
			moveDIV.style.left    = p.left;
			moveDIV.style.top     = p.top;
			moveDIV.style.display = '';
			$('mmImg').src = objF.src;
            좌표 = objF.getAttribute('id').match(/\d+/g);
			// 움직일 변수에 레이어 저장
			objDoc = moveDIV;
			// 첫 세로 위치 지정
			y = objOtherBrowsers ? e.clientY : event.clientY;
			//intTopY = y+1; // 이동시 커서포인트보다 1픽셀 내림
			intTopY = y-42; // 이동시 커서포인트보다 1픽셀 내림
			// 첫 가로 위치 지정
			x = objOtherBrowsers ? e.clientX : event.clientX;
			//intTopX = x+1; // 이동시 커서포인트보다 1픽셀 내림
			intTopX = x-42; // 이동시 커서포인트보다 1픽셀 내림

		    return false;
		}
        return true;
    }
    document.onmouseup = function(e){ // 마우스 버튼에서 손가락을 뗬을때 이벤트 처리
		try{
			// 움직임 속성이 있는경우 수행
			if(blIsDrag){
				blIsDrag = false;
				moveDIV.style.display = 'none';
				// 이벤트가 발생한 TD 테그 찾음
				var objF = objOtherBrowsers ? e.target : event.srcElement;
				var strTopElement = objOtherBrowsers ? "HTML" : "BODY";

				// 대상(순서) 엘리먼트 찾음
				while (objF.tagName != strTopElement && objF.tagName != moveKey)
					objF = objOtherBrowsers ? objF.parentNode : objF.parentElement;

                si=0;
                exchange(좌표[0],좌표[1]);
                좌표 = objF.getAttribute('id').match(/\d+/g);
                exchange(좌표[0],좌표[1]);
			}
		}catch(e){
//			alert(e);
		}
	}
//*******************************************************************************
// 마우스 드래그 관련 끝
//*******************************************************************************

	/**
	 * 기능
	 *   개채의 화면상 절대 위치 추출
	 * param
	 *   oNode : Offset 위치 찾을 노드(필수)
	 *   pNode : Offset 위치 추적시 최상위 노드(생략가능)
	 * return
	 *   개체의 left,top 의 위치값
	 */
	function getOffset(oNode, pNode){
		var offset = {'left':0,'top':0};
		pNode = pNode||document.body;
		var oCurrentNode = oNode;
		while( ((oCurrentNode)&&(oCurrentNode!=pNode)) ){
			offset.left += oCurrentNode.offsetLeft - oCurrentNode.scrollLeft;
			offset.top += oCurrentNode.offsetTop - oCurrentNode.scrollTop;
			oCurrentNode = oCurrentNode.offsetParent;
		}
		if(pNode == document.body){
			if(document.documentElement.scrollTop ) offset.top  += document.documentElement.scrollTop;
			if(document.documentElement.scrollLeft) offset.left += document.documentElement.scrollLeft;
		}

		return offset;
	}


// 화면 사이즈 변경 시 출력개수 재 계산
var beforeSize = [0,0];
window.onresize = function(){
 if(beforeSize[0] == document.body.clientHeight 
  && beforeSize[1] == document.body.clientWidth) return;
 beforeSize[0] = document.body.clientHeight;
 beforeSize[1] = document.body.clientWidth;
 maxCount();
 if(confirm('화면을 다시 그리겠습니까?')) draw();
}

// 페이지 로딩 후 게임 이미지 그림
window.onload = function(){
 maxCount();
 // 세로 개수
 var ni = document.getElementById('ni');
 for(var i=5; i<=maxi; i++) ni.options.add(new Option(i,i));
 ni.value = maxi;
 ni.onchange = function(){
  maxi = this.value;
  reSet(1);
 };

 // 가로 개수
 var nj = document.getElementById('nj');
 for(var j=5; j<=maxj; j++) nj.options.add(new Option(j,j));
 nj.value = maxj;
 nj.onchange = function(){
  maxj = this.value;
  reSet(1);
 };

 draw();

 moveDIV = $('mmDiv');
 //alert(document.getElementsByTagName('IMG').length)
}
</script>
</head>
<body>
<table align=center border=1>
<tr><td><table border=0 width="100%">
 <tr>
  <td><input type="button" value="Reset" onclick="reSet(1)"><input type="button" value="ReDraw" onclick="draw()"></td>
  <td width='*'><b> <center> 애니멀클럽 </center></b> </td>
  <td align='right' style='font-size:9pt;'><strike>제한시간:60초</strike></td>
 </tr></table></td></tr>
 <tr>
  <td>
   <span id="score">0</span>
   <span id='hint' onmouseover='hint(this,2)' onmouseout='hint(this,1)'>hint</span>
  </td>
 </tr>
 <tr><td id='drawArea'></td></tr>
</table>
<table align=center border>
 <tr>
  <td>
   가로개수 : <select id="nj"></select>
   세로개수 : <select id="ni"></select>
   <input type="button" value="Debug" onclick="toggleDebug()">
  </td>
 </tr>
</table>
<!-- 모듈관리 레이어 -->
<div id="mmDiv" style="position:absolute;border:0px red solid;display:none;width:40px;height:40px;">
<img id='mmImg' src=''></div>

<div id='debug'></div>
</body></html>