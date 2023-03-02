# from typing import Dict

# from pandas import DataFrame
# from sqlalchemy.engine.base import Engine


def load(data_frames, database):
    """
    Load the dataframes into the sqlite database.
    Args:
        dataFrames (Dict[str, DataFrame]): A dictionary with keys as the table names
        and values as the dataframes.
    """
    for table_name, df in data_frames.items():
        df.to_sql(table_name, database, if_exists='replace', index=False)