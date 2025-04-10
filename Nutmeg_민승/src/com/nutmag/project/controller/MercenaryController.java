package com.nutmag.project.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nutmag.project.dao.IMercenaryDAO;
import com.nutmag.project.dto.MercenaryDTO;

@Controller
public class MercenaryController
{
    @Autowired
    private IMercenaryDAO dao;
    
    
    @RequestMapping("/MercenaryList.action")
    public String mercenaryList(@RequestParam(value = "searchField", required = false) String searchField,
                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                Model model)
    {
        int itemsPerPage = 10;
        int offset = (page - 1) * itemsPerPage;
        
        List<MercenaryDTO> list;
        int totalCount;

        if (searchField != null && searchKeyword != null && !searchKeyword.trim().isEmpty())
        {
            list = dao.searchMercenaryListPaginated(searchField, "%" + searchKeyword + "%", offset, itemsPerPage);
            totalCount = dao.searchCount(searchField, "%" + searchKeyword + "%");
        }
        else
        {
            list = dao.mercenaryListPaginated(offset, itemsPerPage);
            totalCount = dao.totalCount();
        }

        int totalPages = (int)Math.ceil((double)totalCount / itemsPerPage);
        
        int blockSize = 10; // 페이지네이션 블록 수
        int startPage = ((page - 1) / blockSize) * blockSize + 1;
        int endPage = startPage + blockSize - 1;
        if (endPage > totalPages)
            endPage = totalPages;
        System.out.println("=== 페이지네이션 디버깅 ===");
        System.out.println("현재 페이지: " + page);
        System.out.println("전체 데이터 개수: " + totalCount);
        System.out.println("총 페이지 수: " + totalPages);
        System.out.println("페이지 블록: " + startPage + " ~ " + endPage);

        
        model.addAttribute("list", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        
        return "/mercenary/mercenaryHire";
    }
	
   
		}
    
   
