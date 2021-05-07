<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>   
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<fmt:requestEncoding value="UTF-8" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >

<!-- Plugin css -->
<link href='${path}/a00_com/lib/main.css' rel='stylesheet' />
<link href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet' />
<link href='https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.13.1/css/all.css' rel='stylesheet'>
	
<!-- App favicon -->
<link rel="shortcut icon" href="${path }/a00_com/assets/images/favicon.ico">
<!-- App css -->
<link href="${path }/Admin/dist/assets/css/modern/bootstrap-modern.min.css" rel="stylesheet" type="text/css" id="bs-default-stylesheet" />
<link href="${path }/Admin/dist/assets/css/modern/app-modern.min.css" rel="stylesheet" type="text/css" id="app-default-stylesheet" />
<link href="${path }/Admin/dist/assets/css/modern/bootstrap-modern-dark.min.css" rel="stylesheet" type="text/css" id="bs-dark-stylesheet" />
<link href="${path }/Admin/dist/assets/css/modern/app-modern-dark.min.css" rel="stylesheet" type="text/css" id="app-dark-stylesheet" />
<!-- icons -->

<script src='${path}/a00_com/lib/main.js'></script>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>

<link href="${path}/Admin/dist/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css?v=5.2.0">
      
<script type="text/javascript">
<%--
 
 
--%>
var date = {};
var all;
var title;
var holder;
var parent;
var project_status = "${project.project_status}";
var createdid = "${mem.auth}";

	document.addEventListener('DOMContentLoaded', function(e) {
		var mem = "${mem.id}";
		   if(mem==""){
				alert("세션이 만료되어 로그인화면으로 이동합니다.");
				location.href="${path}/main.do?method=loginform"; // 세션값 없을 때 바로 로그인폼 이동
			}
		
		var opts={
				autoOpen:false,	// 초기에 로딩하지 않게 처리
				width:"350px",
				modal:true		// 입력 시 그 외 화면처리는 비활성화 처리
		}
		$( "#schDialog" ).dialog(opts);
		
		var calendarEl = document.getElementById('calendar');
		
		var calendar = new FullCalendar.Calendar(calendarEl, {
		      headerToolbar: {
		        left: 'prevYear prev today next nextYear',
		        center: 'title',
		        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		      },
		      themeSystem: 'bootstrap',
		      initialDate: new Date().toISOString(),	//초기 로딩 날짜(현재 날짜)
		      navLinks: true, // can click day/week names to navigate views
		      selectable: true,
		      selectMirror: true,
		      // 이벤트명:function(){} : 각 날짜에 대한 이벤트를 통해 처리할 내용
		      select: function(arg) {
		    	  // 등록 시, 기존 내용 로딩을 방지 처리, 초기화 처리
		    	  $("#schDialog>form")[0].reset();
		    	  // 화면에 보이는 형식 설정
		    	  // 클릭한 날짜를 전역변수에 할당/시작일과 마지막을 date형식으로 할당
		    	  // 위에 선언한 전역변수에 날짜시간 정보를 할당하므로
		    	  // 다른 함수에서 활용할 수 있게한다
		    	  date.start = arg.start; // arg.start 데이터 유형은 Date
		    	  date.end = arg.end;
		    	  var selectOption = document.getElementById("event-category");
				  console.log(selectOption);
				  
				  // 로그인 세션 pm 만 등록,수정,삭제 가능 
		    	  if("${mem.auth}" =="pm"){
		    	  opts.buttons = {
		    			  "등록":function(){    				  
		    				  var sch = newSch();
		    				  for(var i=0;i<all.length;i++){
		  			    		if(sch.parent == all[i].title){
		  			    			var pleft = all[i].start;
		  			    			var pright = all[i].end;
		  			    		}
		  		    		  }
		    				  // 유효성 검증
		    				 if(!sch.title) {
		    					  alert("태스크 제목 입력 누락");
		    					  return false;
		    				  } else if(!sch.content){
		    					  alert("태스크 내용 입력 누락");
		    					  return false;
		    				  } else if (title.indexOf(sch.title) >= 0){
		    					  alert("태스크 제목 중복!!\n다른 제목으로 입력해주십시오.");
		    					  return false;
		    				  } else if (pleft > sch.start){
		    					  alert("부모 태스크의 시작날짜보다 빠릅니다.\n"+pleft);
		    					  return false;
		    				  } else if(pright < sch.end){
		    					  alert("부모 태스크의 종료날짜보다 느립니다.\n"+pright);
		    					  return false;
		    				  } else if (sch.start > sch.end){
		    					  alert("시작날짜가 종료날짜보다 느립니다.");
		    					  return false;
		    				  }
		    					  
			    			  if(sch.title && sch.content){
		    					  calendar.addEvent(sch);
		    					  calendar.unselect();
		    				  } 
		    				  
		    				  // ajax 처리 ( DB 등록 )
		    				  $.ajax({
		    					 type:"post",
		    					 url:"${path}/cal.do?method=insert&no="+"${no}",
		    					 dataType:"json",
		    					 data:sch,
		    					 success:function(data){
		    						 if(data.success=="Y"){
		    							alert('등록 성공');
		    							all = data.calendar;
		    							title = data.titles; // 모든 태스크 이름
		    							parent = data.parent; // 프로젝트, 태스크 이름
		    			    			holder = data.holder;
		    						 }
		    					 },
		    					 error:function(err){
		    						 console.log(err);
		    					 }
		    				  });
		    				  $("#schDialog").dialog("close");
		    			  }
		    	  };
		    	  console.log("# 매개변수 arg의 속성 #");
		    	  console.log(arg);	// console을 통해서 해당 속성 확인

		    	  // 화면에 보이는 날짜는 한국 표현식으로 처리
		    	  $("[name=start]").val(arg.start.toLocaleString());
		    	  $("[name=end]").val(arg.end.toLocaleString());
		    	  // all.Day는 boolean 값, select의 선택형식에 맞게
		    	  // 처리하려면 ""+ 형식으로 문자열 처리가 필요
		    	  $("[name=allDay]").val(""+arg.allDay);
		    	  // 등록 버튼이 있는 dialog 옵션 설정
		    	  $("#schDialog").dialog(opts);
		    	  // 등록 화면 로딩
		    	  $("#schDialog").dialog("open");
		    	  }
		      },
		      
		      eventDrop:function(arg){
		    	  var exProps = arg.event.extendedProps;
		    	  var start = arg.event.start;
		    	  start = start.toISOString();
		    	  var end = arg.event.end;
		    	  end = end.toISOString();
		    	  
		    	  if(arg.event.id == 1){
			      		//alert("프로젝트");
			      		var leftLimit = all[0].end;
				    	var rightLimit = all[0].start;
			    		for(var i=0;i<all.length;i++){
			    			if(parent[0] == all[i].parent){
			    				if(leftLimit > all[i].start){
			    					leftLimit = all[i].start;
			    				}
			    				if(rightLimit < all[i].end){
			    					rightLimit = all[i].end;
			    				}
			    			}
			    		}
			      		if(leftLimit < start) {
		    				  alert("자식 태스크 중 시작날짜가 더 빠른 것이 있습니다.\n"+leftLimit);
				      		  arg.revert();
		    			} else if(rightLimit > end) {
		    				  alert("자식 태스크 중 종료날짜가 더 느린 것이 있습니다.\n"+rightLimit);
				      		  arg.revert();
		    			} else
		    				eventUpt(arg.event);
			      	  } else if(exProps.parent == parent[0]){
			      		  //alert("태스크");
				      		var leftLimit = all[0].end;
		  			    	var rightLimit = all[0].start;
		  		    		var pleft = all[0].start;
		  			    	var pright = all[0].end;
		  		    		// 서브 태스크 범위 못벗어나게
		  		    		for(var i=0;i<all.length;i++){
		  		    			if(arg.event.title == all[i].parent){
		  		    				if(leftLimit > all[i].start){
		  		    					leftLimit = all[i].start;
		  		    				}
		  		    				if(rightLimit < all[i].end){
		  		    					rightLimit = all[i].end;
		  		    				}
		  		    			}
		  		    		}
				      		
		  		    		if(start > pleft && end < pright ) {
			    				  if(leftLimit < start) {
				    				  alert("자식 태스크 중 시작날짜가 더 빠른 것이 있습니다.");
				    				  arg.revert();
				    			  }
				    			  else if(rightLimit > end) {
				    				  alert("자식 태스크 중 종료날짜가 더 느린 것이 있습니다.");
				    				  arg.revert();
				    			  }
		  			  	  } else if(start < pleft || end > pright){
		  			  			alert("프로젝트의 범위 밖으로 변경하실 수 없습니다.");
		  			  			arg.revert();
		  			  	  } else
		  			  		eventUpt(arg.event);
			      	  } else {
			      		  //alert("서브태스크");
				      		for(var i=0;i<all.length;i++){
		  			    		if(exProps.parent == all[i].title){
		  			    			pleft = all[i].start;
		  			    			pright = all[i].end;
		  			    		}
				    		  }
				  	
						  if(pleft > start){
							  alert("부모 태스크의 시작날짜보다 빠릅니다.");
							  arg.revert();
						  } else if(pright < end){
							  alert("부모 태스크의 종료날짜보다 느립니다.");
							  arg.revert();
						  } else
							  eventUpt(arg.event);
			      	  }  
		      },
		      eventResize:function(arg){
		    	  var exProps = arg.event.extendedProps;
		    	  var start = arg.event.start;
		    	  start = start.toISOString();
		    	  var end = arg.event.end;
		    	  end = end.toISOString();
		      	  if(arg.event.id == 1){
		      		//alert("프로젝트");
		      		var leftLimit = all[0].end;
			    	var rightLimit = all[0].start;
		    		for(var i=0;i<all.length;i++){
		    			if(parent[0] == all[i].parent){
		    				if(leftLimit > all[i].start){
		    					leftLimit = all[i].start;
		    				}
		    				if(rightLimit < all[i].end){
		    					rightLimit = all[i].end;
		    				}
		    			}
		    		}
		      		if(leftLimit < start) {
	    				  alert("자식 태스크 중 시작날짜가 더 빠른 것이 있습니다.");
			      		  arg.revert();
	    			} else if(rightLimit > end) {
	    				  alert("자식 태스크 중 종료날짜가 더 느린 것이 있습니다.");
			      		  arg.revert();
	    			  } else
	    				  eventUpt(arg.event);
		      	  } else if(exProps.parent == parent[0]){
		      		  //alert("태스크");
			      		var leftLimit = all[0].end;
	  			    	var rightLimit = all[0].start;
	  		    		var pleft = all[0].start;
	  			    	var pright = all[0].end;
	  		    		// 서브 태스크 범위 못벗어나게
	  		    		for(var i=0;i<all.length;i++){
	  		    			if(arg.event.title == all[i].parent){
	  		    				if(leftLimit > all[i].start){
	  		    					leftLimit = all[i].start;
	  		    				}
	  		    				if(rightLimit < all[i].end){
	  		    					rightLimit = all[i].end;
	  		    				}
	  		    			}
	  		    		}
			      		
	  		    		if(start > pleft && end < pright ) {
		    				  if(leftLimit < start) {
			    				  alert("자식 태스크 중 시작날짜가 더 빠른 것이 있습니다.");
			    				  arg.revert();
			    			  }
			    			  else if(rightLimit > end) {
			    				  alert("자식 태스크 중 종료날짜가 더 느린 것이 있습니다.");
			    				  arg.revert();
			    			  }
	  			  	  } else if(start < pleft || end > pright){
	  			  			alert("프로젝트의 범위 밖으로 변경하실 수 없습니다.");
	  			  			arg.revert();
	  			  	  } else
	  			  		eventUpt(arg.event);
		      	  } else {
		      		  alert("서브태스크");
			      		for(var i=0;i<all.length;i++){
	  			    		if(exProps.parent == all[i].title){
	  			    			pleft = all[i].start;
	  			    			pright = all[i].end;
	  			    		}
			    		  }
			  	
					  if(pleft > start){
						  alert("부모 태스크의 시작날짜보다 빠릅니다.");
						  arg.revert();
					  } else if(pright < end){
						  alert("부모 태스크의 종료날짜보다 느립니다.");
						  arg.revert();
					  } else
						  eventUpt(arg.event);
		      	  }
		      },
		      eventClick: function(arg) {
		    	detail(arg.event);
				
		    	var idx = title.indexOf(arg.event.title);
		    	title.splice(idx,1);
		    	// 프로젝트, 태스크 수정 시 날짜 범위 설정
		    	
		    	var sch = callSch();
		    	var originalP = sch.parent;
		    	var originalH = sch.holder;
		    	
		    	if("${mem.auth}" =="pm" && "${project.project_status}" == "진행"){
		    	opts.buttons = {
		    			"수정":function(){
		    				// 수정 후, json 데이터 가져오기
		    				// 화면에 form 하위에 있는 요소객체의 값을 가져오는 부분
		    				var sch = callSch();
		    			  // 공통
	    				 if(!sch.title) {
	    					  alert("태스크 제목 입력 누락");
	    					  return false;
	    				  } else if(!sch.content){
	    					  alert("태스크 내용 입력 누락");
	    					  return false;
	    				  } else if (title.indexOf(sch.title) >= 0){
	    					  alert("태스크 제목 중복!!\n다른 제목으로 입력해주십시오.");
	    					  return false;
	    				  } else if (sch.start > sch.end){
	    					  alert("시작날짜가 종료날짜보다 느립니다.");
	    					  return false;
	    				  }
	    				 // 프로젝트
			    		  if(sch.id == 1){
			    			  alert("프로젝트");
			    		  
		    			  	var leftLimit = all[0].end;
					    	var rightLimit = all[0].start;
				    		for(var i=0;i<all.length;i++){
				    			if(parent[0] == all[i].parent){
				    				if(leftLimit > all[i].start){
				    					leftLimit = all[i].start;
				    				}
				    				if(rightLimit < all[i].end){
				    					rightLimit = all[i].end;
				    				}
				    			}
				    		}
				    		console.log("태스크범위");console.log(leftLimit);console.log(rightLimit);
			    		  	console.log(sch.parent);
			    			  if(leftLimit < sch.start) {
			    				  alert("자식 태스크 중 시작날짜가 더 빠른 것이 있습니다.");
			    				  return false;
			    			  }
			    			  else if(rightLimit > sch.end) {
			    				  alert("자식 태스크 중 종료날짜가 더 느린 것이 있습니다.");
								  return false;
			    			  } else if(sch.parent != null){
			    				  alert("프로젝트의 부모태스크는 설정하실 수 없습니다.");
			    				  return false;
			    			  } else if(originalH != sch.holder){
		    					  alert("프로젝트 담당자는 변경하실 수 없습니다.");
		    					  return false;
		    				  }
		    			  } else if(originalP == parent[0]){ // 태스크
		    				  alert("태스크");  
		    			  
		    				var leftLimit = all[0].end;
		  			    	var rightLimit = all[0].start;
		  		    		var pleft = all[0].start;
		  			    	var pright = all[0].end;
		  		    		// 서브 태스크 범위 못벗어나게
		  		    		for(var i=0;i<all.length;i++){
		  		    			if(arg.event.title == all[i].parent){
		  		    				if(leftLimit > all[i].start){
		  		    					leftLimit = all[i].start;
		  		    				}
		  		    				if(rightLimit < all[i].end){
		  		    					rightLimit = all[i].end;
		  		    				}
		  		    			}
		  		    		}
		  		    		
		  		    		  if(originalP != sch.parent){
		    					  alert("태스크의 부모는 프로젝트 이외의 것으로 변경하실 수 없습니다.");
		    					  return false;
		    				  }
		    			  	  if(sch.start > pleft && sch.end < pright ) {
			    				  if(leftLimit < sch.start) {
				    				  alert("자식 태스크 중 시작날짜가 더 빠른 것이 있습니다.");
				    				  return false;
				    			  }
				    			  else if(rightLimit > sch.end) {
				    				  alert("자식 태스크 중 종료날짜가 더 느린 것이 있습니다.");
									  return false;
				    			  }
		    			  	  } else if(sch.start < pleft || sch.end > pright){
		    			  			alert("프로젝트의 범위 밖으로 변경하실 수 없습니다.");
		    						return false;
		    			  	  }
		    			  } else {	// 서브태스크
		    				//alert("서브태스크");  
		    				  for(var i=0;i<all.length;i++){
			  			    		if(sch.parent == all[i].title){
			  			    			pleft = all[i].start;
			  			    			pright = all[i].end;
			  			    		}
		  		    		  }
	    			  
		    				  if(pleft > sch.start){
		    					  alert("부모 태스크의 시작날짜보다 빠릅니다.");
		    					  return false;
		    				  } else if(pright < sch.end){
		    					  alert("부모 태스크의 종료날짜보다 느립니다.");
		    					  return false;
		    				  }
		    			  }
		    				// 1. 화면단 처리 변경
		    				// 현재 캘린더 api의 속성 변경하기
		    				var event = calendar.getEventById(sch.id);
		    				// 속성 값 변경 setProp
		    				event.setProp("title",sch.title);
		    				event.setProp("groupId",sch.groupId);
		    				event.setProp("textColor",sch.textColor);
		    				event.setProp("backgroundColor",sch.backgroundColor);
		    				event.setProp("borderColor",sch.borderColor);
		    				event.setAllDay(sch.allDay);
		    				event.setProp("start",sch.start);
		    				event.setProp("end",sch.end);
		    				// 확장 속성
		    				event.setExtendedProp("holder",sch.holder);
		    				event.setExtendedProp("content",sch.content);
		    				event.setExtendedProp("parent",sch.parent);
		    				event.setExtendedProp("priority",sch.priority);

		    				// DB 변경
		    				//updateCall(sch);
		    				$("#schDialog").dialog("close");
		    				
		    			},
		    			"삭제":function(){
		    				var idVal = $("[name=id]").val();
		    				var sch = callSch();
		    	            var event = calendar.getEventById(idVal);
		    	            if(idVal == 1){
		    	            	alert("프로젝트는 삭제할 수 없습니다.");
		    	            	return false;
		    	            } else {
		    	            	if(sch.parent == parent[0]) { // 태스크
		    	            		if(confirm("하위 태스크도 함께 삭제될 수 있습니다.\n계속 진행하시겠습니까?")){
		    	            			event.remove();
		    	            			for(var i=0;i<all.length;i++){
		    	            				if(sch.title == all[i].parent)
		    	            					event = calendar.getEventById(all[i].id);
		    	            				event.remove();
		    	            			}
		    	            		}
		    	            	} else { // 서브태스크
		    	            		if(confirm("해당 태스크를 삭제하시겠습니까?")){
		    		    	            event.remove();
		    	            		}
		    	            	}
		    	            }
		    	            
		    	            $.ajax({
		    	            	type:"post",
		    	            	url:"${path}/cal.do?method=delete&no="+"${no}",
		    	            	data:{id:idVal},
		    	            	dataType:"json",
		    	            	success:function(data){
		    	            		if(data.success == "Y"){
		    	            			alert("삭제 성공");
		    	            			all = data.calendar;
		    	            			title = data.titles; // 모든 태스크 이름
		    							parent = data.parent; // 프로젝트, 태스크 이름
		    	            		}
		    	            	},
		    	            	error: function(err){
		    	            		alert("에러 발생");
		    	            		console.log(err);
		    	            	}
		    	            })
		    	            
		    	            $("#schDialog").dialog("close");
		    			}
		    	}
		    	}
		    	$("#schDialog").dialog(opts);
		        $("#schDialog").dialog("open");
		      },
		      editable: (createdid == "pm" && project_status =="진행") ? true:false,
		      dayMaxEvents: true, // allow "more" link when too many events
		      events: function(info, successCallback, failureCallback){
		    	 $.ajax({
		    		  type:"get",
		    		  url:"${path}/cal.do?method=data&no="+'${no}',
		    		  dataType:"json",
		    		  success:function(data){
		    			  successCallback(data.calendar);
		    			  all = data.calendar;
		    			  title = data.titles; // 모든 태스크 이름
						  parent = data.parent; // 프로젝트, 태스크 이름
		    		  },
		    		  error:function(err){
		    			  console.log(err);
		    		  }
		    	  });
		      }
		    });

		    calendar.render();
		  });
	
		function newSch(){
			  var sch = {};
	            
			  sch.id = 0;
			  sch.groupId = 0;
			  if($("[name=priority]").val() == 1) sch.backgroundColor = "#f1556c";
			  else if($("[name=priority]").val() == 2) sch.backgroundColor = "#f7b84b";
			  else sch.backgroundColor = "#1abc9c";
			  sch.borderColor = "#000000";
			  sch.textColor = "#ffffff";
			  sch.title=$("[name=title]").val();
			  sch.content=$("[name=content]").val();
			  sch.parent=$("[name=parent]").val();
			  sch.priority=$("[name=priority]").val();
			  sch.holder=$("[name=holder]").val();
			  sch.allDay = false;
			  var tmp = $("[name=start]").val();
			  sch.start = changeDate(tmp);
			  tmp = $("[name=end]").val();
			  sch.end = changeDate(tmp);
			 
			  return sch;
		  }
		
		  function changeDate(date){
			  // 오전 12시 => 00시, 오후 12시 => 12시
			  var parts = date.split('. ');
			  var year = parts[0];
			  var month = parts[1];
			  var day = parts[2];
			  
			  var time = parts[3].split(":");
			  var ampm = time[0].substring(0,2);
			  var hour = time[0].substring(3,5);
			  var min = time[1];
			  var sec = time[2];
			  
			  if(ampm == "오후"){  
			  	  if(hour == "12")
				  	hour = 12;
				  else
					hour = Number(hour) + 12;
			  } else{
				  if(hour =="12")
					  hour = 0;
			  }
			 month = Number(month) - 1;
			 hour = Number(hour) + 9;
			 if(hour >= 24){
				  day = Number(day) + 1;
				  hour = hour % 12;
			  }
			  var d = new Date(year,month,day,hour,min,sec);
			  
			  return d.toISOString();
		  }
		  
		  // form 하위 요소객체에서 사용할 데이터를 json 형식을 만들어 준다
		  function callSch(){
			  var sch = {};
                  
			  sch.id = $("[name=id]").val();
			  sch.groupId = $("[name=groupId]").val();
			  if($("[name=priority]").val() == 1) sch.backgroundColor = "#f1556c";
			  else if($("[name=priority]").val() == 2) sch.backgroundColor = "#f7b84b";
			  else sch.backgroundColor = "#1abc9c";
			  sch.title=$("[name=title]").val();
			  sch.content=$("[name=content]").val();
			  sch.parent=$("[name=parent]").val();
			  sch.priority=$("[name=priority]").val();
			  sch.holder=$("[name=holder]").val();
			  sch.allDay = false;
			  var tmp = $("[name=start]").val();
			  sch.start = changeDate(tmp);
			  tmp = $("[name=end]").val();
			  sch.end = changeDate(tmp);
			  
			  return sch;
		  }
		  function detail(event){
			  $("[name=id]").val(event.id);
			  $("[name=groupId]").val(event.groupId);
			  $("[name=title]").val(event.title);
			  var exProps = event.extendedProps;
			  $("[name=holder]").val(exProps.holder);
			  $("[name=content]").val(exProps.content);
			  $("[name=priority]").val(exProps.priority);
			  $("[name=parent]").val(exProps.parent);
			  var tmps = event.start; tmps.setHours(tmps.getHours() - 9);
			  $("[name=start]").val(tmps.toLocaleString());
			  var tmpe = event.end; tmpe.setHours(tmpe.getHours() - 9);
			  $("[name=end]").val(tmpe.toLocaleString());
			  $("[name=allDay]").val(""+event.allDay);
			  $("[name=backgroundColor]").val(event.backgroundColor);
			  $("[name=textColor]").val(event.textColor);
			  $("[name=borderColor]").val(event.borderColor);
		  }
		  
		  function updateCall(sch){
			  // callSch() 입력된 수정된 데이터를 요청값으로 전달
			  $.ajax({
				  type:"post",
				  url:"${path}/cal.do?method=update&no="+"${no}",
				  data:sch,
				  dataType:"json",
				  success:function(data){
					  // data.모델명
					  if(data.success=="Y")
						  alert("수정완료");
					  all = data.calendar;
	    			  title = data.titles; // 모든 태스크 이름
					  parent = data.parent; // 프로젝트, 태스크 이름
				  },
				  error:function(err){
					  alert("에러발생: " + err);
					  console.log(err);
				  }
			  });
		  }
		  function eventUpt(event){
			 var sch = {};
              
			  sch.id = event.id;
			  sch.groupId = event.groupId;
			  sch.backgroundColor = event.backgroundColor;
			  sch.borderColor = event.borderColor;
			  sch.textColor = event.textColor;
			  sch.title= event.title;
			  sch.content= event.extendedProps.content;
			  sch.parent= event.extendedProps.parent;
			  sch.priority= event.extendedProps.priority;
			  sch.holder= event.extendedProps.holder;
			  sch.allDay = false;
			  sch.start = event.start.toISOString();
			  sch.end = event.end.toISOString();
			  
			  updateCall(sch);
		  }
		</script>
