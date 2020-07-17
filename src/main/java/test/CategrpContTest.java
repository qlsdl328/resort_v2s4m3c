package test;
 
import javax.inject.Inject;
 
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;
 
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations ={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class CategrpContTest {
  
  private static final Logger logger = LoggerFactory.getLogger(CategrpContTest.class);
 
  @Inject
    private WebApplicationContext wac; // Tomcat 서버에서의 요청인것으로 작동함
 
    private MockMvc mockMvc;
    
    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
        logger.info("setup............");
    }
 
    // INSERT INTO categrp(categrpno, classification, name, seqno, visible, rdate)
    // VALUES(1, 1, '여행', 1, 'Y', sysdate);
    
    // Controller GET 방식 요청 테스트, jsp view 이동은 체크 안함.
/*    @Test
    public void testCreateGet() throws Exception{
      mockMvc.perform(MockMvcRequestBuilders.get("/categrp/create.do"));
    }*/
 
    // Controller POST 방식 요청 테스트
/*   @Test
    public void testCreatePost() throws Exception{
      // 파라미터 전송
      MultiValueMap<String, String> multiValueMap = new LinkedMultiValueMap<>();
      multiValueMap.add("name", "여름 여행");
      multiValueMap.add("seqno", "15");          // 숫자도 문자열로 값을 지정
      multiValueMap.add("visible", "Y");
          
      mockMvc.perform(MockMvcRequestBuilders.post("/categrp/create.do").params(multiValueMap));
      
    }*/
    
    
}