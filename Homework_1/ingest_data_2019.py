import pandas as pd
from sqlalchemy import create_engine


def main():
    print("Inside main func")
    #1st download the data, dp the same for zones also 
    # args = parser.parse_args()
    # response = requests.get(args.url_csv)
    # with open("output.csv","wb") as f:
    #     f.write(response)
    # print("downloaded and wrote the csv data") 
    # data_tbl_name = parser.table_name_data
    # zones_tbl_name = parser.table_name_zone


    df_data = pd.read_csv('green_tripdata_2019-10.csv')
    print(pd.io.sql.get_schema(df_data,name="green_trip_data"))

    engine = create_engine(f'postgresql://root:root@localhost:5432/green_taxi') 
    engine.connect()      
    #df_data.to_sql(name="green_trip",con=engine,if_exists='replace') 

    df_data = pd.read_csv('green_tripdata_2019-10.csv',iterator=True,chunksize=100000)
    for chunk in df_data:
        print(f"processing for a chunksize of :{len(chunk)}")
        chunk.lpep_pickup_datetime = pd.to_datetime(chunk.lpep_pickup_datetime)
        chunk.lpep_dropoff_datetime=pd.to_datetime(chunk.lpep_dropoff_datetime)
        #print("converted the datetime")
        chunk.to_sql(name="green_trip_data",con=engine,if_exists='append') 

    print("completed ingesting data")

    print("Reading the zone and writing to db")
    df_zone = pd.read_csv('taxi_zone_lookup.csv')
    #print(pd.io.sql.get_schema(df_zone,name="zone_green_taxi"))
    print(pd.io.sql.get_schema(df_zone,name="zone_green_taxi",con=engine))
    df_zone.to_sql(name="zone_green_taxi",con=engine,if_exists='replace') 
    print("completed writing the zone data")

if __name__=="__main__":
    main()