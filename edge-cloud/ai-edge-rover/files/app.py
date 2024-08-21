import streamlit as st
import os
from populate_database import load_documents, split_documents, add_to_chroma, clear_database
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

    if st.button("Reset Database"):
        clear_database()
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
            st.write(response)
        except Exception as e:
            st.error(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
