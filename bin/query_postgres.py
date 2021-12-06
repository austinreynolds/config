import sys
import os
import yaml
import argparse

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('query', metavar='q', type=str, help='your query')
    return parser.parse_args()

def read_dbt_profile():
    profile_path = os.environ.get('HOME')
    profile_path = os.path.join(profile_path, '.dbt/profiles.yml')
    with open(profile_path) as p:
        con_details = yaml.load(p, Loader=yaml.FullLoader)
    return con_details['pg_data']['outputs']['dev']

def form_query_string(con_dict, query):
    #PGPASSWORD=asdf psql -h 192.168.1.158 -U postgres -d stonks -c 'select * from sharadar_raw.sep limit 10' 
    query = "\'" + query + "\'"
    qstr = """PGPASSWORD={pass} psql -h {host} -U {user} -d {dbname} -c""".format(**con_dict)
    qstr = ' '.join([qstr, query])
    return qstr

if __name__ == '__main__': 
    args = parse_args()
    con_dict = read_dbt_profile()
    qstr = form_query_string(con_dict, args.query)
    os.system(qstr)
