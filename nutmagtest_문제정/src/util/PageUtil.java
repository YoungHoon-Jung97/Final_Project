package util;

public class PageUtil 
{
    // 현재 페이지
    private int currentPage;
    
    // 전체 게시글 수
    private int totalCount;
    
    // 한 페이지에 표시할 게시글 수
    private int listCount;
    
    // 한 페이지에 표시할 페이지 번호 수
    private int pageCount;
    
    // 전체 페이지 수
    private int totalPage;
    
    // 시작 페이지 번호
    private int startPage;
    
    // 끝 페이지 번호
    private int endPage;
    
    // 데이터베이스에서 가져올 시작 위치
    private int start;
    
    // 데이터베이스에서 가져올 끝 위치
    private int end;
    
    // 생성자
    public PageUtil(int currentPage, int totalCount) 
    {
        this(currentPage, totalCount, 10, 5);
    }
    
    public PageUtil(int currentPage, int totalCount, int listCount, int pageCount) 
    {
        this.currentPage = currentPage;
        this.totalCount = totalCount;
        this.listCount = listCount;
        this.pageCount = pageCount;
        
        // 전체 페이지 수 계산
        totalPage = (int)Math.ceil((double)totalCount / listCount);
        
        // 현재 페이지가 범위를 벗어나면 조정
        if (currentPage < 1)
            this.currentPage = 1;
        if (currentPage > totalPage && totalPage > 0)
            this.currentPage = totalPage;
        
        // 시작 페이지와 끝 페이지 계산
        startPage = ((this.currentPage - 1) / pageCount) * pageCount + 1;
        endPage = startPage + pageCount - 1;
        
        // 끝 페이지가 전체 페이지 수보다 크면 조정
        if (endPage > totalPage)
            endPage = totalPage;
        
        // 데이터베이스에서 가져올 위치 계산
        start = (this.currentPage - 1) * listCount + 1;
        end = start + listCount - 1;
    }
    
    // Getter 메서드
    public int getCurrentPage() {
        return currentPage;
    }
    
    public int getTotalCount() {
        return totalCount;
    }
    
    public int getListCount() {
        return listCount;
    }
    
    public int getPageCount() {
        return pageCount;
    }
    
    public int getTotalPage() {
        return totalPage;
    }
    
    public int getStartPage() {
        return startPage;
    }
    
    public int getEndPage() {
        return endPage;
    }
    
    public int getStart() {
        return start;
    }
    
    public int getEnd() {
        return end;
    }
    
    // 페이징 HTML 생성 메서드
    public String getPageHtml(String urlFormat) 
    {
        StringBuilder html = new StringBuilder();
        
        // 이전 페이지 블록으로 이동
        if (startPage > 1) 
        {
            html.append("<a href=\"").append(String.format(urlFormat, startPage - 1))
                .append("\" class=\"page-link\">&laquo;</a>");
        }
        
        // 페이지 번호
        for (int i = startPage; i <= endPage; i++) 
        {
            if (i == currentPage) 
            {
                html.append("<a href=\"#\" class=\"page-link active\">").append(i).append("</a>");
            } 
            else 
            {
                html.append("<a href=\"").append(String.format(urlFormat, i))
                    .append("\" class=\"page-link\">").append(i).append("</a>");
            }
        }
        
        // 다음 페이지 블록으로 이동
        if (endPage < totalPage) 
        {
            html.append("<a href=\"").append(String.format(urlFormat, endPage + 1))
                .append("\" class=\"page-link\">&raquo;</a>");
        }
        
        return html.toString();
    }
}