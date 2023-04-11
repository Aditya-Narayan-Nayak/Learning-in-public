## How to Install Terraform on Windows


Download the installation file
1. Navigate to the Terraform download page (https://www.terraform.io/downloads.html). It should list out Terraform downloads for various platforms. Navigate to the Windows section and download the respective version.
![image17-1](https://user-images.githubusercontent.com/72183256/201460875-1b4f97c3-cb42-42d3-8ef2-88dd61e47105.png)

2. It will download a zip file. Create a folder on the C drive as C:/terraform. Download the zip file in this folder. Unzip the file to extract the .exe file.
![2](https://user-images.githubusercontent.com/72183256/201460901-96c602da-323d-414b-984e-2cf107812e66.png)

## Update Path Environment Variable
1. Next open the Start menu and search for Environment variables. Open the Environment variables settings page

![3](https://user-images.githubusercontent.com/72183256/201460949-782b899a-9206-45aa-a3e3-2fba06a10bc2.png)

2. On the Environment variables edit page, open the Path variable as shown below:

![image10-1-1](https://user-images.githubusercontent.com/72183256/201460998-40d43c9d-5054-43ed-bb2d-4d2cbc3c7851.png)

3. On the opened Path pop up, click New and add the Terraform download folder. This is the folder where the zip file was downloaded and unzipped (C:/terraform).add the Terraform download folder

![image4-2-1](https://user-images.githubusercontent.com/72183256/201461002-c7289874-27e7-4e2b-bb95-1c8f0c4bcd89.png)


4. Click OK on the above window to save the Path variable addition. If needed, restart your system to apply the variable changes.

![image20](https://user-images.githubusercontent.com/72183256/201461008-11c8b92b-f601-4fdb-a607-d97532a86e76.png)

5. Open a Command prompt and run this command to verify Terraform is installed successfully:

![image5-1](https://user-images.githubusercontent.com/72183256/201461010-693c3c8b-844c-4062-8c90-01f707a26a75.png)

verify if Terraform is installed successfully
Verify if the Correct Version of Terraform Is Installed
Just like below:
