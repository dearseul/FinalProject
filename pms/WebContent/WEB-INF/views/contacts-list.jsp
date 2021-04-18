<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<fmt:requestEncoding value="UTF-8" /> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>인력조회</title>
        <style type="text/css">
        .project-body { text-align:left!important; }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="${path}/Admin/dist/assets/images/favicon.ico">
			
        <!-- third party css -->
        <link href="${path}/Admin/dist/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="${path}/Admin/dist/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />
      <!-- App css -->
      <link href="${path}/Admin/dist/assets/css/modern/bootstrap-modern.min.css" rel="stylesheet" type="text/css" id="bs-default-stylesheet" />
      <link href="${path}/Admin/dist/assets/css/modern/app-modern.min.css" rel="stylesheet" type="text/css" id="app-default-stylesheet" />
      <link href="${path}/Admin/dist/assets/css/modern/bootstrap-modern-dark.min.css" rel="stylesheet" type="text/css" id="bs-dark-stylesheet" />
      <link href="${path}/Admin/dist/assets/css/modern/app-modern-dark.min.css" rel="stylesheet" type="text/css" id="app-dark-stylesheet" />

      <!-- icons -->
      <link href="${path}/Admin/dist/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
      <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"/>
		<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
		<script src="${path}/a00_com/jquery.min.js"></script>
		<script src="${path}/a00_com/popper.min.js"></script>
		<script src="${path}/a00_com/bootstrap.min.js"></script>
		<script src="${path}/a00_com/jquery-ui.js"></script>
	  <script>
	  	$(document).ready(function(){
	  		
	 	    var mem = "${mem.id}";
	 	    var auth = "${mem.auth}";
		    if(mem=="") location.href="${path}/main.do?method=loginform"; // 세션값 없을 때 바로 로그인폼 이동 	  		
		 	
		    /////////// 조회와 검색
		    // 검색 입력값
  			var shName = "";
  			console.log("shName:"+shName);
			function ajaxSearch(){
	  			$.ajax({
	  				type:"post",
	  				url:"${path}/manpower.do?method=jsonContactList",
	  				data:{
	  					"name":shName
	  				},
	  				dataType:"json",
	  				success:function(data){
	  					console.log(data);
	  					var mlist = data.memList1;
	  					var show = "";
	  					$.each(mlist,function(idx,m){
	  						
	  						show+= "<div class='col-xl-3 col-sm-6'>";			
	  						show+= "<div class='text-center card'>";
	  						show+= "<div class='card-body'>";
	  						show+= "<div class='dropdown float-end'>";
	  						show+= "<a class='text-body dropdown-toggle' href='#' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
	  						show+= "<i class='mdi mdi-dots-vertical font-20'></i></a>";
	  						// 인사부 일 때에만 계정 발송, 인력 삭제가 가능함
	  						if(auth == 'hp'){
	  							show+= "<div class='dropdown-menu dropdown-menu-end'>";
                           		show+= "<a class='dropdown-item goMail' ><button name='mailPno' type='button' value='"+m.pno+"' class='btn btn-primary' data-bs-toggle='modal' data-bs-target='#mail-modal'>계정 발송</button></a>";
                            	show+= "<a class='dropdown-item goDelete'><button name='deletePno' type='button' value='"+m.pno+"' class='btn btn-primary' data-bs-toggle='modal' data-bs-target='#danger-alert-modal'>인력 삭제</button></a>";
                            	if(m.auth == 'wk' || m.auth == 'pm'){
                            		show+= "<a class='dropdown-item alertAuth'><button name='alertPno' type='button' value='"+m.pno+"' class='btn btn-primary' data-bs-toggle='modal' data-bs-target='#alert-modal'>직급 변경</button></a>";
                            	}
                            	show+= "</div>";
	  						}
                            show+= "</div>";                           
	  						show+= "<i class='fas fa-user-circle fa-5x'></i>";
	  						show+= "<h4 class='mt-3 mb-1 name goDetail' name='mt-3 mb-1 name'><a class='text-dark'>";
	  						show+= m.name+"</a>";
	  						show+= "<form style='display:none;'><input type='hidden' class='pno' name=pno value='"+m.pno+"''/></form>";
	  						show+= "</h4>";
	  						show+= "<p class='text-muted'>"+m.auth+"<span> | </span>"+m.part;
	  						show+= "<br><span> <a href='#' class='text-pink'>"+m.email+"</a> </span></p>";
	  						show+= "</div></div></div>";
	  					});
	  					$("#memShow").html(show);
	  				},
		  			error:function(err){
		  				alert("에러 발생:"+err);
		  				console.log(err);
		  			}
	  			});
			};
			ajaxSearch(); // 초기화면 호출하기 위함

	  		// 검색 버튼
 	  		$("#searchBtn").click(function(){
 	  			shName = $("[name=shName]").val();
 	  			console.log(shName);
 	  			ajaxSearch();
	  		}) 
	  		
	  		//////////// 계정 생성 모달
			// 인력 추가 모달창 input값 받아오기
			function addMember(){
				var add = {};
				add.name = $("[name=name]").val();
				add.id = $("[name=id]").val();
				add.pass = $("[name=pass]").val();
				add.auth = $("[name=auth]").val();
				add.part = $("[name=part]").val();
				add.email = $("[name=email]").val();
				return add;
			}
  			$("#signupBtn").click(function(){ 				
  				var insert = addMember();
  				$.ajax({
  					type:"post",
  					url:"manpower.do?method=add_member",
  					data:insert,
  					dataType:"json",
  					success:function(){
  						$("#signup-modal").modal("hide");
  						ajaxSearch();
  						console.log(insert);
  					},
  					error:function(){
  						alert("에러발생");
  					}
  				});
  				$("#addTask_task_name").val("");
  				$("#signup-modal [name=name]").val("");
  				$("#signup-modal [name=id]").val("");
  				$("#signup-modal [name=pass]").val("");
  				$("#signup-modal [name=email]").val("");
  			});
  			
	  		
	  		//////////// 상세화면
			$("#memShow").on("click",".goDetail",function(){
				var ename = $(this).find('.text-dark').html();
				var pno = $(this).find('.pno').val();
				location.href="${path}/manpower.do?method=contacts_profile&ename="+ename+"&pno="+pno;
			});	
	
	  		/////// 메일 발송	  		
	  		$("#memShow").on("click",".goMail",function(){
	  			 var pno = $(this).find("[name=mailPno]").val();
	  			 // alert(pno);
	  			 $.ajax({
		  			type:"post",
		  			url:"${path}/mail.do?method=jsonMailList",
		  			data:{
		  				"pno":pno
		  			},	
  					dataType:"json",
  					success:function(data){
  						var mailInfo = data.mailMemList;
  						$("#mail-modal").modal();
  						$("#mail-modal [name=subject]").val("AZZA 회원 정보입니다.");
  						$("#mail-modal [name=receiver]").val(mailInfo.email);
  						$("#mail-modal [name=content]").val("아이디:"+ mailInfo.id+" 비밀번호:"+mailInfo.pass);  						
  					},
  					error:function(err){
  						alert("에러발생");
  					}
	  			 })	  			 
	  		})
	  		
	  		///////// 인력 삭제
 	  		$("#memShow").on("click",".goDelete",function(){
	  			var pno = $(this).find("[name=deletePno]").val();
	  			// alert(pno);
	  		    $("#deleteManBtn").on("click",function(){
		  			$.ajax({
		  				type:"post",
		  				url:"${path}/manpower.do?method=delete_member",
		  				data:{
		  					"pno":pno
		  				},
		  				dataType:"json",
		  				success:function(data){
		  					$("#danger-alert-modal").modal("hide");
		  					$("#warning-alert-modal").modal("hide");
		  					ajaxSearch();
		  				},
		  				error:function(err){
		  					alert("에러 발생");
		  				}
		  			})
	  			})

	  		}); 
	  		
			//////// 직급 변경
			$("#memShow").on("click",".alertAuth",function(){
				var pno = $(this).find("[name=alertPno]").val();
	  			 $("#alertAuthBtn").on("click",function(){	  				 
	  				 var part = $("#alert-modal [name=part]").val();
	  				 var auth = $("#alert-modal [name=auth]").val();
	  				 $.ajax({
	  					 type:"post",
	  					 url:"${path}/manpower.do?method=alertAuth",
	  					 data:{"part":part, "auth":auth, "pno":pno},
	  					 dataType:"json",
	  					 success:function(data){
	  						 console.log(data);
	  						 $("#alert-modal").modal("hide");
	  						 ajaxSearch();
	  					 },
	  					 error:function(err){
	  						 alert("에러발생:"+err);
	  					 }
	  				 })
 					 
	  			 });	
			})	
	  	});
	  </script>
    </head>

