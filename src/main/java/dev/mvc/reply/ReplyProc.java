package dev.mvc.reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.contents.Contents;
import dev.mvc.tool.Tool;

@Component("dev.mvc.reply.ReplyProc")
public class ReplyProc implements ReplyProcInter {
  @Autowired
  private ReplyDAOInter replyDAO; 
  
  @Override
  public int create(ReplyVO replyVO) {
    int count = replyDAO.create(replyVO);
    return count;
  }

  @Override
  public List<ReplyVO> list() {
    List<ReplyVO> list = replyDAO.list();
    return list;
  }

  @Override
  public List<ReplyVO> list_by_contentsno(int contentsno) {
    List<ReplyVO> list = replyDAO.list_by_contentsno(contentsno);
    String content = "";
    
    // 특수 문자 변경
    for (ReplyVO replyVO:list) {
      content = replyVO.getContent();
      content = Tool.convertChar(content);
      replyVO.setContent(content);
    }
    return list;
  }

  @Override
  public List<ReplyMemberVO> list_by_contentsno_join(int contentsno) {
    List<ReplyMemberVO> list = replyDAO.list_by_contentsno_join(contentsno);
    String content = "";
    
    // 특수 문자 변경
    for (ReplyMemberVO replyMemberVO:list) {
      content = replyMemberVO.getContent();
      content = Tool.convertChar(content);
      replyMemberVO.setContent(content);
    }
    return list;
  }

  @Override
  public int checkPasswd(Map<String, Object> map) {
    int count = replyDAO.checkPasswd(map);
    return count;
  }

  @Override
  public int delete(int replyno) {
    int count = replyDAO.delete(replyno);
    return count;
  }

  @Override
  public List<ReplyMemberVO> list_by_contentsno_join_add_view(HashMap<String, Object> map) {
   int recprd_per_page =2;
   //nowPage 는 1부터 시작
    int beginOfPage = ((Integer)map.get("replyPage") - 1) * recprd_per_page; // 한페이지당 2건
    int startNum = beginOfPage + 1; 
    int endNum = beginOfPage + recprd_per_page; // 한페이지당 2건  
   /* 
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30

   */
    map.put("startNum", startNum);
    map.put("endNum", endNum);
      List<ReplyMemberVO> list = replyDAO.list_by_contentsno_join_add_view(map);
      String content = "";
      
      // 특수 문자 변경
      for (ReplyMemberVO replyMemberVO:list) {
        content = replyMemberVO.getContent();
        content = Tool.convertChar(content);
        replyMemberVO.setContent(content);
      }
      return list;
  }

  @Override
  public ReplyMemberVO read(int replyno) {
    
    return null;
  }
  
  
}