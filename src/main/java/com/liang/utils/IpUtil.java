package com.liang.utils;

import java.net.*;
import java.util.Map;
import java.util.StringTokenizer;

import com.liang.bean.Visit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public class IpUtil {
    @Autowired
    QueryIp queryIp;

    /**
     * 构造Visit
     *
     * @param ip
     * @param os 操作系统
     * @return
     */
    public Visit getVisit(String ip, String os) {
        // 区域信息
        Map<String, Object> map;
        Visit visit = new Visit();
        visit.setVisitip(ip);
        visit.setVisitos(os);
        // 主机名
        String hostName;
        try {
            hostName = InetAddress.getLocalHost().getHostName();
            visit.setVisithostname(hostName);
        } catch (UnknownHostException e1) {
            e1.printStackTrace();
        }
        map = queryIp.queryIP(ip);
        if (map.get("country") != null) {
            visit.setVisitcountry(map.get("country").toString());
        }
        if (map.get("region") != null) {
            visit.setVisitprovince(map.get("region").toString());
        }
        if (map.get("city") != null) {
            visit.setVisitcity(map.get("city").toString());
        }

        return visit;
    }

    /**
     * 获取访问者操作系统
     *
     * @param request
     * @return
     */
    public String getOS(HttpServletRequest request) {
        String agent = request.getHeader("User-Agent");
        StringTokenizer st = new StringTokenizer(agent, ";");
        st.nextToken();
        // 得到访问者的操作系统名
        String os = st.nextToken();

        // 优化操作系统名 win
        boolean isWin2K = agent.contains("Windows NT 5.0") || agent.contains("Windows 2000");
        if (isWin2K) os = "Windows 2000";
        boolean isWinXP = agent.contains("Windows NT 5.1") || agent.contains("Windows XP");
        if (isWinXP) os = "Windows XP";
        boolean isWin2003 = agent.contains("Windows NT 5.2") || agent.contains("Windows 2003");
        if (isWin2003) os = "Windows 2003";
        boolean isWinVista = agent.contains("Windows NT 6.0") || agent.contains("Windows Vista");
        if (isWinVista) os = "Windows Vista";
        boolean isWin7 = agent.contains("Windows NT 6.1") || agent.contains("Windows 7");
        if (isWin7) os = "Windows 7";
        boolean isWin8 = agent.contains("Windows NT 6.2") || agent.contains("Windows NT 6.3") || agent.contains("Windows 8");
        if (isWin8) os = "Windows 8";
        boolean isWin10 = agent.contains("Windows NT 10") || agent.contains("Windows 10");
        if (isWin10) os = "Windows 10";
        // mac
        boolean mac = agent.contains("Mac OS X");
        if (mac) os = "Mac OS X";
        // linux
        boolean linux = agent.contains("Linux x86_64");
        if (linux) os = "Linux x86_64";
        // Android 5.0) AppleWebKit
        boolean android = agent.contains("Android 5.0) AppleWebKit");
        if (android) os = "Android 5.0";

        return os;
    }

    /**
     * 获取访问者ip
     *
     * @param request
     * @return
     */
    public String getIP(HttpServletRequest request) {
        String ip = null;
        /**
         * X-Forwarded-For:简称XFF头，它代表客户端，也就是HTTP的请求端真实的IP 只有在通过了HTTP 代理或者负载均衡服务器时才会添加该项
         * 标准格式如下：X-Forwarded-For: client_ip, proxy1_ip, proxy2_ip
         * 此头是可构造的，因此某些应用中应该对获取到的ip进行验证
         */
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
            ip = request.getHeader("X-Real-IP");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
            ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
            ip = request.getHeader("Proxy-Client-IP");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
            ip = request.getHeader("WL-Proxy-Client-IP");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
            ip = request.getRemoteAddr();
        /**
         * 在多级代理网络中，直接用getHeader("x-forwarded-for")可能获取到的是unknown信息
         * 此时需要获取代理代理服务器重新包装的HTTP头信息，
         */
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
            ip = request.getRemoteAddr();
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
            ip = request.getHeader("Proxy-Client-IP");
        if (ip == null || ip.length() == 0 || "unknow".equalsIgnoreCase(ip))
            ip = request.getHeader("WL-Proxy-Client-IP");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
            ip = request.getHeader("HTTP_CLIENT_IP");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");

        return ip;
    }
}
