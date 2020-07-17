package dev.mvc.vis;

/*
CREATE TABLE vis (
    visno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    code                          VARCHAR(10)       NOT NULL,  
    title                           VARCHAR(100)     NOT NULL,  
    data                          VARCHAR(500)     NOT NULL,
    rdate                         DATE     NOT NULL
);
*/
public class VisVO {
  private int visno;
  private String code;
  private String title;
  private String data;
  private String rdate;
  public int getVisno() {
    return visno;
  }
  public void setVisno(int visno) {
    this.visno = visno;
  }
  public String getCode() {
    return code;
  }
  public void setCode(String code) {
    this.code = code;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getData() {
    return data;
  }
  public void setData(String data) {
    this.data = data;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

}