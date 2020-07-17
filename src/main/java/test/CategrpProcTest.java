package test;
 
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
 
import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;
 
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
    "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class CategrpProcTest {
 //Proc test
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc") // 할당되는 Class 객체의 이름
  private CategrpProcInter categrpProc = null;
 
  @Test
  public void testCreate() throws Exception {
 
    CategrpVO categrpVO = new CategrpVO();
 
//    INSERT INTO categrp(categrpno, name, seqno, visible, rdate, cnt)
//    VALUES((SELECT NVL(MAX(categrpno), 0) + 1 as categrpno FROM categrp),
//                '봄 여행', 1, 'Y', sysdate, 0);
 
    categrpVO.setName("취업 여행");
    categrpVO.setSeqno(10);
    categrpVO.setVisible("Y");
 
    System.out.println(categrpProc.create(categrpVO));
 
  }
 
}