package runner;

import cucumber.api.testng.AbstractTestNGCucumberTests;
import cucumber.api.CucumberOptions;

//@RunWith(Cucumber.class)
@CucumberOptions(features = "src/test/java/Features",glue="Steps",format = {"json:target/cucumberResults.json","html:target/sites/cucumber-pretty"})
public class TestRunner extends AbstractTestNGCucumberTests{

}