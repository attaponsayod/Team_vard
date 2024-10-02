import streamlit as st
from connect_data_warehouse import query_job_listings

def home_page():
    """Display the Home page."""
    st.title("Health Care Job Ads Dashboard")
    st.write("Welcome to the Health Care Job Ads Dashboard.")
    st.write(
        "Use the menu on the left to navigate between the Home page, Job Listings Data, and the Data section."
    )

def job_listings_page():
    """Display the Job Listings Data page."""
    # Fetch job listings data
    df = query_job_listings()

    # Page Title
    st.title("Health care job ads")
    st.write("This dashboard shows health care job ads from arbetsförmedlingen API")

    # Display metrics
    st.markdown("## Vacancies")
    cols = st.columns(3)

    with cols[0]:
        st.metric(label="Total", value=df["VACANCIES"].sum())

    with cols[1]:
        st.metric(
            label="In Stockholm",
            value=df.query("WORKPLACE_CITY == 'Stockholm'")["VACANCIES"].sum(),
        )

    # Display Data by City and Company
    cols = st.columns(2)

    with cols[0]:
        st.markdown("### Per city")
        st.dataframe(
            query_job_listings(
                """
                SELECT
                    SUM(vacancies) as vacancies,
                    workplace_city
                FROM 
                    mart_job_listings
                GROUP BY
                    workplace_city
                ORDER BY 
                    vacancies DESC;
                """
            )
        )

    with cols[1]:
        st.markdown("### Per company (top 5)")
        st.bar_chart(
            query_job_listings(
                """
                SELECT
                    SUM(vacancies) as vacancies,
                    employer_name
                FROM 
                    mart_job_listings
                GROUP BY
                    employer_name
                ORDER BY 
                    vacancies DESC LIMIT 5;
                """
            ),
            x="EMPLOYER_NAME",
            y="VACANCIES",
        )

    # Advertisement Selection
    st.markdown("## Find advertisement")
    cols = st.columns(2)

    with cols[0]:
        selected_company = st.selectbox("Select a company:", df["EMPLOYER_NAME"].unique())

    with cols[1]:
        selected_headline = st.selectbox(
            "Select an advertisement:", df.query("EMPLOYER_NAME == @selected_company")["HEADLINE"],
        )

    # Show the job ad description
    st.markdown("### Job ad")
    job_ad = df.query("HEADLINE == @selected_headline and EMPLOYER_NAME == @selected_company")

    # Display DESCRIPTION_HTML_FORMATTED
    st.markdown(
        job_ad["DESCRIPTION_HTML_FORMATTED"].values[0],
        unsafe_allow_html=True,
    )

    # Display DESCRIPTION_CONDITIONS
    if "DESCRIPTION_CONDITIONS" in job_ad.columns:
        st.markdown("### Job Conditions")
        st.markdown(
            job_ad["DESCRIPTION_CONDITIONS"].values[0],
            unsafe_allow_html=True,
        )

def data_page():

    # Fetch job listings data
    df = query_job_listings()

    # Display job listings data directly
    st.markdown("## Job Listings Data")
    st.dataframe(df)

def layout():
    
    # Initialize session state to track the current page
    if "current_page" not in st.session_state:
        st.session_state.current_page = "Home"

    # Sidebar menu for navigation
    st.sidebar.title("Menu")
    page = st.sidebar.radio("Navigate", ["Home", "Job Listings Data", "Data"])

    # Update session state based on radio button selection
    st.session_state.current_page = page

    # Render the selected page
    if st.session_state.current_page == "Home":
        home_page()
    elif st.session_state.current_page == "Job Listings Data":
        job_listings_page()
    elif st.session_state.current_page == "Data":
        data_page()

if __name__ == "__main__":
    layout()