</head>
<body class="loading">

        <!-- Begin page -->
        <div id="wrapper">

            <!-- Topbar Start -->
            <jsp:include page="top.jsp" flush="false"/>
            <!-- end Topbar -->

            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="side.jsp" flush="false"/>
            <!-- Left Sidebar End -->

             <!-- ============================================================== -->
            <!-- Start Page Content here(완료한 프로젝트 테이블로 출력) -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">
						<div class="row">
							<div class="row" style="padding-top:10px;">
														<a href="#"><button class="btn btn-primary btn-md">${project.project_name}</button></a>
														</div> 
							<div class="col-xl-12">
									 <ul class="nav nav-tabs nav-bordered" style="padding-top:10px;">
							            <li class="nav-item">
							                      <a href="${path }/task.do?method=view&no=${param.no}"  class="nav-link">
							                    <span class="d-inline-block d-sm-none"><i class="mdi mdi-home-variant"></i></span>
							                    <span class="d-none d-sm-inline-block">오버뷰</span>
							                </a>
							            </li>
							            <li class="nav-item">
							                <a href="${path}/task.do?method=list&no=${param.no}" class="nav-link">
							                    <span class="d-inline-block d-sm-none"><i class="mdi mdi-account"></i></span>
							                    <span class="d-none d-sm-inline-block">태스크리스트</span>
							                </a>
							            </li>
							            <li class="nav-item">
							                <a href="${path}/dashboard.do?method=list&no=${param.no}"  class="nav-link">
							                    <span class="d-inline-block d-sm-none"><i class="mdi mdi-account"></i></span>
							                    <span class="d-none d-sm-inline-block">대시보드</span>
							                </a>
							            </li>
							            <li class="nav-item">
							                <a href="${path}/gantt.do?method=gantt&no=${param.no}"  class="nav-link">
							                    <span class="d-inline-block d-sm-none"><i class="mdi mdi-email-variant"></i></span>
							                    <span class="d-none d-sm-inline-block">간트차트</span>
							                </a>
							            </li>
							            <li class="nav-item">
							                <a href="${path}/cal.do?method=list&no=${param.no}"  class="nav-link active">
							                    <span class="d-inline-block d-sm-none"><i class="mdi mdi-cog"></i></span>
							                    <span class="d-none d-sm-inline-block">캘린더</span>
							                </a>
							            </li>
							            <li class="nav-item">
							                <a href="${path}/task.do?method=log&no=${param.no}"  class="nav-link">
							                    <span class="d-inline-block d-sm-none"><i class="mdi mdi-cog"></i></span>
							                    <span class="d-none d-sm-inline-block">활동로그</span>
							                </a>
							            </li>
							            <li class="nav-item">
							                <a href="${path}/risk.do?method=riskBoard&no=${param.no}"  class="nav-link">
							                           <span class="d-inline-block d-sm-none"><i class="mdi mdi-cog"></i></span>
							                           <span class="d-none d-sm-inline-block">리스크 현황</span>
							                </a>
							            </li>
							            <c:if test="${mem.auth=='pm' }">
								 <li class="nav-item"><a
									href="${path}/risk.do?method=riskRequest&no=${param.no}" class="nav-link "> <span
										class="d-inline-block d-sm-none"><i
											class="bx bx-info-circle"></i></span> <span
										class="d-none d-sm-inline-block">리스크 요청</span>
								</a></li>
								</c:if>
							         </ul> 
								</div>
							</div>
                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box">
                                    <h4 class="page-title">Calendar</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">${mem.auth}</a></li>
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">${project.project_name}</a></li>
                                            <li class="breadcrumb-item active">Calendar</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>     
                        <!-- end page title --> 

                        <div class="row">
                            <div class="col-12">

                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
										 <div id="calendar"></div>
                                        </div>  <!-- end row -->
                                    </div> <!-- end card body-->
                                </div> <!-- end card -->

                                <!-- Add New Event MODAL -->
                                <div class="modal fade" id="event-modal" tabindex="-1">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header py-3 px-4 border-bottom-0 d-block">
                                                <button type="button" class="btn-close float-end" data-bs-dismiss="modal" aria-label="Close"></button>
                                                <h5 class="modal-title" id="modal-title">태스크</h5>
                                            </div>
                                            <div class="modal-body px-4 pb-4 pt-0" id="schDialog">
                                                <form class="needs-validation" name="event-form" id="form-event" novalidate>
                                                
                                                	<input type="hidden" name="id" />
                                                	<input type="hidden" name="groupId" />
                                                	<input type="hidden" name="backgroundColor"/>
                                                	<input type="hidden" name="borderColor"/>
                                                	<input type="hidden" name="textColor"/>
                                                 
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div class="mb-2">
                                                                <label class="control-label form-label">태스크 이름</label>
                                                                <input class="form-control" placeholder="태스크 제목 입력"
                                                                    type="text" name="title" id="event-title" required />
                                                                <div class="invalid-feedback">제목을 입력하세요</div>
                                                            </div>
                                                            <div class="mb-2">
                                                                <label class="control-label form-label">태스크 내용</label>
                                                                <input class="form-control" placeholder="태스크 내용 입력"
                                                                    type="text" name="content" id="event-content" required />
                                                                <div class="invalid-feedback">내용을 입력하세요</div>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="mb-2">
                                                                <label class="control-label form-label">부모태스크</label>
                                                                <select class="form-control form-select" name="parent" <%--name="category" --%>
                                                                    id="event-category" required>
                                                                    <c:forEach var="p" items="${parent}">
                                                                    <option value="${p}">${p}</option>
                                                                    </c:forEach>
                                                                    
                                                                </select>
                                                                <div class="invalid-feedback">부모태스크를 선택해주십시오</div>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="mb-2">
                                                                <label class="control-label form-label">중요도</label>
                                                                <select class="form-control form-select" name="priority" <%--name="category" --%>
                                                                    id="event-category2" required>
                                                                    <option value="1" selected>High</option>
                                                                    <option value="2">Medium</option>
                                                                    <option value="3">Low</option>
                                                                </select>
                                                                <div class="invalid-feedback">중요도를 선택해주십시오</div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-2">
                                                                <label class="control-label form-label">담당자</label>
                                                               <select class="form-control form-select" name="holder" <%--name="category" --%>
                                                                    id="event-category3" required>
                                                                    <c:forEach var="h" items="${holder}">
                                                                    	<option value="${h}">${h}</option>
                                                                    </c:forEach>
                                                                </select>
                                                                <div class="invalid-feedback">담당자를 선택하세요</div>
                                                        </div>
                                                        <div class="input-group mb-3">
														    <div class="input-group-prepend">
														    	<span class="input-group-text">시작일</span>
														    </div>
														    <input type="text" name="start" class="form-control" />
														</div>
														<div class="input-group mb-3">
														    <div class="input-group-prepend">
														    	<span class="input-group-text">종료일</span>
														    </div>
														    <input type="text" name="end" class="form-control" />
														</div>
                                                    </div>
                                                    <%--
                                                    <div class="row mt-2">
                                                        <div class="col-6">
                                                            <button type="button" class="btn btn-danger" id="btn-delete-event">삭제</button>
                                                        </div>
                                                        <div class="col-6 text-end">
                                                            <button type="button" class="btn btn-light me-1" data-bs-dismiss="modal">닫기</button>
                                                            <button type="submit" class="btn btn-success" id="btn-save-event">등록</button>
                                                        </div>
                                                    </div>
                                                     --%>
                                                </form>
                                            </div>
                                        </div> <!-- end modal-content-->
                                    </div> <!-- end modal dialog-->
                                </div>
                                <!-- end modal-->
                            </div>
                            <!-- end col-12 -->
                        </div> <!-- end row -->
                        
                    </div> <!-- container-fluid -->

                </div> <!-- content -->

                <!-- Footer Start -->
                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6">
                                <script>document.write(new Date().getFullYear())</script> &copy; Minton theme by <a href="">Coderthemes</a> 
                            </div>
                            <div class="col-md-6">
                                <div class="text-md-end footer-links d-none d-sm-block">
                                    <a href="javascript:void(0);">About Us</a>
                                    <a href="javascript:void(0);">Help</a>
                                    <a href="javascript:void(0);">Contact Us</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->


        </div>
        <!-- END wrapper -->

        <jsp:include page="right.jsp" flush="false"/>

        <!-- Vendor js -->
        <script src="${path}/Admin/dist/assets/js/vendor.min.js"></script>
		<%--
        <!-- plugin js -->
        <script src="${path}/Admin/dist/assets/libs/moment/min/moment.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/@fullcalendar/core/main.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/@fullcalendar/bootstrap/main.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/@fullcalendar/daygrid/main.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/@fullcalendar/timegrid/main.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/@fullcalendar/list/main.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/@fullcalendar/interaction/main.min.js"></script>

        <!-- Calendar init -->
        <script src="${path}/Admin/dist/assets/js/pages/calendar.init.js"></script>
		 --%>
        <!-- App js -->
        <script src="${path}/Admin/dist/assets/js/app.min.js"></script>
        <script src="${path}/a00_com/jquery-ui.js"></script>
    </body>
</html>