import re

with open('/home/pawel/pyradio.log', 'r') as f:
    data = f.read()
    print(re.findall(r"Title.+", data)[-1][7:-1])
