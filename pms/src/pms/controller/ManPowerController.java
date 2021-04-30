package pms.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pms.dto.Member;
import pms.dto.MemberSch;
import pms.dto.ProjectAdd;
import pms.dto.pms_project;
import pms.service.ManPowerService;
import pms.service.MypageService;

@Controller
@RequestMapping("manpower.do")
public class ManPowerController {
	@Autowired(required = false)
	private ManPowerService service;
	@Autowired(required=false)
	private MypageService service2;
	// http://localhost:7080/pms/manpower.do?method=jsonContactList
	@RequestMapping(params = "method=jsonContactList")
	public String memList1(
			@ModelAttribute("sch") MemberSch sch,
			Model d) {
		d.addAttribute("memList", service.showMem(sch));
		return "pageJsonReport";
	}
	
	// http://localhost:7080/pms/manpower.do?method=contacts_list
	@RequestMapping(params="method=contacts_list")
	public String showMem(Model d, 
			@ModelAttribute("sch") MemberSch sch) {
		d.addAttribute("partList", service.deptList());
		d.addAttribute("authList", service.authList());
		d.addAttribute("memList", service.showMem(sch));
		d.addAttribute("memAuth", service.memList2(sch.getPno()));
		return "contacts-list";
	}
	
	/*
	 * @RequestMapping(params="method=allMan") public String
	 * allMan(@RequestParam("shName") String name, Model d) { if(name==null)
	 * name=""; d.addAttribute("memList1", service.memList1(sch)); return "allMan";
	 * }
	 */

	// http://localhost:7080/pms/manpower.do?method=contacts_list2
	@RequestMapping(params = "method=contacts_list2")
	public String memList(@ModelAttribute("sch") MemberSch sch, Model d) {
		d.addAttribute("memList2",service.showMem2(sch));
		d.addAttribute("partList", service.deptList());
		d.addAttribute("authList", service.authList());		
		return "contacts-list2";
	}

	// http://localhost:7080/pms/manpower.do?method=contacts_list3

	@RequestMapping(params = "method=contacts_list3")
	public String memList3(@ModelAttribute("sch") MemberSch sch,
			Model d) {
		// 부서 목록
		if(sch.getName()==null) sch.setName("");
		System.out.println("###curPage3 : "+sch.getCurPage());
		System.out.println("###start : "+sch.getStart());
		System.out.println("###part : "+sch.getPart());
		d.addAttribute("deptList", service.deptList());
		d.addAttribute("memList3", service.showMem3(sch));
		return "contacts-list3";
	}

	// http://localhost:7080/pms/manpower.do?method=contacts_profile
	@RequestMapping(params = "method=contacts_profile")
	public String contacts_profile(Model d,
			@RequestParam("pno") int pno,
			MemberSch sch) {
		  d.addAttribute("memDetail",service.memList2(pno)); 
		  ArrayList<pms_project> proList = new ArrayList<pms_project>(); 
		  for(int i=0;i<service.projectpno(pno).size();i++) {
			  proList.add(service.project(service.projectpno(pno).get(i).getProject_no()));
		  } 
		  d.addAttribute("proList",proList);
		return "contacts-profile";
	}

	/*
	@RequestMapping(params="method=update")  // 태스크 수정 
	public String updateTask(Task t,Model d) {
		service.updateTask(t);
		d.addAttribute("success","Y");
		return "pageJsonReport";
	}
	*/
	

	// http://localhost:7080/pms/manpower.do?method=add_member
	@PostMapping(params = "method=add_member")
	public String add_member(Member ins, Model d){
		System.out.println("####등록전번호####: "+service.getMaxPnoId());
		service.addMember(ins);
		System.out.println("####등록후번호####: "+service.getMaxPnoId());
		d.addAttribute("new",service.getMaxPnoId());
		d.addAttribute("success","Y");		
		return "pageJsonReport";
	}
	
	// http://localhost:7080/pms/manpower.do?method=delete_member
	@RequestMapping(params="method=delete_member")
	public String deleteMember(int pno) {
		service.deleteMember(pno);
		return "pageJsonReport";
	}

	// http://localhost:7080/pms/manpower.do?method=showProject
	@RequestMapping(params="method=showProject")
	public String showProject(Model d,
			@RequestParam("pno") int pno) {
		System.out.println("## no:"+pno);
		System.out.println("## 데이터 건수:"+service.allProject(pno).size());
		//allProject
		d.addAttribute("allProject",service.allProject(pno));
		return "pageJsonReport";
	}		
	// http://localhost:7080/pms/manpower.do?method=addProject
	@RequestMapping(params="method=addProject")
	public String addProject(Model d) {
		return "pageJsonReport";
	}
	@RequestMapping(params="method=showAuth")
	public String showAuth(Model d,
			@RequestParam("pno") int pno) {
		d.addAttribute("memAuth",service.memList2(pno));
		return "pageJsonReport";
	}
	// http://localhost:7080/pms/manpower.do?method=alertAuth
	@PostMapping(params="method=alertAuth")
	public String alertAuth(Model d, Member member) {
		service.alertAuth(member);
		return "pageJsonReport";
	}
	

	// http://localhost:7080/pms/manpower.do?method=insertProject
	@PostMapping(params="method=insertProject")
	public String insertProject(Model d, Member member,
			@RequestParam("pno") int pno,
			@RequestParam("project_no") int project_no) {
		service.insertProject(member);
		System.out.println("## json Pno:"+pno);
		System.out.println("## json project_no:"+project_no);
		return "pageJsonReport";
	}
	
	// http://localhost:7080/pms/manpower.do?method=chId
	@RequestMapping(params="method=chId")
	public String chId(@RequestParam("id") String id, Model d) {
		int idCnt = service.chId(id);
//		System.out.println("아이디 수:"+idCnt);
//		if(idCnt==0&&id!="") {
//			d.addAttribute("success","Y");
//		}else {
//			d.addAttribute("success","N");
//		}
		d.addAttribute("id",idCnt);
		System.out.println("####id:"+id);
		return "pageJsonReport";
	}
	// http://localhost:7080/pms/manpower.do?method=chEmail
	@RequestMapping(params="method=chEmail")
	public String chEmail(@RequestParam("email") String email,
			Model d) {
		int emailCnt = service.chEmail(email);
//		if(emailCnt==0&&email!="") {
//			d.addAttribute("success","Y");
//		}else {
//			d.addAttribute("success","N");
//		}
		d.addAttribute("email",emailCnt);
		System.out.println("####email:"+email);
		return "pageJsonReport";
	}	

	@RequestMapping(params="method=signAble")
	public String signAble(@RequestParam("emailCheck") int emailCheck, 
			@RequestParam("pwdCheck") int pwdCheck, 
			@RequestParam("idCheck") int idCheck,
			Model d) {
		if(emailCheck==1&&idCheck==1&&pwdCheck==1) {
			d.addAttribute("success","Y");
		}else 
			d.addAttribute("success","N");
		return "pageJsonReport";
	}				
	
	@ModelAttribute("showprofile")  // 멤버 프로필 사진 공통 어트리뷰트  
	public Member showMember(HttpSession session){
		Member m = (Member)session.getAttribute("mem");
		int pno=0;
		if(m!=null) pno = m.getPno();
		return service2.showProfile(pno);
	}
}






