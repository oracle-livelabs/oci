# Creating the directory and installing the application

### Step 1: Creating the Directory: Installing the requirements

```
pip install -r requirements.txt
```

![requirements](/edge-cloud/ai-edge-rover/installing_application/images/requirements.jpg)



<br>

![Install Directory](/edge-cloud/ai-edge-rover/installing_application/images/11_installrequirements.png)



### Step 2: Create an embedding function as embed_data.py

```
from langchain_community.embeddings.ollama import OllamaEmbeddings

def embed_data():
    embeddings = OllamaEmbeddings(model="all-minilm") #Update to use any embedding model
    return embeddings

```
<br>

![Embedding Function](/edge-cloud/ai-edge-rover/installing_application/images/13_create_embedding_function.png)

### Step 3: Create a python script  load_data.py the database 

```
import os
import shutil
from langchain_community.document_loaders.pdf import PyPDFDirectoryLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.schema.document import Document
from embed_data import embed_data
from langchain.vectorstores.chroma import Chroma

CHROMA_PATH = "chroma"
DATA_PATH = "data"

def clear_database():
    if os.path.exists(CHROMA_PATH):
        shutil.rmtree(CHROMA_PATH)

def load_documents():
    document_loader = PyPDFDirectoryLoader(DATA_PATH)
    documents = document_loader.load()
    print(f"Loaded {len(documents)} documents")
    for doc in documents:
        print(doc.page_content[:500])  
    return documents

def split_documents(documents: list[Document]):
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=1500,
        chunk_overlap=100,
        length_function=len,
        is_separator_regex=False,
    )
    chunks = text_splitter.split_documents(documents)
    print(f"Split into {len(chunks)} chunks")
    return chunks

def add_to_chroma(chunks: list[Document]):
    db = Chroma(
        persist_directory=CHROMA_PATH, embedding_function=embed_data()
    )
    chunks_with_ids = calculate_chunk_ids(chunks)
    existing_items = db.get(include=[])
    existing_ids = set(existing_items["ids"])
    print(f"Number of existing documents in DB: {len(existing_ids)}")

    new_chunks = [chunk for chunk in chunks_with_ids if chunk.metadata["id"] not in existing_ids]
    
    if new_chunks:
        print(f"Adding new documents: {len(new_chunks)}")
        new_chunk_ids = [chunk.metadata["id"] for chunk in new_chunks]
        db.add_documents(new_chunks, ids=new_chunk_ids)
        db.persist()
        print(f"Documents Added")
    else:
        print("No new documents to add")

def calculate_chunk_ids(chunks):
    last_page_id = None
    current_chunk_index = 0
    for chunk in chunks:
        source = chunk.metadata.get("source")
        page = chunk.metadata.get("page")
        current_page_id = f"{source}:{page}"
        if current_page_id == last_page_id:
            current_chunk_index += 1
        else:
            current_chunk_index = 0
        chunk_id = f"{current_page_id}:{current_chunk_index}"
        last_page_id = current_page_id
        chunk.metadata["id"] = chunk_id
    return chunks

```
<br>

![Install DB](/edge-cloud/ai-edge-rover/installing_application/images/12_populate_database.png)




### Step 4: Create a script to query the dat as query_data.py

```
from langchain.vectorstores.chroma import Chroma
from langchain.prompts import ChatPromptTemplate
from langchain_community.llms.ollama import Ollama
from embed_data import embed_data

CHROMA_PATH = "chroma"

PROMPT_TEMPLATE = """
Answer the question based only on the following context:

{context}

---

Answer the question based on the above context: {question}
"""

def query_rag(query_text: str):
    embedding_function = embed_data()
    db = Chroma(persist_directory=CHROMA_PATH, embedding_function=embedding_function)

    results = db.similarity_search_with_score(query_text, k=5)
    print(f"Found {len(results)} results")
    for i, (doc, score) in enumerate(results):
        print(f"Result {i+1}:")
        print(f"Score: {score}")
        print(doc.page_content[:500])  

    context_text = "\n\n---\n\n".join([doc.page_content for doc, _score in results])
    prompt_template = ChatPromptTemplate.from_template(PROMPT_TEMPLATE)
    prompt = prompt_template.format(context=context_text, question=query_text)

    model = Ollama(model="mistral") #Update to use any LLM
    response_text = model.invoke(prompt)

    #sources = [doc.metadata.get("id", None) for doc, _score in results]
    formatted_response = f"{response_text}"
    return formatted_response


```
<br>

![Querying Data](/edge-cloud/ai-edge-rover/installing_application/images/14_create_script.png)

### Step 5: Create the main program as app.py

```
import streamlit as st
import os
from load_data import load_documents, split_documents, add_to_chroma, clear_database
from query_data import query_rag

DATA_PATH = "data"
if not os.path.exists(DATA_PATH):
    os.makedirs(DATA_PATH)

def save_uploaded_file(uploaded_file):
    with open(os.path.join(DATA_PATH, uploaded_file.name), "wb") as f:
        f.write(uploaded_file.getbuffer())
    return st.success(f"File {uploaded_file.name} saved successfully!")

def main():
    st.title("RagBot")



    if "query_history" not in st.session_state:
        st.session_state.query_history = []

    if st.button("Reset Database"):
        clear_database()
        st.session_state.query_history.clear()  
        st.success("Database cleared successfully!")

    uploaded_file = st.file_uploader("Choose a document", type=["pdf", "txt", "docx"])

    if uploaded_file is not None:
        save_uploaded_file(uploaded_file)

        if st.button("Process and Add to Database"):
            documents = load_documents()
            chunks = split_documents(documents)
            add_to_chroma(chunks)
            st.success("Document processed and added to database successfully!")

    query_text = st.text_input("Enter your query:")

    if st.button("Submit Query") and query_text:
        try:
            response = query_rag(query_text)
            st.write(f"**Response:** {response}")
            st.session_state.query_history.insert(0, {"query": query_text, "response": response})
        except Exception as e:
            st.error(f"An error occurred: {e}")

    if len(st.session_state.query_history) > 1:
        st.subheader("Previous Queries:")
        for i, entry in enumerate(st.session_state.query_history[1:], start=1):
            st.write(f"**Query:** {entry['query']}")
            st.write(f"**Response:** {entry['response']}")
            st.write("---")

    st.markdown("<hr>", unsafe_allow_html=True) 
    st.markdown("<p style='text-align: center; color: grey;'>Powered by Oracle Roving Edge Infrastructure</p>", unsafe_allow_html=True)

if __name__ == "__main__":
    main()


```
<br>

![Main program](/edge-cloud/ai-edge-rover/installing_application/images/16_creat_program.png)

### Step 6: Create a directory called data to load and store the pdfs


### Step 7: Running the RagBot program as streamlit run app.py
![Run RagBot](/edge-cloud/ai-edge-rover/installing_application/images/17_run_ragbot.png)
