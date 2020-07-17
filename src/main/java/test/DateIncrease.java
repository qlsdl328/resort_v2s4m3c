package test;
 
import java.text.DecimalFormat;
 
public class DateIncrease {
  public static void main(String[] args) { 
    String str = "201612";
    int start=1;
    int end = 31;
    String date="";
    DecimalFormat df = new DecimalFormat("00"); // 형식 지정
    for (start=1; start <= end; start++) {
      date = str+df.format(start);
      System.out.println(date);
    }
  }
}
 