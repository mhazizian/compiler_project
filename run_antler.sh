# example to run script:
# ./run_antler.sh Smoola program

export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"

./clean.sh $1

# antler4 test.g4
java -jar /usr/local/lib/antlr-4.7.1-complete.jar $1.g4

javac *.java
java org.antlr.v4.gui.TestRig $1 $2 -gui < in2.sml

./clean.sh $1
