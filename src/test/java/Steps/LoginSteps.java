package Steps;

import base.DriverUtils;
import cucumber.api.PendingException;
import cucumber.api.java8.En;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by yasassri on 3/15/17.
 */
public class LoginSteps extends DriverUtils implements En {
    public LoginSteps() {

        And("^enter the username as \"([^\"]*)\" and \"([^\"]*)\" as admin$", (String arg0, String arg1) -> {
            // Write code here that turns the phrase above into concrete actions
        });
        Given("^I'm on API Publisher login page$", () -> {
//            driver.navigate().to("https://google.com");
            // Write code here that turns the phrase above into concrete actions
        });
        And("^click login button$", () -> {
            // Write code here that turns the phrase above into concrete actions
        });
        Then("^I should see the publisher page$", () -> {
            // Write code here that turns the phrase above into concrete actions
        });
        And("^enter the username as \"([^\"]*)\" and password as \"([^\"]*)\"$", (String arg0, String arg1) -> {
            // Write code here that turns the phrase above into concrete actions
            Assert.assertEquals("abc","www");
        });
        And("^enter ([^\"]*) and ([^\"]*)$", (String username, String password) -> {
            // Write code here that turns the phrase above into concrete actions
        });
        When("^I enter the username as \"([^\"]*)\" and \"([^\"]*)\" as admin$", (String arg0, String arg1) -> {
            // Write code here that turns the phrase above into concrete actions
        });
        And("^I enter ([^\"]*) and ([^\"]*)$", (String args0, String args1) -> {
            // Write code here that turns the phrase above into concrete actions
            //throw new PendingException();
        });
    }
}
