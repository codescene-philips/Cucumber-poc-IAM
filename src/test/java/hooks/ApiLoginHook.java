package hooks;

import base.DriverUtils;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java8.HookBody;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

/**
 * Created by yasassri on 3/17/17.
 */
public class ApiLoginHook extends DriverUtils{

    private DriverUtils driverUtil;

    public ApiLoginHook(DriverUtils driver){
        this.driverUtil = driver;
    }

    @Before
    public void InitializeTheDrive(){
        System.out.println("INitializing the Firefox Driver.");
        System.setProperty("webdriver.gecko.driver","/home/yasassri/soft/Sellenium/geckodriver-v0.14.0-linux64/geckodriver");
        driverUtil.driver = new FirefoxDriver();
    }

    @After
    public void RemoveTheDrive(){

    }

}
