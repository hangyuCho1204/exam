<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html><head><title>�ִϸ�Ŭ��</title>
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
    font-family:����ü;
    display:none;
}
</style>
<script type="text/javascript">
<!--
String.prototype.format = function() {             // �������亯ȯ 3�ڸ� ���� ',' �߰�
	if(isNaN(this)) return this;
	var reg = /(^[+-]?\d+)(\d{3})/;                // ���Խ�����
	this.rep = this + '';                          // ���ڷ� ��ȯ
	while (reg.test(this.rep)) this.rep = this.rep.replace(reg, '$1' + ',' + '$2');
	return this.rep;
}
Number.prototype.format = function() {             // �������亯ȯ 3�ڸ� ���� ',' �߰�
	if(isNaN(this)) return this;
	return (this + '').format();
}
Number.prototype.to2 = function(){                 // ���� 2�ڸ� ����
    return this<10?'0'+this:this;
}
Number.prototype.to3 = function(){                 // ���� 3�ڸ� ����
    return this<10?'00'+this:(this<100?'0'+this:this);
}
Date.prototype.get = function(){                   // ��¥ �� ���� [�и��ʱ���]
    return this.getFullYear() + '-'
         + (this.getMonth()+1).to2() + '-'
         + this.getDate().to2()
         + ' '
         + this.getHours().to2() + ':'
         + this.getMinutes().to2() + ':'
         + this.getSeconds().to2() + '.'
         + this.getMilliseconds().to3();
}
function log(str){                               // ������
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

var si=0;    // ���� ��ġ ���� ����
var sj=0;    // 
var maxi=9;  // ���� ����
var maxj=19;  // ���� ����
var count=0; // 3���̻� ��ġ Ƚ��
var matchCell = []; // ���� ��� �迭
var DEBUG = false;
var DELETING = true;

function reSet(f){
    si=0;    // ���� ��ġ ���� ����
    sj=0;    // 
    //maxi=9;  // ���� ����
    //maxj=19;  // ���� ����
    count=0; // 3���̻� ��ġ Ƚ��
    matchCell = []; // ���� ��� �迭
    f=f||false;
    if(f){
        draw();
        document.getElementById("score").innerHTML=count.format();
    }
}

function obj(i,j){  // i,j ��ġ ��ü ã��
 return document.getElementById("h"+i+'$'+j);
}

function imgn(i,j){ // i,j ��ġ �̹��� ��ȣ ����
 var imgsrc = obj(i,j).src;
 return imgsrc.substr(imgsrc.length-5,1);
}

// i,j ��ġ �̹����� Ÿ�� ����
function imgtype(i,j){
 var imgsrc = obj(i,j).src;
 return imgsrc.substr(imgsrc.length-6,1);
}

// ������ 3���̻� ���� �̹��� ã��
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

// ������ 3���̻� ���� �̹��� ã��
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

// ��ü(?) ���ٿ� 3���̻� �������� �ִ��� ã��
function checkMatch(starti,startj){
 starti=starti||1;
 startj=startj||1;
 for(var i=starti; i<maxi; i++) if(checkRow(i)) break;
 for(var j=startj; j<maxj; j++) if(checkColumn(j)) break;

 if(matchCell.length){
  log('matchCell:'+matchCell.toString());
  for(var i in matchCell){ // ���� ��� �̹��� ����
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

// ���� �̹��� ����
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

// ���� �̹����� �ִ°�� ���� ����
function deleteMatch(){
 // �������� ������ �Ϻ� ���� ���� �ʴ� ���� �߻���.
 // j ��ǥ ���� ����
 matchCell.sort(function(a,b){
     return (a[1]<b[1]) ? -1 : ((a[1]>b[1])?1:0);
 });
 // i ��ǥ ���� ����
 matchCell.sort(function(a,b){
     return (a[0]<b[0]) ? -1 : ((a[0]>b[0])?1:0);
 });
 for(var i in matchCell) deleteCell(matchCell[i][0],matchCell[i][1]);
 matchCell.length=0;
}

// ù���ð� �ι�° ������ ������ ��� ��ȯ ����
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

// ȭ�� �ٽ� �׸���
function fRandom(){
    location.reload();
}

// ��Ʈ [���� ������� ����]
function hint(obj,r){
    if(r==1) obj.innerHTML = 'hint';
    else     obj.innerHTML = '���� �̸� ����� ���� ���'
}

// ȭ��Ŭ�� ó��
// Ŭ���Ѱ��� �̹��� �̸� ��ȯ���� ����
document.onclick = function(e){
    e = e||window.event;
    var isIE = /*@cc_on!@*/false;
    var obj = isIE ? e.srcElement:e.target;
    if(obj.tagName == 'IMG'){
        var d = obj.getAttribute('id').match(/\d+/g);
        exchange(d[0],d[1]);
    }
}

// ���� �̹��� �׸�
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
// ���콺 �巡�� ���� ����
//*******************************************************************************
    var x=0, y=0;         // �̵��� ���̾� ��ġ
    var objDoc;           // ���콺 �̵��� �̵��Ǵ� ���̾� ���� ����
    var objIE = document.all;
    var objOtherBrowsers = document.getElementById && !document.all;
    var blIsDrag = false; // �����ӼӼ� [true:�̵���,false:���̵�]
	var moveKey = 'IMG'; // ��� ������Ʈ ã�� Ű
	var moveDIV = null;   // ���̾� ��Ÿ�� �������� ����
    var intTopY;
    var intTopX;
    var ��ǥ;
	document.onmousemove = function (e){ // ���콺 �̵� �̺�Ʈ ó��
      if (blIsDrag&&!DELETING){
        objDoc.style.top  = objOtherBrowsers ? intTopY + e.clientY - y : intTopY + event.clientY - y;
        objDoc.style.left = objOtherBrowsers ? intTopX + e.clientX - x : intTopX + event.clientX - x;
        return false;
      }
    }
    document.onmousedown = function (e){ // ���콺 ��ư ���������� �̺�Ʈ ó��
		if(blIsDrag) return false; // �巡�� ����
//        alert(DELETING)
        window.defaultStatus = 'DELETING['+DELETING+']';
        if(DELETING) return false; // ���� �̹��� ������
        document.onclick(e);

		// �̺�Ʈ�� �߻��� TD �ױ� ã��
		var objF = objOtherBrowsers ? e.target : event.srcElement;
		var strTopElement = objOtherBrowsers ? "HTML" : "BODY";

		// ���(����) ������Ʈ ã��
		while (objF.tagName != strTopElement && objF.tagName != moveKey)
			objF = objOtherBrowsers ? objF.parentNode : objF.parentElement;

		// ��� ������Ʈ�̸� ����
		if (objF.tagName == moveKey){
			blIsDrag = true;
			var p = getOffset(objF);  // Ŭ���� ���� ��ġ ���� ����
			// �̵��� ���̾� ����
			moveDIV.style.left    = p.left;
			moveDIV.style.top     = p.top;
			moveDIV.style.display = '';
			$('mmImg').src = objF.src;
            ��ǥ = objF.getAttribute('id').match(/\d+/g);
			// ������ ������ ���̾� ����
			objDoc = moveDIV;
			// ù ���� ��ġ ����
			y = objOtherBrowsers ? e.clientY : event.clientY;
			//intTopY = y+1; // �̵��� Ŀ������Ʈ���� 1�ȼ� ����
			intTopY = y-42; // �̵��� Ŀ������Ʈ���� 1�ȼ� ����
			// ù ���� ��ġ ����
			x = objOtherBrowsers ? e.clientX : event.clientX;
			//intTopX = x+1; // �̵��� Ŀ������Ʈ���� 1�ȼ� ����
			intTopX = x-42; // �̵��� Ŀ������Ʈ���� 1�ȼ� ����

		    return false;
		}
        return true;
    }
    document.onmouseup = function(e){ // ���콺 ��ư���� �հ����� ������ �̺�Ʈ ó��
		try{
			// ������ �Ӽ��� �ִ°�� ����
			if(blIsDrag){
				blIsDrag = false;
				moveDIV.style.display = 'none';
				// �̺�Ʈ�� �߻��� TD �ױ� ã��
				var objF = objOtherBrowsers ? e.target : event.srcElement;
				var strTopElement = objOtherBrowsers ? "HTML" : "BODY";

				// ���(����) ������Ʈ ã��
				while (objF.tagName != strTopElement && objF.tagName != moveKey)
					objF = objOtherBrowsers ? objF.parentNode : objF.parentElement;

                si=0;
                exchange(��ǥ[0],��ǥ[1]);
                ��ǥ = objF.getAttribute('id').match(/\d+/g);
                exchange(��ǥ[0],��ǥ[1]);
			}
		}catch(e){
//			alert(e);
		}
	}
//*******************************************************************************
// ���콺 �巡�� ���� ��
//*******************************************************************************

	/**
	 * ���
	 *   ��ä�� ȭ��� ���� ��ġ ����
	 * param
	 *   oNode : Offset ��ġ ã�� ���(�ʼ�)
	 *   pNode : Offset ��ġ ������ �ֻ��� ���(��������)
	 * return
	 *   ��ü�� left,top �� ��ġ��
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


// ȭ�� ������ ���� �� ��°��� �� ���
var beforeSize = [0,0];
window.onresize = function(){
 if(beforeSize[0] == document.body.clientHeight 
  && beforeSize[1] == document.body.clientWidth) return;
 beforeSize[0] = document.body.clientHeight;
 beforeSize[1] = document.body.clientWidth;
 maxCount();
 if(confirm('ȭ���� �ٽ� �׸��ڽ��ϱ�?')) draw();
}

// ������ �ε� �� ���� �̹��� �׸�
window.onload = function(){
 maxCount();
 // ���� ����
 var ni = document.getElementById('ni');
 for(var i=5; i<=maxi; i++) ni.options.add(new Option(i,i));
 ni.value = maxi;
 ni.onchange = function(){
  maxi = this.value;
  reSet(1);
 };

 // ���� ����
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
  <td width='*'><b> <center> �ִϸ�Ŭ�� </center></b> </td>
  <td align='right' style='font-size:9pt;'><strike>���ѽð�:60��</strike></td>
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
   ���ΰ��� : <select id="nj"></select>
   ���ΰ��� : <select id="ni"></select>
   <input type="button" value="Debug" onclick="toggleDebug()">
  </td>
 </tr>
</table>
<!-- ������ ���̾� -->
<div id="mmDiv" style="position:absolute;border:0px red solid;display:none;width:40px;height:40px;">
<img id='mmImg' src=''></div>

<div id='debug'></div>
</body></html>