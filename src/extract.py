from typing import Dict
import requests
from pandas import DataFrame, read_csv, read_json, to_datetime


def get_public_holidays(public_holidays_url, year):
    """
    Get the public holidays for the given year for Brazil.
    Args:
        public_holidays_url (str): url to the public holidays.
        year (str): The year to get the public holidays for.

    Raises:
        SystemExit: If the request fails.

    Returns:
        DataFrame: A dataframe with the public holidays.
    """
    try:
        # The url is {public_holidays_url}/{year}/BR.
        url = f'{public_holidays_url}/{year}/BR'
        response = requests.get(url)
        holidays = response.json()
        df = DataFrame(holidays)
        # Delete the columns "types" and "counties" from the dataframe.
        df.drop(columns=['types', 'counties'], inplace=True)
        # Convert the "date" column to datetime.
        df['date'] = to_datetime(df['date'])
        # Raise a SystemExit if the request fails.
        return df
    except requests.exceptions.RequestException as e:
        raise SystemExit(e)


def extract(csv_folder, csv_table_mapping, public_holidays_url):
    """
    Extract the data from the csv files and load them into the dataframes.
    Args:
        csv_folder (str): The path to the csv's folder.
        csv_table_mapping (Dict[str, str]): The mapping of the csv file names to the
        table names.
        public_holidays_url (str): The url to the public holidays.
    Returns:
        Dict[str, DataFrame]: A dictionary with keys as the table names and values as
        the dataframes.
    """
    dataframes = {
        table_name: read_csv(f"{csv_folder}/{csv_file}")
        for csv_file, table_name in csv_table_mapping.items()
    }

    holidays = get_public_holidays(public_holidays_url, "2017")

    dataframes["public_holidays"] = holidays

    return dataframes