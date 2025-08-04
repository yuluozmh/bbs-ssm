package com.liang.controller;

import com.liang.code.ReturnT;
import com.liang.service.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.liang.bean.Admin;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/rest/nansin/v3.0/admin")
@SessionAttributes(value = {"sessionAname", "sessionAcreateTime"})
@CrossOrigin
@Api(tags = "管理员数据接口")
public class AdminController {
    @Autowired
    AdminService adminService;
    @Autowired
    UserService userService;
    @Autowired
    ArticleService articleService;
    @Autowired
    PlateService plateService;
    @Autowired
    VisitService visitService;

    @ApiOperation(value = "管理员登录", notes = "管理员登录")
    @PostMapping("/getLogin")
    public ReturnT<?> getLogin(@Validated Admin admin, Model model) {
        try {
            // 调用管理员查询方法
            admin = adminService.getAdmin(admin);
            if (admin != null) {
                model.addAttribute("sessionAname", admin.getAname());
                model.addAttribute("sessionAcreateTime", admin.getCreateTime().getTime());
                return ReturnT.success("登录成功");
            } else {
                return ReturnT.fail(HttpStatus.NOT_FOUND, "用户名或密码错误");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("登录失败");
        }
    }

    @ApiOperation(value = "获取用户、文章、板块、访问总数", notes = "获取用户、文章、板块、访问总数")
    @GetMapping("/getUserArticlePlateVisitSum")
    public ReturnT<?> getUserArticlePlateVisitSum() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("userSum", userService.getCount());
            map.put("articleSum", articleService.getCount());
            map.put("plateSum", plateService.getCount());
            map.put("visitSum", visitService.getCount());
            return new ReturnT<>(HttpStatus.OK, "获取仪表盘数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取仪表盘数据失败");
        }
    }

    @ApiOperation(value = "退出管理员登录", notes = "退出管理员登录")
    @GetMapping("/adminExit")
    public ReturnT<?> adminExit(HttpServletRequest request, SessionStatus sessionStatus) {
        try {
            HttpSession session = request.getSession();
            session.removeAttribute("sessionAname");
            session.removeAttribute("sessionAcreateTime");
            // 只清除@SessionAttributes的session，不会清除HttpSession的数据
            System.out.println(sessionStatus);
            sessionStatus.setComplete();
            return ReturnT.success("退出登录成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("退出登录失败");
        }
    }
}
