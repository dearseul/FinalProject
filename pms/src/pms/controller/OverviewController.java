package pms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import pms.dto.Log;
import pms.dto.Task;
import pms.service.OverviewService;
import pms.service.ProjectService;

@Controller
@RequestMapping("/task.do")
public class OverviewController {
	@Autowired(required = false)
	private OverviewService service;
	@Autowired(required = false)
	private ProjectService pservice;
	
	//  http://localhost:7080/pms/task.do?method=list
	@RequestMapping(params="method=list")
	public String taskList(@RequestParam("no") int no,Task task, Model d) {
		d.addAttribute("TaskList", service.TaskList(no));
		d.addAttribute("TaskList2", service.TaskList2(no));

		System.out.println(task.getPno());
		return "task_list";
	}
	
//  http://localhost:7080/pms/task.do?method=view
	@RequestMapping(params="method=view")
	public String overview(@RequestParam("no") int no, Model d) {
		d.addAttribute("pms_project", pservice.getProject(no));
		return "overview";
	}

//  http://localhost:7080/pms/task.do?method=log
	@RequestMapping(params="method=log")
	public String taskLog(@RequestParam("no") int no,Log log, Model d) {
		d.addAttribute("LogList",service.LogList(no));
		return "log";
	}
}
