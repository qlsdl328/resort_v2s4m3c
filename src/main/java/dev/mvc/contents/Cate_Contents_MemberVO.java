package dev.mvc.contents;

import java.util.List;


import dev.mvc.member.MemberVO;

public class Cate_Contents_MemberVO {
  /** 회원 정보 */
  private MemberVO memberVO; // 성능에  큰 차이가 없음
  
  /** 카테고리 + 컨첸트 목록 */
  private List<Cate_Contents_VO> cate_contents_memberno_list;
  
  

  public MemberVO getMemberVO() {
    return memberVO;
  }

  public void setMemberVO(MemberVO memberVO) {
    this.memberVO = memberVO;
  }

  public List<Cate_Contents_VO> getCate_contents_memberno_list() {
    return cate_contents_memberno_list;
  }

  public void setCate_contents_memberno_list(List<Cate_Contents_VO> cate_contents_memberno_list) {
    this.cate_contents_memberno_list = cate_contents_memberno_list;
  }  
  


}
