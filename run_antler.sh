# example to run script:
# ./run_antler.sh Smoola program

export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"
rm *.class
rm *.tokens
rm $1*Parser.java
rm $1*Lexer.java
rm $1*.java


# antler4 test.g4
java -jar /usr/local/lib/antlr-4.7.1-complete.jar $1Lexer.g4
java -jar /usr/local/lib/antlr-4.7.1-complete.jar $1Parser.g4


javac *.java
java org.antlr.v4.gui.TestRig $1 $2 -gui < in.sml