<body class="loading">

        <!-- Begin page -->
        <div id="wrapper">

            <!-- Topbar Start -->
             <jsp:include page="top.jsp"></jsp:include>
            <!-- end Topbar -->

            <!-- ========== Left Sidebar Start ========== -->
         <jsp:include page="side.jsp"></jsp:include>
            <!-- Left Sidebar End -->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

 		<div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">
                        
                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box">
                                    <h4 class="page-title">인력현황</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Main</a></li>
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">인력현황</a></li>
                                            <li class="breadcrumb-item active">전체인원</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2">
                        	
                            <div class="col-sm-4">
                                	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#signup-modal">계정 생성</button>
                            </div>
                        
                        
                        
                            <div class="col-sm-8" text-align="right">
                                <div>
                                        <div style="text-align:right;" class="align-items-start flex-wrap me-2" id="memSearch">
                                            <label for="membersearch-input" class="visually-hidden">검색</label>
                                            <input type="text" class="align-items-start flex-wrap justify-content-sm-end" 
                                            	id="shName" name="shName" placeholder="이름 검색">&nbsp;
                                            <button type="button" id="searchBtn" class="btn btn-success mb-2 mb-sm-0"><i class="mdi mdi-cog"></i></button>	
                                        </div>         
                                </div>
                            </div><!-- end col-->
                        </div>
                        <!-- end row -->
						
                        <div class="row" id="memShow">
                        <!-- 조회 검색 view단 -->
                        </div>
                       
                        <!-- end row -->

                        <div class="row mb-4">
                            <div class="col-sm-6">
                                <div>
                                    <h5 class="font-14 text-body">Showing Page 1 Of 12</h5>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="float-sm-end">
                                    <ul class="pagination pagination-rounded mb-sm-0">
                                        <li class="page-item disabled">
                                            <a href="#" class="page-link"><i class="mdi mdi-chevron-left"></i></a>
                                        </li>
                                        <li class="page-item active">
                                            <a href="#" class="page-link">1</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">2</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">3</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">4</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link">5</a>
                                        </li>
                                        <li class="page-item">
                                            <a href="#" class="page-link"><i class="mdi mdi-chevron-right"></i></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->
                        
                        
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

        <!-- Right Sidebar -->
        <div class="right-bar">
            <div data-simplebar class="h-100">
    
                <!-- Nav tabs -->
                <ul class="nav nav-tabs nav-bordered nav-justified" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link py-2" data-bs-toggle="tab" href="#chat-tab" role="tab">
                            <i class="mdi mdi-message-text-outline d-block font-22 my-1"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link py-2" data-bs-toggle="tab" href="#tasks-tab" role="tab">
                            <i class="mdi mdi-format-list-checkbox d-block font-22 my-1"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link py-2 active" data-bs-toggle="tab" href="#settings-tab" role="tab">
                            <i class="mdi mdi-cog-outline d-block font-22 my-1"></i>
                        </a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content pt-0">
                    <div class="tab-pane" id="chat-tab" role="tabpanel">
                
