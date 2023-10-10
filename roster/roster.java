import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.File; 
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.Scanner;
import java.io.FileWriter;   // Import the FileWriter class
import java.io.IOException;

public class RosterReader {

   public static void main( String args[] ) throws IOException {
      // String to be scanned to find the pattern.
      String line1 = "BAUTISTA, DORIS MAR 12 F 001 12026735";
      
      // PAGE DIVIDER 1
      String patternPage1 = ".*\\bLEWISVILLE H S\\b";
      
      // PAGE DIVIDER 2
      String patternPage2 = ".*\\bClass Roster\\b";
      
      
      // CLASS HEADER
      String patternClass = "(.*\\bCLASS :\\b)(\\d+[/]\\d+)(\\D+)(.*\\bTEACHER\\b)";
      String line2 = "FOR TCHR:LEASE KJEIL THOMAS LEASE,K 001 E205 1-2 2 MTWRF";
      String patternTeacher = "(.*\\bFOR TCHR:\\b)(\\D+)([,])([A-Z ]+)(\\d+[ ])(.*[A-Z0-9]+)(.*\\d[-]\\d)";
      String patternCorType = "\\bCOR \\b";
      
      
      String patternSubject = "(.*\\bSUBJECT :\\b)(\\b\\D{1,15}\\b)";
      String patternLength = "(.*\\bLENGTH :\\b)(\\d+)(.*\\bWEEK\\b)(\\b - \\b)(\\d+)(\\b SEM\\b)";
      String patternTerm = ".*\\bTERM :\\b";
      String patternStudentHeader = ".*\\bSTUDENT NAME GD G TM ENT OTHER ID\\b";
      // PAGE DIVIDER 2
      //String pattern = ".*\\bClass Roster\\b";
      
      //    Student line
      
      String patternStudent = "(\\D+)(\\d+)(.[M,F])[ ](\\d+)[ ](\\d+)";

// end of roster
      String patternEndCount = "[=][M][ ]\\d+[=][F]";
      
      // Create a Pattern object
      Pattern rJunk1 = Pattern.compile(patternPage1);
      Pattern rJunk2 = Pattern.compile(patternPage2);
      Pattern rJunk3 = Pattern.compile(patternStudentHeader);
      Pattern rJunk4 = Pattern.compile(patternCorType);
      Pattern rClass = Pattern.compile(patternClass);
      Pattern rTeacher = Pattern.compile(patternTeacher);
      Pattern rSubject = Pattern.compile(patternSubject);
      Pattern rLength = Pattern.compile(patternLength);
      Pattern rStudent = Pattern.compile(patternStudent);
      Pattern rTerm = Pattern.compile(patternTerm);
      Pattern rEndCount = Pattern.compile(patternEndCount);
      int notFound = 0;
      boolean classIsSet = false;
      boolean teacherIsSet = false;
      String teacherName = "";
      String teacherEntity ="";
      String teacherRoom ="";
      String teacherSession ="";
      String classNum ="";
      String className ="";
      
      try{
    	  
      	  
      File myObj = new File("roster.txt");
      FileWriter outWriter = new FileWriter("output.txt");
      Scanner myReader = new Scanner(myObj);
      while (myReader.hasNextLine()) {
        String line = myReader.nextLine();
      // Now create matcher object.
      Matcher mJunk1 = rJunk1.matcher(line);
      Matcher mJunk2 = rJunk2.matcher(line);
      Matcher mJunk3 = rJunk3.matcher(line);
      Matcher mJunk4 = rJunk4.matcher(line);
      Matcher mSubject = rSubject.matcher(line);
      Matcher mLength = rLength.matcher(line);
      Matcher mTerm = rTerm.matcher(line);
      
      
      if (!(mJunk1.find( )||mJunk2.find( )||mJunk3.find( )||mJunk4.find( )
        ||mSubject.find( )||mLength.find( )||mTerm.find( )
      
      )) {
          Matcher mClass = rClass.matcher(line);
          Matcher mTeacher = rTeacher.matcher(line);
          Matcher mStudent = rStudent.matcher(line);
          Matcher mEndCount = rEndCount.matcher(line);
         
          
          if (mClass.find( )){
              
         classNum = mClass.group(2);
         className = mClass.group(3);
         
              classIsSet = true;
          //    System.out.println("Class");
          } else if (mTeacher.find( )){
              teacherIsSet = true;
              teacherName =  mTeacher.group(2);
              teacherEntity = mTeacher.group(5);
              teacherRoom = mTeacher.group(6);
              teacherSession =  mTeacher.group(7);
        //      System.out.println("Teacher");
          } else if (teacherIsSet && classIsSet && mStudent.find( )){
              // System.out.println
        	  outWriter.write
              (classNum + "\t" + className 
                + "\t" + teacherName + "\t" + teacherEntity 
                + "\t" + teacherRoom + "\t" + teacherSession
                + "\t" + mStudent.group(1) + "\t" + mStudent.group(2)
                + "\t" + mStudent.group(3) + "\t" + mStudent.group(4)
                + "\t" + mStudent.group(5) +"\n"
                );
                
                
              
          } else if (mStudent.find( )){
              System.out.println("Student wo/Data "+line);
              System.out.println(classNum + "\t" + className 
                      + "\t" + teacherName + "\t" + teacherEntity 
                      + "\t" + teacherRoom + "\t" + teacherSession
                      + "\t" + mStudent.group(1) + "\t" + mStudent.group(2)
                      + "\t" + mStudent.group(3) + "\t" + mStudent.group(4)
                      + "\t" + mStudent.group(5) +"\n"
                      );
          }else if (mEndCount.find( )){
              classIsSet = false;
              teacherIsSet = false;
              teacherName = "";
      teacherEntity ="";
      teacherRoom ="";
      teacherSession ="";
      classNum ="";
      className ="";
           //   System.out.println("end count");
          } else {
         //     System.out.println(">>>>>>>>>>>>>>>>"+ line);
          //    notFound++;
          }
          //System.out.println("Not Junk");
          
    /*     System.out.println("Found value: " + m.group(0) );
         System.out.println("Found value: " + m.group(1) );
         System.out.println("Found value: " + m.group(2) );
         System.out.println("Found value: " + m.group(3) );
         System.out.println("Found value: " + m.group(4) );
         System.out.println("Found value: " + m.group(5) );
      */}//else {          System.out.println("NO MATCH");      }
      } // while 
      myReader.close();
      outWriter.close();
   //   System.out.println(notFound);
      } catch (FileNotFoundException e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
    }
          
          
      }
}
