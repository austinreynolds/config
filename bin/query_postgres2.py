import sys
import os
import yaml
import fileinput

def read_query():
    qstr = ''
    for line in sys.stdin:
        qstr += line
    return qstr
#    return ' '.join(sys.argv[1:])

def read_dbt_profile():
    profile_path = os.environ.get('HOME')
    profile_path = os.path.join(profile_path, '.dbt/profiles.yml')
    with open(profile_path) as p:
        con_details = yaml.load(p, Loader=yaml.FullLoader)
    return con_details['pg_data']['outputs']['dev']

def form_query_string(dbt_profile, query):
    #PGPASSWORD=asdf psql -h 192.168.1.158 -U postgres -d stonks -c 'select * from sharadar_raw.sep limit 10' 
    query = "\'" + query + "\'"
    qstr = """PGPASSWORD={pass} psql -h {host} -U {user} -d {dbname} -c""".format(**dbt_profile)
    qstr = ' '.join([qstr, query])
    return qstr

if __name__ == '__main__': 
    query = read_query()
    dbt_profile = read_dbt_profile()
    qstr = form_query_string(dbt_profile, query)
    print(qstr)
#    os.system(qstr)

