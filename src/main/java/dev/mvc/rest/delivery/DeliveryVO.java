package dev.mvc.rest.delivery;

public class DeliveryVO {
    
    private long deliveryno;
    private String title;
    private String content;
    private String writer;
    private String rdate;
    
  public DeliveryVO() {

  }
  /**
   * @param boardNo
   * @param title
   * @param content
   * @param writer
   * @param rdate
   */
  public DeliveryVO(long deliveryno, String title, String content, String writer, String rdate) {
    super();
    this.deliveryno = deliveryno;
    this.title = title;
    this.content = content;
    this.writer = writer;
    this.rdate = rdate;
  }
  public long getDeliveryno() {
        return deliveryno;
    }
    public void setDeliveryno(long deliveryno) {
        this.deliveryno = deliveryno;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getWriter() {
        return writer;
    }
    public void setWriter(String writer) {
        this.writer = writer;
    }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
  @Override
  public String toString() {
    return "BoardVO [deliveryno=" + deliveryno + ", title=" + title + ", content=" + content + ", writer=" + writer
        + ", rdate=" + rdate + "]";
  }


}