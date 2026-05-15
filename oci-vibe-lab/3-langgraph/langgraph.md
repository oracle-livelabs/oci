# Vibe Coding - LangGraph 

## Introduction
In this lab, we will run the LangGraph application and modify it using Vibe Coding.

Estimated time: 10 min

### Objectives

- Test the install program and modify it using Cline.

### Prerequisites
- Lab 2 is complete.

## Task 1: Open the project in Visual Studio Code

During the installation, a Git repository was created on a virtual machine. We will clone this repository on your laptop so you can change it and commit the changes to the Git server.
 
1. Check that the URL given at the end of the installation with the chat is working.
    The URL looks like this: http://123.123.123.123/
2. Clone the Git repository of the starter app on your laptop. Start a shell in Visual Studio Code or in your favorite terminal, then run:
    ```
    <copy>
    git clone opc@123.123.123.123:~/app.git oci-vibe
    cd oci-vibe
    </copy>
    ```
3. Open the created folder **oci-vibe** with Visual Studio Code.
4. Make a small change. Go to ui/html/index.html.
5. Change:
    - OLD: How can I help?
    - NEW: Vibe Coding Lab
    ![Small Change](images/small-change1.png)  
6. Open the Visual Studio Code terminal. 
7. Run:
    ```
    <copy>
    ./git_push.sh   
    </copy>
    ```
8. Check the result in your chat URL: http://123.123.123.123/
    ![Small Change](images/small-change2.png)  

## Task 2: Generate documentation of the program

Let's ask Cline to do things for us.
1. Go to Cline.
2. In the prompt, type:
    ```
    <copy>
    Check all the code of the project and create two documentation files:
    - README.md for end-users
    - AGENTS.md for technical documentation for developers and coding agents
    </copy>
    ```
3. Check the output.

    ![Documentation](images/readme_agents_md.png)  

## Task 3: Change the program using Vibe Coding

Let's ask Cline to add code for a table using Python.
1. Go to Cline.
2. In the prompt, type:
    ```
    <copy>
    Add a new EMP table in oracle.sql and a new get_emp tool in mcp_server.py.
    </copy>
    ```
3. Check the output

    ![Documentation](images/emp1.png)  

4. When you are happy about the result, push it.
    ```
    <copy>
    ./git_push.sh   
    </copy>
    ```
5. Check the result in your chat URL: http://123.123.123.123/
6. Ask: "get employees"

    ![Documentation](images/emp2.png)  


## Task 4: Other test

You could try other things like.

1. Go to Cline.
2. In the prompt, type:
    ```
    <copy>
    Modify mcp_server.py to add tools to create bookings in a restaurant (VibeCook)
    - The user will be logged by default. He will be named "Joe Doe". 
    - The program knows the user's allergies. 
    - When booking, propose available times when tables are free. 
    - The data about booking is stored in the database.
    - There are 30 places in the restaurant. There are 2 services at 18:00 and 19:30. 
    - You can book only today and tomorrow.
    - If the restaurant is full, propose calling later.
    - Add a tool with a menu. When showing the menu, take care of the allergies
    - In MCP tools comments, please insist on the date and time format: YYYY-DD-MM and HH24:MI
    - In MCP tools, be resilient to mistake of LLMs. Accept that all parameters are sent with None. None is the default value. If a parameter is missing and return a clean error to the LLM asking him about the mandatory parameters.
    </copy>
    ```
...
3. Same than above. Git push and check the result. 
4. Try: "book a restaurant tonight at 6PM for 4 people"

Based on the model chosen, the result will be different.  

## Acknowledgements

- **Author**
    - Marc Gueury, AI Agents Black Belt
    - Ilayda Temir, Generative AI Black Belt
