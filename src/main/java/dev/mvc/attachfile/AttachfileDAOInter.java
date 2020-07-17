package dev.mvc.attachfile;

import java.util.List;

public interface AttachfileDAOInter {
  /**
   * ���� ���  
   * @param attachfileVO
   * @return
   */
  public int create(AttachfileVO attachfileVO);
  
  /**
   * ��ü �̹��� ���
   * @return
   */
  public List<AttachfileVO> list(); 
  
  /**
   * ��ȸ
   * @param attachfileno
   * @return
   */
  public AttachfileVO read(int attachfileno);
  
  /**
   * ����
   * @param attachfileno
   * @return
   */
  public int delete(int attachfileno);
  
  /**
   *  contentsno�� ���� ���� ���
   * <xmp>
   * <select id="list_by_contentsno" resultType="AttachfileVO" parameterType="int">
   * </xmp>
   * @return
   */
  public List<AttachfileVO> list_by_contentsno(int contentsno);
  

}




