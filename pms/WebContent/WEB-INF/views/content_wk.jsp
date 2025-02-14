<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.util.*"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>  
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<fmt:requestEncoding value="UTF-8" /> 
<!DOCTYPE html>
<html>
	<body> 
	    <div class="row">
	        <div class="col-lg-12">
	            <div class="row">
	                <div class="col">
	                    <div class="card">
	                        <div class="card-body">
	                            <!-- cta -->
	                            <div class="row">
	                            	<c:if test="${mem.auth == 'wk' }">
	                                <div class="col-sm-3">
	                                    <a href="#" class="btn btn-primary waves-effect waves-light"><i class='fe-plus me-1'></i>Add New</a>
	                                </div>
	                                </c:if>
	                                <div class="col-sm-9">
	                                    <div class="float-sm-end mt-3 mt-sm-0">
	                                        <div class="d-flex align-items-start flex-wrap">
	                                            <div class="mb-3 mb-sm-0 me-sm-2">
	                                                <form>
	                                                    <div class="position-relative">
	                                                        <input type="text" class="form-control" placeholder="Search...">
	                                                    </div>
	                                                </form>
	                                            </div>
	                                            <div class="dropdown">
	                                                <button class="btn btn-light dropdown-toggle" type="button"
	                                                    data-bs-toggle="dropdown" aria-haspopup="true"
	                                                    aria-expanded="false">
	                                                    <i class="mdi mdi-filter-variant"></i>
	                                                </button>
	                                                <div class="dropdown-menu dropdown-menu-end">
	                                                    <a class="dropdown-item" href="#">Due Date</a>
	                                                    <a class="dropdown-item" href="#">Added Date</a>
	                                                    <a class="dropdown-item" href="#">Assignee</a>
	                                                </div>
	                                            </div>
	                                        </div>
	                                        
	                                    </div>
	                                </div>
	                            </div>
	
	                            <div class="custom-accordion">
	                                <div class="mt-4">
	                                    <h5 class="position-relative mb-0"><a href="#taskcollapse1" class="text-dark d-block" data-bs-toggle="collapse">오늘의 할일 <span class="text-muted">(08)</span> <i class="mdi mdi-chevron-down accordion-arrow"></i></a></h5>
	                                    <div class="collapse show" id="taskcollapse1">
	                                        <div class="table-responsive mt-3">
	                                            <table class="table table-centered table-nowrap table-borderless table-sm">
	                                                <thead class="table-light">
	                                                    <tr class="">
	                                                        <th scope="col">
	                                                            <div class="form-check">
	                                                                <input class="form-check-input" type="checkbox" id="tasktodayCheck">
	                                                                <label class="form-check-label" for="tasktodayCheck">Task ID</label>
	                                                            </div>
	                                                        </th>
	                                                        <th scope="col">Tasks</th>
	                                                        <th scope="col">Assign to</th>
	                                                        <th scope="col">Due Date</th>
	                                                        <th scope="col">Task priority</th>
	                                                        <th scope="col" style="width: 85px;">Action</th>
	                                                    </tr>
	                                                </thead>
	                                                <tbody>
	                                                    <tr>
	                                                        <td>
	                                                            <div class="form-check">
	                                                                <input class="form-check-input" type="checkbox" id="tasktodayCheck01">
	                                                                <label class="form-check-label" for="tasktodayCheck01">#MN2045</label>
	                                                            </div>
	                                                        </td>
	                                                        <td>IOS App home page</td>
	                                                        <td>
	                                                            <div>
	                                                                <img src="${path}/Admin/dist/assets/images/users/avatar-2.jpg" lt="image" class="avatar-sm img-thumbnail rounded-circle" title="Houston Fritz" />
	                                                            </div>
	                                                        </td>
	                                                        <td>Today 10am</td>
	                                                        <td><span class="badge badge-soft-danger p-1">High</span></td>
	                                                        <td>
	                                                            <ul class="list-inline table-action m-0">
	                                                                <li class="list-inline-item"> 
	                                                                    <a href="javascript:void(0);" class="action-icon px-1"> <i class="mdi mdi-square-edit-outline"></i></a>
	                                                                </li>
	                                                                <li class="list-inline-item"> 
	                                                                    <div class="dropdown">
	                                                                        <a class="action-icon px-1 dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                            <i class="mdi mdi-dots-vertical"></i>
	                                                                        </a>
	                                                                    
	                                                                        <div class="dropdown-menu dropdown-menu-end">
	                                                                        <a class="dropdown-item" href="#">Action</a>
	                                                                        <a class="dropdown-item" href="#">Another action</a>
	                                                                        <a class="dropdown-item" href="#">Something else here</a>
	                                                                        </div>
	                                                                    </div>
	                                                                </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>
	                                                            <div class="form-check">
	                                                                <input class="form-check-input" type="checkbox" id="tasktodayCheck02">
	                                                                <label class="form-check-label" for="tasktodayCheck02">#MN2044</label>
	                                                            </div>
	                                                        </td>
	                                                        <td>Topnav layout design</td>
	                                                        <td>
	                                                            <div>
	                                                                <img src="${path}/Admin/dist/assets/images/users/avatar-3.jpg" lt="image" class="avatar-sm img-thumbnail rounded-circle" title="Glenn Lynch" />
	                                                            </div>
	                                                        </td>
	                                                        <td>Today 04pm</td>
	                                                        <td><span class="badge badge-soft-info p-1">Medium</span></td>
	                                                        <td>
	                                                            <ul class="list-inline table-action m-0">
	                                                                <li class="list-inline-item"> 
	                                                                    <a href="javascript:void(0);" class="action-icon px-1"> <i class="mdi mdi-square-edit-outline"></i></a>
	                                                                </li>
	                                                                <li class="list-inline-item"> 
	                                                                    <div class="dropdown">
	                                                                        <a class="action-icon px-1 dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                            <i class="mdi mdi-dots-vertical"></i>
	                                                                        </a>
	                                                                    
	                                                                        <div class="dropdown-menu dropdown-menu-end">
	                                                                        <a class="dropdown-item" href="#">Action</a>
	                                                                        <a class="dropdown-item" href="#">Another action</a>
	                                                                        <a class="dropdown-item" href="#">Something else here</a>
	                                                                        </div>
	                                                                    </div>
	                                                                </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>
	                                                            <div class="form-check">
	                                                                <input class="form-check-input" type="checkbox" id="tasktodayCheck03">
	                                                                <label class="form-check-label" for="tasktodayCheck03">#MN2043</label>
	                                                            </div>
	                                                        </td>
	                                                        <td>Invite user to a project</td>
	                                                        <td>
	                                                            <div>
	                                                                <img src="${path}/Admin/dist/assets/images/users/avatar-4.jpg" lt="image" class="avatar-sm img-thumbnail rounded-circle" title="Robert Hebert" />
	                                                            </div>
	                                                        </td>
	                                                        <td>Today 02pm</td>
	                                                        <td><span class="badge badge-soft-danger p-1">High</span></td>
	                                                        <td>
	                                                            <ul class="list-inline table-action m-0">
	                                                                <li class="list-inline-item"> 
	                                                                    <a href="javascript:void(0);" class="action-icon px-1"> <i class="mdi mdi-square-edit-outline"></i></a>
	                                                                </li>
	                                                                <li class="list-inline-item"> 
	                                                                    <div class="dropdown">
	                                                                        <a class="action-icon px-1 dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                            <i class="mdi mdi-dots-vertical"></i>
	                                                                        </a>
	                                                                    
	                                                                        <div class="dropdown-menu dropdown-menu-end">
	                                                                        <a class="dropdown-item" href="#">Action</a>
	                                                                        <a class="dropdown-item" href="#">Another action</a>
	                                                                        <a class="dropdown-item" href="#">Something else here</a>
	                                                                        </div>
	                                                                    </div>
	                                                                </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>
	                                                            <div class="form-check">
	                                                                <input class="form-check-input" type="checkbox" id="tasktodayCheck04">
	                                                                <label class="form-check-label" for="tasktodayCheck04">#MN2042</label>
	                                                            </div>
	                                                        </td>
	                                                        <td>Write a release note</td>
	                                                        <td>
	                                                            <div>
	                                                                <img src="${path}/Admin/dist/assets/images/users/avatar-5.jpg" lt="image" class="avatar-sm img-thumbnail rounded-circle" title="Darnell McCormick" />
	                                                            </div>
	                                                        </td>
	                                                        <td>Today 06pm</td>
	                                                        <td><span class="badge badge-soft-success p-1">Low</span></td>
	                                                        <td>
	                                                            <ul class="list-inline table-action m-0">
	                                                                <li class="list-inline-item"> 
	                                                                    <a href="javascript:void(0);" class="action-icon px-1"> <i class="mdi mdi-square-edit-outline"></i></a>
	                                                                </li>
	                                                                <li class="list-inline-item"> 
	                                                                    <div class="dropdown">
	                                                                        <a class="action-icon px-1 dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                            <i class="mdi mdi-dots-vertical"></i>
	                                                                        </a>
	                                                                    
	                                                                        <div class="dropdown-menu dropdown-menu-end">
	                                                                        <a class="dropdown-item" href="#">Action</a>
	                                                                        <a class="dropdown-item" href="#">Another action</a>
	                                                                        <a class="dropdown-item" href="#">Something else here</a>
	                                                                        </div>
	                                                                    </div>
	                                                                </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                </tbody>
	                                            </table>
	                                        </div>
	                                    </div>
	                                </div>
	
	                                <div class="mt-4">
	                                    <h5 class="position-relative mb-0"><a href="#taskcollapse2" class="text-dark d-block" data-bs-toggle="collapse">마감임박 <span class="text-muted">(05)</span> <i class="mdi mdi-chevron-down accordion-arrow"></i></a></h5>
	                                    <div class="collapse show" id="taskcollapse2">
	                                        <div class="table-responsive mt-3">
	                                            <table class="table table-centered table-nowrap table-borderless table-sm">
	                                                <thead class="table-light">
	                                                    <tr class="">
	                                                        <th scope="col">
	                                                            <div class="form-check">
	                                                                <input class="form-check-input" type="checkbox" id="taskupcomingCheck">
	                                                                <label class="form-check-label" for="taskupcomingCheck">Task ID</label>
	                                                            </div>
	                                                        </th>
	                                                        <th scope="col">Tasks</th>
	                                                        <th scope="col">Assign to</th>
	                                                        <th scope="col">Due Date</th>
	                                                        <th scope="col">Task priority</th>
	                                                        <th scope="col" style="width: 85px;">Action</th>
	                                                    </tr>
	                                                </thead>
	                                                <tbody>
	                                                    <tr>
	                                                        <td>
	                                                            <div class="form-check">
	                                                                <input class="form-check-input" type="checkbox" id="taskupcomingCheck01">
	                                                                <label class="form-check-label" for="taskupcomingCheck01">#MN2050</label>
	                                                            </div>
	                                                        </td>
	                                                        <td>Enable analytics tracking</td>
	                                                        <td>
	                                                            <div>
	                                                                <img src="${path}/Admin/dist/assets/images/users/avatar-5.jpg" lt="image" class="avatar-sm img-thumbnail rounded-circle" title="Donald Mealy" />
	                                                            </div>
	                                                        </td>
	                                                        <td>May 27, 2020</td>
	                                                        <td><span class="badge badge-soft-danger p-1">High</span></td>
	                                                        <td>
	                                                            <ul class="list-inline table-action m-0">
	                                                                <li class="list-inline-item"> 
	                                                                    <a href="javascript:void(0);" class="action-icon px-1"> <i class="mdi mdi-square-edit-outline"></i></a>
	                                                                </li>
	                                                                <li class="list-inline-item"> 
	                                                                    <div class="dropdown">
	                                                                        <a class="action-icon px-1 dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                            <i class="mdi mdi-dots-vertical"></i>
	                                                                        </a>
	                                                                    
	                                                                        <div class="dropdown-menu dropdown-menu-end">
	                                                                        <a class="dropdown-item" href="#">Action</a>
	                                                                        <a class="dropdown-item" href="#">Another action</a>
	                                                                        <a class="dropdown-item" href="#">Something else here</a>
	                                                                        </div>
	                                                                    </div>
	                                                                </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>
	                                                            <div class="form-check">
	                                                                <input class="form-check-input" type="checkbox" id="taskupcomingCheck02">
	                                                                <label class="form-check-label" for="taskupcomingCheck02">#MN2049</label>
	                                                            </div>
	                                                        </td>
	                                                        <td>Kanban board design</td>
	                                                        <td>
	                                                            <div>
	                                                                <img src="${path}/Admin/dist/assets/images/users/avatar-6.jpg" lt="image" class="avatar-sm img-thumbnail rounded-circle" title="Shelton Garza" />
	                                                            </div>
	                                                        </td>
	                                                        <td>No Due Date</td>
	                                                        <td><span class="badge badge-soft-info p-1">Medium</span></td>
	                                                        <td>
	                                                            <ul class="list-inline table-action m-0">
	                                                                <li class="list-inline-item"> 
	                                                                    <a href="javascript:void(0);" class="action-icon px-1"> <i class="mdi mdi-square-edit-outline"></i></a>
	                                                                </li>
	                                                                <li class="list-inline-item"> 
	                                                                    <div class="dropdown">
	                                                                        <a class="action-icon px-1 dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                            <i class="mdi mdi-dots-vertical"></i>
	                                                                        </a>
	                                                                    
	                                                                        <div class="dropdown-menu dropdown-menu-end">
	                                                                        <a class="dropdown-item" href="#">Action</a>
	                                                                        <a class="dropdown-item" href="#">Another action</a>
	                                                                        <a class="dropdown-item" href="#">Something else here</a>
	                                                                        </div>
	                                                                    </div>
	                                                                </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>
	                                                            <div class="form-check">
	                                                                <input class="form-check-input" type="checkbox" id="taskupcomingCheck03">
	                                                                <label class="form-check-label" for="taskupcomingCheck03">#MN2048</label>
	                                                            </div>
	                                                        </td>
	                                                        <td>Code HTML email template</td>
	                                                        <td>
	                                                            <div>
	                                                                <img src="${path}/Admin/dist/assets/images/users/avatar-7.jpg" lt="image" class="avatar-sm img-thumbnail rounded-circle" title="Adrian Key" />
	                                                            </div>
	                                                        </td>
	                                                        <td>June 08, 2020</td>
	                                                        <td><span class="badge badge-soft-danger p-1">High</span></td>
	                                                        <td>
	                                                            <ul class="list-inline table-action m-0">
	                                                                <li class="list-inline-item"> 
	                                                                    <a href="javascript:void(0);" class="action-icon px-1"> <i class="mdi mdi-square-edit-outline"></i></a>
	                                                                </li>
	                                                                <li class="list-inline-item"> 
	                                                                    <div class="dropdown">
	                                                                        <a class="action-icon px-1 dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                            <i class="mdi mdi-dots-vertical"></i>
	                                                                        </a>
	                                                                    
	                                                                        <div class="dropdown-menu dropdown-menu-end">
	                                                                        <a class="dropdown-item" href="#">Action</a>
	                                                                        <a class="dropdown-item" href="#">Another action</a>
	                                                                        <a class="dropdown-item" href="#">Something else here</a>
	                                                                        </div>
	                                                                    </div>
	                                                                </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                </tbody>
	                                            </table>
	                                        </div>
	                                    </div>
	                                </div>
	
	                            </div>
	                            
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
    </body>
</html>