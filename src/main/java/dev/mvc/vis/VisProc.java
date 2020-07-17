package dev.mvc.vis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.vis.VisProc")
public class VisProc implements VisProcInter {
  @Autowired
  private VisDAOInter visDAO;
  
  @Override
  public VisVO read_top_code(String code) {
    VisVO visVO = visDAO.read_top_code(code);
    return visVO;
  }

}