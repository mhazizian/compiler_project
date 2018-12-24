# example to run script:
# ./run_antler.sh Smoola 

export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"

./clean.sh $1

# antler4 test.g4
java -jar /usr/local/lib/antlr-4.7.1-complete.jar $1.g4

javac *.java
java mySmoola in2.sml

./clean.sh $1
