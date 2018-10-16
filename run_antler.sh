export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"
rm *.class
rm *.tokens
rm $1*.java

# antler4 test.g4
java -jar /usr/local/lib/antlr-4.7.1-complete.jar $1.g4


javac *.java
java org.antlr.v4.gui.TestRig $1 $2 -gui < in.sml