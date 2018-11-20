# example to run script:
# ./run_antler.sh smoolaParser program

export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"

./clean.sh $1

# antler4 test.g4
java -jar /usr/local/lib/antlr-4.7.1-complete.jar $1Lexer.g4
java -jar /usr/local/lib/antlr-4.7.1-complete.jar $1Parser.g4

javac *.java
java org.antlr.v4.gui.TestRig $1 $2 -gui < in.sml

./clean.sh $1