<%--                         <form class="search-bar p-3">
                            <div class="position-relative">
                                <input type="text" class="form-control" placeholder="Search...">
                                <span class="mdi mdi-magnify"></span>
                            </div>
                        </form> --%>

                        <h6 class="fw-medium px-3 mt-2 text-uppercase">Group Chats</h6>

                        <div class="p-2">
                            <a href="javascript: void(0);" class="text-reset notification-item ps-3 mb-2 d-block">
                                <i class="mdi mdi-checkbox-blank-circle-outline me-1 text-success"></i>
                                <span class="mb-0 mt-1">App Development</span>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item ps-3 mb-2 d-block">
                                <i class="mdi mdi-checkbox-blank-circle-outline me-1 text-warning"></i>
                                <span class="mb-0 mt-1">Office Work</span>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item ps-3 mb-2 d-block">
                                <i class="mdi mdi-checkbox-blank-circle-outline me-1 text-danger"></i>
                                <span class="mb-0 mt-1">Personal Group</span>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item ps-3 d-block">
                                <i class="mdi mdi-checkbox-blank-circle-outline me-1"></i>
                                <span class="mb-0 mt-1">Freelance</span>
                            </a>
                        </div>

                        <h6 class="fw-medium px-3 mt-3 text-uppercase">Favourites <a href="javascript: void(0);" class="font-18 text-danger"><i class="float-end mdi mdi-plus-circle"></i></a></h6>

                        <div class="p-2">
                            <a href="javascript: void(0);" class="text-reset notification-item">
                                <div class="d-flex align-items-start">
                                    <div class="position-relative me-2">
                                        <span class="user-status"></span>
                                        <img src="${path }/Admin/dist/assets/images/users/avatar-10.jpg" class="rounded-circle avatar-sm" alt="user-pic">
                                    </div>
                                    <div class="flex-1 overflow-hidden">
                                        <h6 class="mt-0 mb-1 font-14">Andrew Mackie</h6>
                                        <div class="font-13 text-muted">
                                            <p class="mb-0 text-truncate">It will seem like simplified English.</p>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item">
                                <div class="d-flex align-items-start">
                                    <div class="position-relative me-2">
                                        <span class="user-status"></span>
                                        <img src="${path }/Admin/dist/assets/images/users/avatar-1.jpg" class="rounded-circle avatar-sm" alt="user-pic">
                                    </div>
                                    <div class="flex-1 overflow-hidden">
                                        <h6 class="mt-0 mb-1 font-14">Rory Dalyell</h6>
                                        <div class="font-13 text-muted">
                                            <p class="mb-0 text-truncate">To an English person, it will seem like simplified</p>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item">
                                <div class="d-flex align-items-start">
                                    <div class="position-relative me-2">
                                        <span class="user-status busy"></span>
                                        <img src="${path }/Admin/dist/assets/images/users/avatar-9.jpg" class="rounded-circle avatar-sm" alt="user-pic">
                                    </div>
                                    <div class="flex-1 overflow-hidden">
                                        <h6 class="mt-0 mb-1 font-14">Jaxon Dunhill</h6>
                                        <div class="font-13 text-muted">
                                            <p class="mb-0 text-truncate">To achieve this, it would be necessary.</p>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <h6 class="fw-medium px-3 mt-3 text-uppercase">Other Chats <a href="javascript: void(0);" class="font-18 text-danger"><i class="float-end mdi mdi-plus-circle"></i></a></h6>

                        <div class="p-2 pb-4">
                            <a href="javascript: void(0);" class="text-reset notification-item">
                                <div class="d-flex align-items-start">
                                    <div class="position-relative me-2">
                                        <span class="user-status online"></span>
                                        <img src="${path }/Admin/dist/assets/images/users/avatar-2.jpg" class="rounded-circle avatar-sm" alt="user-pic">
                                    </div>
                                    <div class="flex-1 overflow-hidden">
                                        <h6 class="mt-0 mb-1 font-14">Jackson Therry</h6>
                                        <div class="font-13 text-muted">
                                            <p class="mb-0 text-truncate">Everyone realizes why a new common language.</p>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item">
                                <div class="d-flex align-items-start">
                                    <div class="position-relative me-2">
                                        <span class="user-status away"></span>
                                        <img src="${path }/Admin/dist/assets/images/users/avatar-4.jpg" class="rounded-circle avatar-sm" alt="user-pic">
                                    </div>
                                    <div class="flex-1 overflow-hidden">
                                        <h6 class="mt-0 mb-1 font-14">Charles Deakin</h6>
                                        <div class="font-13 text-muted">
                                            <p class="mb-0 text-truncate">The languages only differ in their grammar.</p>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item">
                                <div class="d-flex align-items-start">
                                    <div class="position-relative me-2">
                                        <span class="user-status online"></span>
                                        <img src="${path }/Admin/dist/assets/images/users/avatar-5.jpg" class="rounded-circle avatar-sm" alt="user-pic">
                                    </div>
                                    <div class="flex-1 overflow-hidden">
                                        <h6 class="mt-0 mb-1 font-14">Ryan Salting</h6>
                                        <div class="font-13 text-muted">
                                            <p class="mb-0 text-truncate">If several languages coalesce the grammar of the resulting.</p>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item">
                                <div class="d-flex align-items-start">
                                    <div class="position-relative me-2">
                                        <span class="user-status online"></span>
                                        <img src="${path }/Admin/dist/assets/images/users/avatar-6.jpg" class="rounded-circle avatar-sm" alt="user-pic">
                                    </div>
                                    <div class="flex-1 overflow-hidden">
                                        <h6 class="mt-0 mb-1 font-14">Sean Howse</h6>
                                        <div class="font-13 text-muted">
                                            <p class="mb-0 text-truncate">It will seem like simplified English.</p>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item">
                                <div class="d-flex align-items-start">
                                    <div class="position-relative me-2">
                                        <span class="user-status busy"></span>
                                        <img src="${path }/Admin/dist/assets/images/users/avatar-7.jpg" class="rounded-circle avatar-sm" alt="user-pic">
                                    </div>
                                    <div class="flex-1 overflow-hidden">
                                        <h6 class="mt-0 mb-1 font-14">Dean Coward</h6>
                                        <div class="font-13 text-muted">
                                            <p class="mb-0 text-truncate">The new common language will be more simple.</p>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset notification-item">
                                <div class="d-flex align-items-start">
                                    <div class="position-relative me-2">
                                        <span class="user-status away"></span>
                                        <img src="${path }/Admin/dist/assets/images/users/avatar-8.jpg" class="rounded-circle avatar-sm" alt="user-pic">
                                    </div>
                                    <div class="flex-1 overflow-hidden">
                                        <h6 class="mt-0 mb-1 font-14">Hayley East</h6>
                                        <div class="font-13 text-muted">
                                            <p class="mb-0 text-truncate">One could refuse to pay expensive translators.</p>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <div class="text-center mt-3">
                                <a href="javascript:void(0);" class="btn btn-sm btn-white">
                                    <i class="mdi mdi-spin mdi-loading me-2"></i>
                                    Load more
                                </a>
                            </div>
                        </div>

                    </div>

                    <div class="tab-pane" id="tasks-tab" role="tabpanel">
                        <h6 class="fw-medium p-3 m-0 text-uppercase">Working Tasks</h6>
                        <div class="px-2">
                            <a href="javascript: void(0);" class="text-reset item-hovered d-block p-2">
                                <p class="text-muted mb-0">App Development<span class="float-end">75%</span></p>
                                <div class="progress mt-2" style="height: 4px;">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset item-hovered d-block p-2">
                                <p class="text-muted mb-0">Database Repair<span class="float-end">37%</span></p>
                                <div class="progress mt-2" style="height: 4px;">
                                    <div class="progress-bar bg-info" role="progressbar" style="width: 37%" aria-valuenow="37" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset item-hovered d-block p-2">
                                <p class="text-muted mb-0">Backup Create<span class="float-end">52%</span></p>
                                <div class="progress mt-2" style="height: 4px;">
                                    <div class="progress-bar bg-warning" role="progressbar" style="width: 52%" aria-valuenow="52" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </a>
                        </div>

                        <h6 class="fw-medium px-3 mb-0 mt-4 text-uppercase">Upcoming Tasks</h6>

                        <div class="p-2">
                            <a href="javascript: void(0);" class="text-reset item-hovered d-block p-2">
                                <p class="text-muted mb-0">Sales Reporting<span class="float-end">12%</span></p>
                                <div class="progress mt-2" style="height: 4px;">
                                    <div class="progress-bar bg-danger" role="progressbar" style="width: 12%" aria-valuenow="12" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset item-hovered d-block p-2">
                                <p class="text-muted mb-0">Redesign Website<span class="float-end">67%</span></p>
                                <div class="progress mt-2" style="height: 4px;">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 67%" aria-valuenow="67" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </a>

                            <a href="javascript: void(0);" class="text-reset item-hovered d-block p-2">
                                <p class="text-muted mb-0">New Admin Design<span class="float-end">84%</span></p>
                                <div class="progress mt-2" style="height: 4px;">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 84%" aria-valuenow="84" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </a>
                        </div>

                        <div class="d-grid p-3 mt-2">
                            <a href="javascript: void(0);" class="btn btn-success waves-effect waves-light">Create Task</a>
                        </div>

                    </div>
                    <div class="tab-pane active" id="settings-tab" role="tabpanel">
                        <h6 class="fw-medium px-3 m-0 py-2 font-13 text-uppercase bg-light">
                            <span class="d-block py-1">Theme Settings</span>
                        </h6>

                        <div class="p-3">
                            <div class="alert alert-warning" role="alert">
                                <strong>Customize </strong> the overall color scheme, sidebar menu, etc.
                            </div>

                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Color Scheme</h6>
                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="color-scheme-mode" value="light" id="light-mode-check" checked>
                                <label class="form-check-label" for="light-mode-check">Light Mode</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="color-scheme-mode" value="dark" id="dark-mode-check">
                                <label class="form-check-label" for="dark-mode-check">Dark Mode</label>
                            </div>

                            <!-- Width -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Width</h6>
                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="width" value="fluid" id="fluid-check" checked>
                                <label class="form-check-label" for="fluid-check">Fluid</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="width" value="boxed" id="boxed-check">
                                <label class="form-check-label" for="boxed-check">Boxed</label>
                            </div>
                   

                            <!-- Topbar -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Topbar</h6>
                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="topbar-color" value="dark" id="darktopbar-check" checked>
                                <label class="form-check-label" for="darktopbar-check">Dark</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="topbar-color" value="light" id="lighttopbar-check">
                                <label class="form-check-label" for="lighttopbar-check">Light</label>
                            </div>


                            <!-- Menu positions -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Menus Positon <small>(Leftsidebar and Topbar)</small></h6>
                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="menus-position" value="fixed" id="fixed-check" checked>
                                <label class="form-check-label" for="fixed-check">Fixed</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="menus-position" value="scrollable" id="scrollable-check">
                                <label class="form-check-label" for="scrollable-check">Scrollable</label>
                            </div>


                            <!-- Left Sidebar-->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Left Sidebar Color</h6>
                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="leftsidebar-color" value="light" id="light-check" checked>
                                <label class="form-check-label" for="light-check">Light</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="leftsidebar-color" value="dark" id="dark-check">
                                <label class="form-check-label" for="dark-check">Dark</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="leftsidebar-color" value="brand" id="brand-check">
                                <label class="form-check-label" for="brand-check">Brand</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="leftsidebar-color" value="gradient" id="gradient-check">
                                <label class="form-check-label" for="gradient-check">Gradient</label>
                            </div>
                    

                            <!-- size -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Left Sidebar Size</h6>
                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="leftsidebar-size" value="default" id="default-size-check" checked>
                                <label class="form-check-label" for="default-size-check">Default</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="leftsidebar-size" value="condensed" id="condensed-check">
                                <label class="form-check-label" for="condensed-check">Condensed <small>(Extra Small size)</small></label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="leftsidebar-size" value="compact" id="compact-check">
                                <label class="form-check-label" for="compact-check">Compact <small>(Small size)</small></label>
                            </div>
                    

                            <!-- User info -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Sidebar User Info</h6>
                            <div class="form-check form-switch mb-1">
                                <input class="form-check-input" type="checkbox" name="leftsidebar-user" value="fixed" id="sidebaruser-check">
                                <label class="form-check-label" for="sidebaruser-check">Enable</label>
                            </div>

                            <div class="d-grid mt-4">
                                <button class="btn btn-primary" id="resetBtn">Reset to Default</button>

                            <a href="https://wrapbootstrap.com/theme/minton-admin-dashboard-landing-template-WB0858DB6?ref=coderthemes"
                                class="btn btn-danger mt-2" target="_blank"><i class="mdi mdi-basket me-1"></i> Purchase Now</a>
                            </div>

                        </div>

                    </div>
                </div>

            </div> <!-- end slimscroll-menu-->
        </div>
        <!-- /Right-bar -->

        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>

        <!-- Vendor js -->
        <script src="${path }/Admin/dist/assets/js/vendor.min.js"></script>

        <!-- App js -->
        <script src="${path }/Admin/dist/assets/js/app.min.js"></script>


                                        <!-- Signup modal content -->
                                        <div id="signup-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
    
                                                    <div class="modal-body">
                                                        <div class="text-center mt-2 mb-4">
                                                            <a href="index.html" class="text-success">
                                                                <span>
  																 <img src="${path }/Admin/dist/assets/images/logo-dark.png" alt="" height="24">
                                                                </span>
                                                            </a>
                                                        </div>
														<!-- <div class="col-xl-3 col-lg-4 col-sm-6">
                                                            <i class="bx bxs-user"></i>
                                                        </div> -->
                                                            <div class="mb-3">
                                                                <label for="name" class="form-label">이름</label>
                                                                <input name="name" class="form-control" type="text" placeholder="이름"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="email" class="form-label">이메일</label>
                                                                <input name="email" class="form-control" type="email" placeholder="이메일"/>
                                                            </div>   
                                                            <div class="mb-3">
                                                                <label for="id" class="form-label">아이디</label>
                                                                <input name="id" class="form-control" type="text" placeholder="아이디"/>
                                                            </div>
                                                             <div class="mb-3">
                                                                <label for="pass" class="form-label">비밀번호</label>
                                                                <input name="pass" class="form-control" type="password" placeholder="비밀번호"/>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="part" class="form-label">부서</label>
                                                                <select name="part" class="form-control">
                                                                	<c:forEach var="part" items="${partList}">
                                                                		<option name="part" value="${part.part }">${part.part }</option>
                                                                	</c:forEach>
                                                                </select>
                                                            </div>   
                                                            <div class="mb-3">
                                                                <label for="auth" class="form-label">직급</label>
                                                                <select name="auth" class="form-control">
                                                                	<c:forEach var="auth" items="${authList}">
                                                                		<option name="auth" value="${auth.auth }">${auth.auth }</option>
                                                                	</c:forEach>                                                                	
                                                                </select>
                                                                
                                                            </div>                                                                                                                               
                                                            <div class="mb-3 text-center">
                                                                <button type="button" class="btn btn-info waves-effect waves-light" data-bs-dismiss="modal" id="signupBtn">계정생성</button>
                                                            </div>
                                                    </div>
                                                </div><!-- /.modal-content -->
                                            </div><!-- /.modal-dialog -->
                                        </div><!-- /.modal -->


                                        <!-- mail modal content -->
                                        <div id="mail-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
    
                                                    <div class="modal-body">
                                                        <div class="text-center mt-2 mb-4">
                                                            <a href="index.html" class="text-success">
                                                                <span><img src="${path }/Admin/dist/assets/images/logo-dark.png" alt="" height="24"></span>
                                                            </a>
                                                        </div>

														<!-- MessagingException -->
    													<form class="px-3"  method="post" action="${path}/mail.do?method=send"> 
                                                            <div class="mb-3">
                                                                <label for="subject" class="form-label">제 목</label>
                                                                <!-- 시작 -->
                                                                <input name="subject" class="form-control" type="text" placeholder="제목을 입력하세요."/>
                                                            </div>
    
                                                            <div class="mb-3">
                                                                <label for="receiver" class="form-label">이메일 주소</label>
                                                                <input name="receiver" class="form-control" type="email" placeholder="이메일 주소를 입력하세요."/>
                                                            </div>
    
                                                            <div class="mb-3">
                                                                <label for="content" class="form-label">내 용</label>
                                                                <input name="content" class="form-control" type="text" placeholder="내용을 입력하세요."/>
                                                            	<!-- 끝 -->
                                                            </div>                                                                                                                          
                                                            <div class="mb-3 text-center">
                                                                <input class="btn btn-primary" id="mailBtn" type="submit" value="메일 전송"/>
                                                            </div>
    
                                                       </form> 
    
                                                    </div>
                                                </div><!-- /.modal-content -->
                                            </div><!-- /.modal-dialog -->
                                        </div><!-- /.modal -->
										<!-- Danger Alert Modal -->
						                <div id="danger-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
						                    <div class="modal-dialog modal-sm">
						                        <div class="modal-content modal-filled bg-danger">
						                            <div class="modal-body p-4">
						                                <div class="text-center">
						                                    <i class="bx bx-aperture h1 text-white"></i>
						                                    <input type="hidden" id="delete_pno" />
						                                    <h4 class="mt-2 text-white">인력 삭제</h4>
						                                    <p class="mt-3 text-white">해당 인력을 삭제하시겠습니까?</p>
						                                    <button type="button" class="btn btn-light my-2" id="deleteManBtn" data-bs-toggle="modal" data-bs-target="#warning-alert-modal">삭제</button>
						                                    <button type="button" class="btn btn-secondary my-2" data-bs-dismiss="modal">취소</button>
						                                </div>
						                            </div>
						                        </div><!-- /.modal-content -->
						                    </div><!-- /.modal-dialog -->
						                </div><!-- /.modal -->                                        
                                        
							                     <!-- Warning Alert Modal -->
							               <div id="warning-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
							                   <div class="modal-dialog modal-sm">
							                       <div class="modal-content">
							                           <div class="modal-body p-4">
							                               <div class="text-center">
							                                   <i class="bx bx-check-circle h1 text-info"></i>
							                                  <!--  <h4 class="mt-2">태스크 삭제</h4> -->
							                                   <p class="mt-3">삭제되었습니다.</p>
							                                   <button type="button" class="btn btn-info my-2" data-bs-dismiss="modal">확인</button>
							                               </div>
							                           </div>
							                       </div><!-- /.modal-content -->
							                   </div><!-- /.modal-dialog -->
							               </div><!-- /.modal -->  
							               
                                        <!-- alert modal content -->
                                        <div id="alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
    
                                                    <div class="modal-body">
                                                        <div class="text-center mt-2 mb-4">
                                                            <a href="index.html" class="text-success">
                                                                <span><img src="${path }/Admin/dist/assets/images/logo-dark.png" alt="" height="24"></span>
                                                            </a>
                                                        </div>
                                                            <div class="mb-3">
                                                                <label for="part" class="form-label">부 서</label>
                                                                <select name="part" class="form-control">
                                                                	<option "selected=selected">-- 부서 선택 --</option>
                                                                	<option>관리부</option>
                                                                	<option>개발부</option>
                                                                </select>
                                                            </div>    
                                                            <div class="mb-3">
                                                                <label for="auth" class="form-label">직 급</label>
                                                                <select name="auth" class="form-control">
                                                                	<option "selected=selected">-- 직급 선택 --</option>
                                                                	<option>wk</option>
                                                                	<option>pm</option>
                                                                </select>
                                                            </div>                                                                                                                        
                                                            <div class="mb-3 text-center">
                                                                <button class="btn btn-primary" id="alertAuthBtn">변경하기</button>
                                                            </div>

    
                                                    </div>
                                                </div><!-- /.modal-content -->
                                            </div><!-- /.modal-dialog -->
                                        </div><!-- /.modal -->							               
    </body>
</html>