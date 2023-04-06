from selenium import webdriver
from selenium.webdriver.firefox.options import Options

options = Options()
options.headless = True

# specify the path to geckodriver
driver_path = '/path/to/geckodriver'
driver = webdriver.Firefox(options=options, executable_path=driver_path)

# navigate to a website
driver.get('https://www.google.com')

# print the page title
print(driver.title)

# close the browser
driver.quit()
