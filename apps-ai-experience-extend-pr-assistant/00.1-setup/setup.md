# Introduction

## Introduction

Use these instructions to setup the Supplier_Stock VB app for the supplier inquiry as well as the API tool to use in the custom agent.

Estimated Completion Time: 20 minutes

### **Objectives**

Setup demo in new environment. You will:
- Add Supplier_Stock Visual Builder app and populate with data
- Add External REST tool to query Supplier_Stock Visual Builder app

### **Prerequisites**
- Visual Builder environment
- Purchase Requisition data accessible to demo user(s)

### **Notes**
- The provided instructions and Visual Builder application are provided as sample code and are not considered supported functionality.
- To give this lab to participants without the setup instructions, direct them to https://oracle-livelabs.github.io/oci/apps-ai-experience-extend-pr-assistant/workshops/tenancy/index.html

## Task 1: Download and install Supplier_Stock Visual Builder app

1. First login to your Visual Builder design app.

2. Import the Supplier_Stock Visual Builder app.  From Visual Builder home page, select Import:
    ![Create from import](images/create_import.png " ")

3. Select **Application from file**:

    ![application_from_file](images/application_from_file.png " ")

4. Download zip file **[HERE](files/Supplier_Stock.zip?download=1)** and drag it to **Drag and Drop** area, change application name if desired, and click Import:

    ![drag_drop_file](images/import_dialog.png " ")

## Task 2: Validate Application Security Settings


***IMPORTANT: The provided Visual Builder application has authentication and security set to allow anonymous access.  </br>Please change these if your organization requires a secure set up.***

1. Open your newly imported Visual Build Application:

    ![open_vb_app](images/open_vb_app.png " ")

2. Click on the ellipses in the upper right corner to bring up the application menu and click **Settings**:

    ![open_settings](images/open_settings.png " ")

3. Click on the **Business Objects** tab and note the security settings.  This app has been setup to allow anonymous API access.  Change these settings if secure access is desired:

    ![check_vb_security](images/check_vb_security.png " ")

4. Click on the **Business Object** icon &nbsp;![bo_icon](images/bo_icon.png =25x*)&nbsp; in the left margin, then select the **Inventory** Business Object, and select the **Security** tab.  Note that the security for this business object is configured to let anonymous users view the data, while authenticated users can change the data. Change these settings if desired:
    ![check_bo_security](images/check_bo_security.png " ")

## Task 3: Validate and Modify Seeded Application Data

1. Click on the **Data** tab to preview the seeded data.  You can make changes here to the data.  You should at least change any **availabilityDate** to a future date.  </br>If you are adding or modifying records, make sure that the **item** and **supplier** fields exactly match the data being returned by your Purchase Requisition.  </br>Note that you can also export this data to a .csv file, make changes and re-import.</br>You can also make changes later in the application if you open the application as an authenticated user.

    ![review_data](images/review_data.png " ")

## Task 4: Stage the Application and extract the API Endpoint URL

1. Next you will stage the application to make it available outside of the Visual Builder Design Tool.  Click on the ellipses in the upper right corner to bring up the application menu and click **Stage**:

    ![stage_application](images/stage_application.png " ")

2. Select **Populate Stage with Development data** and click **Stage**.  Note that once you stage the application, data in the Development version and the Staged version are kept separate.  Take care when making data changes that you modifying the correct version.

    ![confirm_stage](images/confirm_stage.png " ")


3. Click on the **Endpoints** tab, expand the **Resource APIs** section, and select the **Clipboard** icon &nbsp; ![clipboard_icon](images/clipboard_icon.png =25x*)&nbsp; next to the **Staging** URL in the **Data** column:

    ![get_endpoint_url](images/get_endpoint_url.png " ")

4. Save this endpoint URL to a text file.  You will need this in the next task when you create the External API tool.  It should be in the following format (if you changed the application name **supplier_stock** will instead be the name you selected):</br>
    ```
    https://<your_hostname>/ic/builder/rt/supplier_stock/1.0/resources/data/Inventory
    ```
## Task 5: Create the AIE Supplier Stock Inquiry API tool 

1. Login to Fusion and open AI Agent Studio (use casey.brown for Oracle demo environments)

2. Click on the **Tools** tab at the bottom of the screen:

    ![tools_tab](images/tools_tab.png " ")

3. Click the **+ Add** button:

    ![add_tool](images/add_tool.png " ")

4. Fill out the form as follows:

    | Field | Value |
    | -------- | ------- |
    | Tool Name | AIE Supplier Stock Inquiry Tool |
    | Family | PRC |
    | Product | Self Service Procurement |
    | Description | *(Description of your choice)* |
    {: title="Tool Form field values"}

    ![add_tool_form](images/add_tool_form.png " ")

5. Scroll down to the bottom of the form and click the **+ Add** button under the **Authorization** header:

    ![add_authorization](images/add_authorization.png " ")

6. For **Instance URL** enter the extracted URL from the previous task up to and including **/data**:

    ```txt
    SAMPLE:
    https://<your_hostname>/ic/builder/rt/supplier_stock/1.0/resources/data
    ```
7. If you did not change the Authorization settings in your Visual Builder app, select **None** for **Authentication**.  If you did make changes select the appropriate authentication type.

8. Enter an appropriate **Description** and click the **Functions** tab:

    ![add_authorization_form](images/add_authorization_form.png " ")

9. Click the **+Add** button:

    ![add_function](images/add_function.png " ")

10. Fill out the form as follows: 

    | Field | Value |
    | -------- | ------- |
    | Name | InventoryInquiry |
    | Operation Type | HTTP GET |
    | Description | *(Description of your choice)* |
    {: title="Endpoint Form field values"}

    For **Resource Path** click the **Copy** button below and paste the following:

    ```txt
    <copy>
    /Inventory?onlyData=true&q=supplier='{supplier}' AND item='{itemDescription}'
    </copy>
    ```
    ![add_endpoint](images/add_endpoint.png " ")

11. Click the **+Add** button under the **Parameters** heading:

    ![add_parameter_button](images/add_parameter_button.png " ")

12. Enter **supplier** for **Name** and **Description**.  Check the **URL Parameter** checkbox and click the **Save** button:

    ![add_supplier_parameter](images/add_supplier_parameter.png " ")

13. Click the **+Add** button under the **Parameters** heading to add a second parameter:

    ![add_second_supplier_button](images/add_second_supplier_button.png " ")

14. Enter **itemDescription** for **Name** and **Description**.  Check the **URL Parameter** checkbox and click the **Save** button:

    ![add_item_parameter](images/add_item_parameter.png " ")

15. Click the black **Add** button at the bottom right of the form:

    ![add_tool_black_button](images/add_tool_black_button.png " ")

15. Click the **Create** button at the top right of the screen:

    ![create_tool](images/create_tool.png " ")

[Proceed to the first lab to get test your agent!] (#next)

## Acknowledgements
* **Author** - [](var:author)
* **Last Updated By/Date** - [](var:last_updated)