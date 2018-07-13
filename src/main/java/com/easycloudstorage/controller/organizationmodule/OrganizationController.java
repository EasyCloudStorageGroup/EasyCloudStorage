package com.easycloudstorage.controller.organizationmodule;

import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.pojo.User;
import com.easycloudstorage.service.filemodule.FileService;
import com.easycloudstorage.service.organizationmodule.OrganizationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class OrganizationController {
    @Autowired
    private OrganizationService organizationService;
    @Autowired
    private FileService fileService;

    //点击某一个组织之后，进入这个controller
    @RequestMapping("enterOrganization")
    public String enterOrganization(int orgId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        boolean isMember = organizationService.isMember(user.getAccountId(), orgId);
        if(!isMember)
            return "organization/home/404";
        else {
            session.setAttribute("orgId", orgId);

            return "redirect:orgHomePage";
        }
    }

    public void toTheDir(Integer dirId, HttpSession session) {
        int orgId = (Integer) session.getAttribute("orgId");
        User user = (User) session.getAttribute("user");
        Directory root = fileService.makeVisibleFileSys(user.getAccountId(), orgId);

        if(dirId == null) {
            session.setAttribute("currentDir", root);
            return;
        }
        else {
            List<Directory> unVisitedDirs = new ArrayList<>();
            for(Directory d : root.getChildDirectories()) {
                unVisitedDirs.add(d);
            }

            int index = 0;
            while(unVisitedDirs.size() != 0)
            {
                Directory nowDir = unVisitedDirs.get(index);
                if(nowDir.getDirId() == dirId) {
                    session.setAttribute("currentDir", nowDir);
                    return;
                }
                else {
                    unVisitedDirs.remove(index);
                    for(Directory d : nowDir.getChildDirectories())
                        unVisitedDirs.add(d);
                }
            }
        }
        session.removeAttribute("currentDir");
    }

    @RequestMapping("orgHomePage")
    public ModelAndView orgHomePage(Integer dirId, HttpSession session) {
        int orgId = (Integer) session.getAttribute("orgId");
        Organization organization = organizationService.getByOrgId(orgId);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("organization/home/orgHomePage");
        mv.addObject("organization", organization);

        toTheDir(dirId, session);

        return mv;
    }
}
