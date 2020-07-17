package test; 
 
import java.text.DecimalFormat; 
 
public class IntegerTest { 
 
  public static void main(String[] args) { 
     
    int i = Integer.parseInt("00001");  // 정수만 추출
    i = i + 1;  // 2
     
    DecimalFormat df = new DecimalFormat("00000"); // 형식 지정
    String str = df.format(i); 
    System.out.println("00001 --> " + str); // 00002    
 
    System.out.println("--------------------------------"); 
    // i = Integer.parseInt("ABC00001");  // ERROR 
    i = Integer.parseInt("ABC00001".substring(3)); // 00001 추출
    i = i + 1;  // 2
     
    df = new DecimalFormat("ABC00000"); 
    str = df.format(i); 
    System.out.println("ABC00001 --> " + str); // ABC00002    
     
  } 
 
} 
 
 