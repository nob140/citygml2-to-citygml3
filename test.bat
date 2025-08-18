REM javac -sourcepath src -d test src\Transform.java
javac -sourcepath src -d test -cp test\Saxon-HE-12.5.jar src\Transform.java
copy /Y xsl\*.xsl test
cd test
REM java Transform
java -cp "Saxon-HE-12.5.jar;xmlresolver-5.2.2.jar;." Transform
cd ..
