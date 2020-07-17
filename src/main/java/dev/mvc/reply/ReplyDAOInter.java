package dev.mvc.reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ReplyDAOInter {
  /**
   * ´ñ±Û µî·Ï
   * @param replyVO
   * @return
   */
  public int create(ReplyVO replyVO);
  
  /**
   * ¸®½ºÆ®
   * @return
   */
  public List<ReplyVO> list();
  
  /**
   * ÄÁÅÙÃ÷ º° ´ñ±Û ¸®½ºÆ®
   * @param contentsno
   * @return
   */
  public List<ReplyVO> list_by_contentsno(int contentsno);
  
  public List<ReplyMemberVO> list_by_contentsno_join(int contentsno);
  
  public int checkPasswd(Map<String, Object> map);

  public int delete(int replyno);
  
  public List<ReplyMemberVO> list_by_contentsno_join_add_view(HashMap<String, Object> map);

  public ReplyMemberVO read(int replyno);
}