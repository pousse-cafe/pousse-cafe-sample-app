def testProjectDirectory = new File("target/test-classes/projects/generate/project/my-app/")

def processClassFile = new File(testProjectDirectory, "src/main/java/mymodule/process/MyProcess.java")
assert processClassFile.exists() : processClassFile.getAbsolutePath() + " does not exist"

def aggregateClassFile = new File(testProjectDirectory, "src/main/java/mymodule/model/myaggregate/MyAggregate.java")
assert aggregateClassFile.exists() : aggregateClassFile.getAbsolutePath() + " does not exist"
