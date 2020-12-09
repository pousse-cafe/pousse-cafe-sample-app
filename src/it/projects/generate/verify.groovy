def testProjectDirectory = new File("target/test-classes/projects/generate/project/my-app/")

def processClassFile = new File(testProjectDirectory, "src/main/java/mymodule/process/MyProcess.java")
assert processClassFile.exists() : processClassFile.getAbsolutePath() + " does not exist"

def aggregateRootClassFile = new File(testProjectDirectory, "src/main/java/mymodule/model/myaggregate/MyAggregateRoot.java")
assert aggregateRootClassFile.exists() : aggregateRootClassFile.getAbsolutePath() + " does not exist"
