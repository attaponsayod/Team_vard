import streamlit as st
from connect_data_warehouse import query_job_lisings

def layout():
    df = query_job_lisings()

    st.title("Data engineering job ads")
    st.write("This dashboard shows data engineering job ads from arbetsförmedlingen APi")

    st.dataframe(df)

if __name__ == "__main__":
    layout()


